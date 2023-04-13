import 'package:ddnc_new/models/dashboard_menu.dart';
import 'package:ddnc_new/modules/navigation/navigation_service.dart';
import 'package:ddnc_new/ui/base/base_page_state.dart';
import 'package:ddnc_new/ui/components/primary_btn_menu.dart';
import 'package:ddnc_new/ui/components/primary_sliver_app_bar.dart';
import 'package:ddnc_new/ui/pages/master/blocs/master_bloc.dart';
import 'package:ddnc_new/ui/pages/master/blocs/master_state.dart';
import 'package:ddnc_new/ui/resources/dimens.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({Key? key}) : super(key: key);

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> with BasePageState {
  late MasterBloc _masterBloc;
  final ScrollController _scrollController = ScrollController();

  // late WmsDashboardBloc _wmsDashboardBloc;

  List<DashboardMenu> get _menuItems => _masterBloc.sideMenus;

  @override
  void initState() {
    _masterBloc = context.read<MasterBloc>();
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: NestedScrollView(
      controller: _scrollController,
          headerSliverBuilder: (_, __) => [
            const PrimarySliverAppBar(
              title: "Dashboard",
              pinned: true,
              floating: true,
              actions: [
                PrimaryBtnMenu(),
              ],
            ),
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
    )
        // bottomNavigationBar: const _Footer(),
        );
  }

  void _onMenuClicked(DashboardMenu item) {
    NavigationService.instance.pushNamed(item.pageRoute);
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

    return GestureDetector(
      onTap: () => onClicked.call(menuItem),
      behavior: HitTestBehavior.translucent,
      child: Container(
        decoration: BoxDecoration(
          color: theme.colorScheme.surface,
          borderRadius: const BorderRadius.all(
              Radius.circular(Dimens.largeComponentRadius)),
          border: Border.all(
            color: theme.dividerColor,
          ),
        ),
        child: Stack(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: Dimens.marginPaddingSizeMini,
                vertical: Dimens.marginPaddingSizeXXXTiny,
              ),
              decoration: BoxDecoration(
                color: theme.primaryColor,
                borderRadius: BorderRadius.all(Radius.circular(12)),
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
                  Text(
                    menuItem.title,
                    maxLines: 3,
                    style: theme.textTheme.bodyMedium!.apply(
                      color: Colors.white,
                      fontSizeDelta: 7,
                    ),
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
