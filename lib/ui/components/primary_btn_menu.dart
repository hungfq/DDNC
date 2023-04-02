import 'package:ddnc_new/ui/pages/master/blocs/master_bloc.dart';
import 'package:ddnc_new/ui/resources/dimens.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PrimaryBtnMenu extends StatelessWidget {
  const PrimaryBtnMenu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: context.read<MasterBloc>().onDrawerMenuClicked,
      behavior: HitTestBehavior.translucent,
      child: const Padding(
        padding: EdgeInsets.symmetric(
          horizontal: Dimens.marginPaddingSizeXMini,
        ),
        child: Icon(
          Icons.menu_rounded,
        ),
      ),
    );
  }
}
