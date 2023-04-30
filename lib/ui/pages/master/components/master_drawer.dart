import 'dart:async';

import 'package:ddnc_new/commons/app_page.dart';
import 'package:ddnc_new/commons/constants.dart';
import 'package:ddnc_new/commons/extensions.dart';
import 'package:ddnc_new/models/dashboard_menu.dart';
import 'package:ddnc_new/models/page_info.dart';
import 'package:ddnc_new/modules/navigation/navigation_service.dart';
import 'package:ddnc_new/ui/components/app_change_notifier_provider.dart';
import 'package:ddnc_new/ui/components/components.dart';
import 'package:ddnc_new/ui/components/primary_animated_listview/src/implicitly_animated_list.dart';
import 'package:ddnc_new/ui/components/primary_animated_listview/src/transitions/size_fade_transition.dart';
import 'package:ddnc_new/ui/components/primary_text_view.dart';
import 'package:ddnc_new/ui/data/account.dart';
import 'package:ddnc_new/ui/pages/master/blocs/master_bloc.dart';
import 'package:ddnc_new/ui/pages/master/blocs/master_state.dart';
import 'package:ddnc_new/ui/resources/assets.dart';
import 'package:ddnc_new/ui/resources/dimens.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rxdart/rxdart.dart';

class MasterDrawer extends StatefulWidget {
  const MasterDrawer({Key? key}) : super(key: key);

  @override
  State<MasterDrawer> createState() => _MasterDrawerState();
}

class _MasterDrawerState extends State<MasterDrawer> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          _Header(),
          Expanded(
            child: _Body(),
          ),
          _Footer(),
        ],
      ),
    );
  }
}

