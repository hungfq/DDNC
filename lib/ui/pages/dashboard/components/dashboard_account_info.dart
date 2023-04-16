import 'package:ddnc_new/commons/extensions.dart';
import 'package:ddnc_new/ui/components/app_change_notifier_provider.dart';
import 'package:ddnc_new/ui/components/widget_circular_animator.dart';
import 'package:ddnc_new/ui/data/account.dart';
import 'package:ddnc_new/ui/pages/master/blocs/master_bloc.dart';
import 'package:ddnc_new/ui/resources/assets.dart';
import 'package:ddnc_new/ui/resources/dimens.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DashboardAccountInfo extends StatelessWidget {
  const DashboardAccountInfo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var _theme = Theme.of(context);
    var _account = context.read<AccountInfo>();

    double screenHeight = MediaQuery.of(context).size.height;
    double panelHeight = screenHeight * .3;
    double avatarSize = panelHeight * .35;

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(Dimens.marginPaddingSizeXXXMini, 0,
            Dimens.marginPaddingSizeXMini, Dimens.textFieldHeight / 2),
        child: AppChangeNotifierProvider<AccountInfo>(
          value: _account,
          builder: (context, account, child) {
            var accountInfo = account.accountInfo;
            return Row(
              children: [
                GestureDetector(
                  behavior: HitTestBehavior.translucent,
                  // onTap: () {
                  //   if (NavigationService.instance.currentRoute?.route ==
                  //       AppPages.profilePage) return;
                  //   NavigationService.instance.pushNamedAndRemoveUntil(
                  //       AppPages.profilePage,
                  //       predicate: (route) => route.isFirst);
                  // },
                  child: WidgetCircularAnimator(
                    size: avatarSize + Dimens.marginPaddingSizeXMini,
                    innerIconsSize: 2,
                    outerIconsSize: 2,
                    innerAnimation: Curves.bounceIn,
                    outerAnimation: Curves.bounceIn,
                    innerColor: _theme.colorScheme.secondary,
                    reverse: false,
                    outerColor: _theme.colorScheme.secondary,
                    innerAnimationSeconds: 10,
                    outerAnimationSeconds: 10,
                    child: Container(
                      width: avatarSize,
                      height: avatarSize,
                      padding: const EdgeInsets.all(2),
                      decoration: BoxDecoration(
                        color: _theme.colorScheme.secondary,
                        shape: BoxShape.circle,
                      ),
                      child: CircleAvatar(
                        backgroundImage: accountInfo == null ||
                                accountInfo.picture.isNullOrEmpty()
                            ? const ExtendedAssetImageProvider(Assets.icUser)
                            : ExtendedNetworkImageProvider(accountInfo.picture!)
                                as ImageProvider,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: Dimens.marginPaddingSizeXMini),
                Expanded(
                  child: GestureDetector(
                    behavior: HitTestBehavior.translucent,
                    // onTap: () {
                    //   if (NavigationService.instance.currentRoute?.route ==
                    //       AppPages.profilePage) return;
                    //   NavigationService.instance.pushNamedAndRemoveUntil(
                    //       AppPages.profilePage,
                    //       predicate: (route) => route.isFirst);
                    // },
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(
                              height: Dimens.marginPaddingSizeXXXTiny),
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
                ),
                GestureDetector(
                  onTap: context.read<MasterBloc>().onDrawerMenuClicked,
                  behavior: HitTestBehavior.translucent,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.9),
                      shape: BoxShape.circle,
                    ),
                    padding:
                        const EdgeInsets.all(Dimens.marginPaddingSizeXXXTiny),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: Dimens.marginPaddingSizeXMini,
                      ),
                      child: Icon(
                        Icons.menu,
                        color: _theme.primaryColor,
                      ),
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
