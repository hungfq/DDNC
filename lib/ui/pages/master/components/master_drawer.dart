import 'dart:async';

import 'package:ddnc_new/commons/app_page.dart';
import 'package:ddnc_new/commons/constants.dart';
import 'package:ddnc_new/models/dashboard_menu.dart';
import 'package:ddnc_new/models/page_info.dart';
import 'package:ddnc_new/modules/navigation/navigation_service.dart';
import 'package:ddnc_new/ui/components/components.dart';
import 'package:ddnc_new/ui/components/primary_animated_listview/src/implicitly_animated_list.dart';
import 'package:ddnc_new/ui/components/primary_animated_listview/src/transitions/size_fade_transition.dart';
import 'package:ddnc_new/ui/components/primary_text_view.dart';
import 'package:ddnc_new/ui/pages/master/blocs/master_bloc.dart';
import 'package:ddnc_new/ui/pages/master/blocs/master_state.dart';
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
          Expanded(
            child: _Body(),
          ),
        ],
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
                vertical: Dimens.marginPaddingSizeSmall,
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
      case AppPages.homePage:
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
            const SizedBox(width: Dimens.marginPaddingSizeXMini),
            Expanded(
              child: PrimaryTextView(
                menu?.title,
                style: _theme.textTheme.titleSmall!.apply(
                  color: isSelected ? _onPrimaryColor : _onSurfaceColor,
                ),
              ),
            ),
            const SizedBox(width: Dimens.marginPaddingSizeXMini),
          ],
        ),
      ),
    );
  }
}