class _Header extends StatelessWidget {
  const _Header({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var _theme = Theme.of(context);
    var _account = context.read<AccountInfo>();
    return DrawerHeader(
      margin: EdgeInsets.zero,
      padding:
          const EdgeInsets.symmetric(horizontal: Dimens.marginPaddingSizeXMini),
      decoration: const BoxDecoration(
        gradient: Components.primaryGradient,
      ),
      duration: const Duration(milliseconds: Constants.animationDuration),
      child: AppChangeNotifierProvider<AccountInfo>(
        value: _account,
        builder: (context, account, child) {
          var accountInfo = account.accountInfo;
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GestureDetector(
                behavior: HitTestBehavior.translucent,
                child: Row(
                  children: [
                    Container(
                      width: Dimens.drawerHeaderAvatarSize,
                      height: Dimens.drawerHeaderAvatarSize,
                      padding: const EdgeInsets.all(2),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: _theme.colorScheme.secondary,
                          width: 2.0,
                        ),
                      ),
                      child: CircleAvatar(
                        backgroundImage: accountInfo == null ||
                                accountInfo.picture.isNullOrEmpty()
                            ? const AssetImage(Assets.icUser)
                            : NetworkImage(accountInfo.picture!)
                                as ImageProvider,
                      ),
                    ),
                    const SizedBox(width: Dimens.marginPaddingSizeXMini),
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            accountInfo?.name ?? "",
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: _theme.textTheme.titleLarge!.copyWith(
                                color: _theme.colorScheme.onPrimary,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

class _Footer extends StatelessWidget {
  const _Footer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var _theme = Theme.of(context);
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(
        vertical: Dimens.marginPaddingSizeMini,
        horizontal: Dimens.marginPaddingSizeXMini,
      ),
      decoration: BoxDecoration(
        color: _theme.colorScheme.surface,
        border: Border(
          top: BorderSide(
            width: 1,
            color: _theme.dividerColor,
          ),
        ),
      ),
      child: PrimaryTextView(
        "${"Version"}: 1.0.0 - BETA",
        style: _theme.textTheme.caption!.apply(
          color: _theme.colorScheme.onBackground,
        ),
        isBold: true,
      ),
    );
  }
}

class _Body extends StatefulWidget {
  const _Body({Key? key}) : super(key: key);

  @override
  State<_Body> createState() => _BodyState();
}

class _BodyState extends State<_Body> {
  late StreamSubscription<PageInfo?> _pageInfoStream;
  late final BehaviorSubject<PageInfo?> _pageInfoSub =
      BehaviorSubject<PageInfo?>();

  late MasterBloc _masterBloc;

  @override
  void initState() {
    _masterBloc = context.read<MasterBloc>();
    var routeObs = NavigationService.instance.routeObserver;
    _pageInfoSub.sink.add(routeObs.currentRoute);
    _pageInfoStream = routeObs.pageInfoStream.listen((event) => event);
    _pageInfoStream.onData((data) => _pageInfoSub.sink.add(data));
    super.initState();
  }

  @override
  void dispose() {
    _pageInfoStream.cancel();
    _pageInfoSub.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MasterBloc, MasterState>(
      buildWhen: (_, state) => state is MasterMenuFetchedState,
      builder: (_, state) {
        var menus = _masterBloc.sideMenus;

        return StreamBuilder<PageInfo?>(
          initialData: null,
          stream: _pageInfoSub.stream,
          builder: (context, snapshot) {
            var currentRoute = snapshot.data?.route ?? "";

            return ImplicitlyAnimatedList<DashboardMenu>(
              key: _masterBloc.pageStorageKey,
              padding: const EdgeInsets.symmetric(
                vertical: Dimens.marginPaddingSizeXMini,
                horizontal: Dimens.marginPaddingSizeXMini,
              ),
              removeDuration:
                  const Duration(milliseconds: Constants.animationDuration),
              insertDuration:
                  const Duration(milliseconds: Constants.animationDuration),
              updateDuration:
                  const Duration(milliseconds: Constants.animationDuration),
              areItemsTheSame: (a, b) => a.pageRoute == b.pageRoute,
              items: menus,
              itemBuilder: (context, animation, item, index) {
                return SizeFadeTransition(
                  sizeFraction: 0.7,
                  curve: Constants.defaultCurve,
                  animation: animation,
                  child: _MenuItem(
                    menu: item,
                    isSelected: currentRoute == (item.pageRoute) ||
                        item.subPages.contains(currentRoute),
                    onMenuClicked: _onMenuClicked,
                  ),
                );
              },
              removeItemBuilder: (context, animation, oldItem) {
                return FadeTransition(
                  opacity: animation,
                  child: PrimaryTextView(oldItem.title),
                );
              },
            );
          },
        );
      },
    );
  }

  void _onMenuClicked(DashboardMenu? menu) {
    if (menu == null) return;

    switch (menu.pageRoute) {
      case AppPages.dashBoardPage:
        Navigator.of(context).pop();
        NavigationService.instance.popUntilFirst();
        break;
      // case AppPages.signOutPage:
      //   _masterBloc.onSignOutClicked();
      //   break;
      default:
        Navigator.of(context).pop();
        NavigationService.instance.pushNamedAndRemoveUntil(
          menu.pageRoute,
          predicate: (route) => route.isFirst,
        );
        break;
    }
  }
}

class _MenuItem extends StatelessWidget {
  const _MenuItem({
    Key? key,
    required this.menu,
    required this.isSelected,
    required this.onMenuClicked,
  }) : super(key: key);

  final DashboardMenu? menu;
  final bool isSelected;
  final Function(DashboardMenu?) onMenuClicked;

  @override
  Widget build(BuildContext context) {
    var _theme = Theme.of(context);
    Color _onPrimaryColor = _theme.colorScheme.onPrimary;
    Color _onSurfaceColor = _theme.colorScheme.onSurface;

    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: () => onMenuClicked.call(menu),
      child: Container(
        height: Dimens.drawerMenuItemHeight,
        margin: const EdgeInsets.symmetric(
          vertical: Dimens.marginPaddingSizeXXTiny,
        ),
        decoration: BoxDecoration(
          gradient: isSelected ? Components.primaryGradient : null,
          borderRadius:
              const BorderRadius.all(Radius.circular(Dimens.itemListRadius)),
          color: _theme.colorScheme.surface,
        ),
        child: Row(
          children: [
            const SizedBox(width: Dimens.marginPaddingSizeXMini),
            Icon(
              menu?.icon ?? null,
              color: isSelected ? _onPrimaryColor : _theme.primaryColor,
              size: Dimens.iconSize,
            ),
            const SizedBox(width: Dimens.marginPaddingSizeXMini),
            Expanded(
              child: PrimaryTextView(
                menu?.title,
                style: _theme.textTheme.titleSmall!.apply(
                  color: isSelected ? _onPrimaryColor : _onSurfaceColor,
                ),
                isBold: true,
              ),
            ),
            const SizedBox(width: Dimens.marginPaddingSizeXMini),
          ],
        ),
      ),
    );
  }
}
