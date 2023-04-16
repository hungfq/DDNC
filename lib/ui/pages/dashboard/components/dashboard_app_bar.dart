import 'package:ddnc_new/commons/constants.dart';
import 'package:ddnc_new/commons/extensions.dart';
import 'package:ddnc_new/ui/components/app_change_notifier_provider.dart';
import 'package:ddnc_new/ui/components/components.dart';
import 'package:ddnc_new/ui/components/primary_app_bar.dart';
import 'package:ddnc_new/ui/components/primary_btn_menu.dart';
import 'package:ddnc_new/ui/data/account.dart';
import 'package:ddnc_new/ui/resources/app_transitions.dart';
import 'package:ddnc_new/ui/resources/assets.dart';
import 'package:ddnc_new/ui/resources/dimens.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'dashboard_account_info.dart';

const double searchBoxHeight = 52.0;

class DashboardAppBar extends StatelessWidget {
  const DashboardAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double panelHeight = screenHeight * .2;

    return SliverAppBar(
      pinned: true,
      stretch: true,
      elevation: 0.0,
      titleSpacing: 0,
      backgroundColor: Colors.transparent,
      expandedHeight: panelHeight,
      // toolbarHeight: Dimens.textFieldHeight + Dimens.marginPaddingSizeSmall,
      flexibleSpace: LayoutBuilder(
        builder: (context, constraints) {
          return FlexibleSpaceBar(
            expandedTitleScale: 1.0,
            background: Container(
              height: panelHeight,
              decoration: BoxDecoration(
                gradient: Components.primaryGradient,
                borderRadius:
                const BorderRadius.vertical(bottom: Radius.circular(30.0)),
                image: DecorationImage(
                  image: const ExtendedAssetImageProvider(
                      Assets.bgDashboardHeader),
                  fit: BoxFit.cover,
                  colorFilter: ColorFilter.mode(
                      Colors.black.withOpacity(0.15), BlendMode.dstATop),
                ),
              ),
            ),
            collapseMode: CollapseMode.pin,
            titlePadding: EdgeInsets.zero,
            title: AnimatedSwitcher(
              switchInCurve: Constants.defaultCurve,
              switchOutCurve: Constants.defaultCurve,
              duration: const Duration(milliseconds: Constants.animationDuration),
              transitionBuilder: AppTransitions.fadeTransition,
              child: constraints.maxHeight < panelHeight
                  ? const DashboardCollapsedAppBar()
                  : const DashboardAccountInfo(),
            ),
          );
        },
      ),

    );
  }
}

class DashboardCollapsedAppBar extends StatelessWidget {
  const DashboardCollapsedAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var _theme = Theme.of(context);
    var _account = context.read<AccountInfo>();

    return PrimaryAppBar(
      title: "",
      backgroundColor: _theme.primaryColor,
      shapeBorder: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          bottom: Radius.circular(Dimens.largeComponentRadius),
        ),
      ),
      titleSpacing: Dimens.marginPaddingSizeMini,
      actions: const [
        PrimaryBtnMenu(),
      ],
      titleWidget: AppChangeNotifierProvider<AccountInfo>(
        value: _account,
        builder: (context, account, child) {
          var accountInfo = account.accountInfo;
          return GestureDetector(
            behavior: HitTestBehavior.translucent,
            // onTap: () {
            //   if (NavigationService.instance.currentRoute?.route ==
            //       AppPages.profilePage) return;
            //   NavigationService.instance.pushNamedAndRemoveUntil(
            //       AppPages.profilePage,
            //       predicate: (route) => route.isFirst);
            // },
            child: Row(
              children: [
                Container(
                  width: kToolbarHeight - Dimens.marginPaddingSizeXMini,
                  height: kToolbarHeight - Dimens.marginPaddingSizeXMini,
                  padding: const EdgeInsets.all(2),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      width: 2.0,
                      color: _theme.colorScheme.secondary,
                    ),
                  ),
                  child: CircleAvatar(
                    backgroundImage: accountInfo == null ||
                        accountInfo.picture.isNullOrEmpty()
                        ? const ExtendedAssetImageProvider(Assets.icUser)
                        : ExtendedNetworkImageProvider(accountInfo.picture!)
                    as ImageProvider,
                  ),
                ),
                const SizedBox(width: Dimens.marginPaddingSizeXMini),
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '${"Hello"},',
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: _theme.textTheme.bodyMedium!
                              .copyWith(color: _theme.colorScheme.onPrimary),
                        ),
                        Text(
                          accountInfo?.name ?? "",
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: _theme.textTheme.bodyLarge!.copyWith(
                              color: _theme.colorScheme.onPrimary,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
