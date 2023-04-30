import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:ddnc_new/commons/constants.dart';
import 'package:ddnc_new/models/dashboard_menu.dart';
import 'package:ddnc_new/modules/navigation/navigation_service.dart';
import 'package:ddnc_new/ui/base/base_page_state.dart';
import 'package:ddnc_new/ui/components/primary_btn_menu.dart';
import 'package:ddnc_new/ui/components/primary_sliver_app_bar.dart';
import 'package:ddnc_new/ui/components/primary_text_view.dart';
import 'package:ddnc_new/ui/pages/master/blocs/master_bloc.dart';
import 'package:ddnc_new/ui/pages/master/blocs/master_state.dart';
import 'package:ddnc_new/ui/resources/dimens.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'blocs/dashboard_bloc.dart';
import 'components/dashboard_app_bar.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({Key? key}) : super(key: key);

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> with BasePageState {
  late MasterBloc _masterBloc;
  late DashboardBloc _dashboardBloc;
  late ScrollController _scrollController = ScrollController();

  List<DashboardMenu> get _menuItems => _masterBloc.dashboardMenus;

  @override
  void initState() {
    _masterBloc = context.read<MasterBloc>();
    _dashboardBloc = context.read<DashboardBloc>();

    _scrollController = ScrollController()
      ..addListener(() {
        if (_scrollController.position.userScrollDirection ==
            ScrollDirection.reverse) {
          _dashboardBloc.hideFooter.value = false;
        } else if (_scrollController.position.userScrollDirection ==
            ScrollDirection.forward) {
          _dashboardBloc.hideFooter.value = true;
        }
      });
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _dashboardBloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
        controller: _scrollController,
        // headerSliverBuilder: (_, __) => [
        //   const PrimarySliverAppBar(
        //     title: "Dashboard",
        //     pinned: true,
        //     floating: true,
        //     actions: [
        //       PrimaryBtnMenu(),
        //     ],
        //   ),
        // ],
        headerSliverBuilder: (_, __) => [
          const DashboardAppBar(),
        ],
        body: BlocBuilder<MasterBloc, MasterState>(
          builder: (_, state) {
            return GridView.builder(
              padding: const EdgeInsets.symmetric(
                horizontal: Dimens.marginPaddingSizeXXMini,
                vertical: Dimens.marginPaddingSizeXXMini,
              ),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: Dimens.marginPaddingSizeXXMini,
                crossAxisSpacing: Dimens.marginPaddingSizeXXMini,
                childAspectRatio: 1.5,
              ),
              itemBuilder: (context, index) {
                var menuItem = _menuItems[index];
                return _DashboardItem(
                  menuItem: menuItem,
                  onClicked: _onMenuClicked,
                );
              },
              itemCount: _menuItems.length,
            );
          },
        ),
      ),
      bottomNavigationBar: const _Footer(),
    );
  }

  void _onMenuClicked(DashboardMenu item) {
    NavigationService.instance.pushNamed(item.pageRoute);
  }
}

class _Footer extends StatelessWidget {
  const _Footer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    DashboardBloc _bloc = context.read<DashboardBloc>();

    return AnimatedSize(
      duration: const Duration(milliseconds: Constants.animationDuration),
      curve: Constants.defaultCurve,
      alignment: Alignment.bottomCenter,
      child: ValueListenableBuilder<bool>(
        valueListenable: _bloc.hideFooter,
        builder: (_, isHide, child) {
          return Visibility(
            visible: isHide,
            child: child ?? const SizedBox.shrink(),
          );
        },
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(
            vertical: Dimens.marginPaddingSizeXXXTiny,
          ),
          decoration: BoxDecoration(
            color: theme.colorScheme.surface,
            border: Border(
              top: BorderSide(
                color: theme.dividerColor,
              ),
            ),
          ),
          child: SafeArea(
            child: DefaultTextStyle(
              style: theme.textTheme.titleMedium!.apply(
                color: theme.colorScheme.onBackground,
                fontSizeFactor: 0.8,
                fontWeightDelta: 2
              ),
              textAlign: TextAlign.center,
              maxLines: 1,
              overflow: TextOverflow.fade,
              child: AnimatedTextKit(
                animatedTexts: [
                  TyperAnimatedText(
                    "HCMC University of Technology and Education",
                    textAlign: TextAlign.center,
                  ),
                  TyperAnimatedText(
                    "Faculty of Information Technology",
                    textAlign: TextAlign.center,
                  ),
                ],
                repeatForever: true,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _DashboardItem extends StatelessWidget {
  const _DashboardItem({
    Key? key,
    required this.menuItem,
    required this.onClicked,
  }) : super(key: key);

  final DashboardMenu menuItem;
  final Function(DashboardMenu) onClicked;

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    double screenWidth = MediaQuery.of(context).size.width;
    double itemWidth = screenWidth * .5;
    double imageWidth = itemWidth * .8;

    return GestureDetector(
      onTap: () => onClicked.call(menuItem),
      behavior: HitTestBehavior.translucent,
      child: Container(
        decoration: BoxDecoration(
          // color: theme.colorScheme.surface,
          color: theme.colorScheme.onPrimary,
          borderRadius: const BorderRadius.all(
              Radius.circular(Dimens.largeComponentRadius)),
          border: Border.all(
            color: theme.dividerColor,
          ),
        ),
        child: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                // color: theme.colorScheme.onPrimary,
                color: theme.colorScheme.surface,
                borderRadius: const BorderRadius.all(
                    Radius.circular(Dimens.largeComponentRadius)),
                border: Border.all(
                  color: theme.dividerColor,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: Dimens.marginPaddingSizeMini,
                vertical: Dimens.marginPaddingSizeMini,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: ExtendedImage.asset(
                      menuItem.imageUrl ?? "",
                      width: imageWidth,
                      height: imageWidth,
                      fit: BoxFit.contain,
                    ),
                  ),
                  PrimaryTextView(
                    menuItem.title,
                    maxLines: 3,
                    style: theme.textTheme.bodyMedium!.apply(
                      color: theme.primaryColor,
                    ),
                    isBold: true,
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
