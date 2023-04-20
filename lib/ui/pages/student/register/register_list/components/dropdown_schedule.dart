import 'package:ddnc_new/api/response/list_schedule_response.dart';
import 'package:ddnc_new/ui/components/primary_dropdown_button_form_field.dart';
import 'package:ddnc_new/ui/components/primary_text_view.dart';
import 'package:ddnc_new/ui/pages/student/register/register_list/blocs/register_list_bloc.dart';
import 'package:ddnc_new/ui/resources/dimens.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DropdownSchedule extends StatefulWidget with PreferredSizeWidget {
  DropdownSchedule({super.key});

  @override
  State<DropdownSchedule> createState() => _DropdownScheduleState();

  @override
  Size get preferredSize => const Size.fromHeight(
      Dimens.textFieldHeight + Dimens.marginPaddingSizeXXXMini);
}

class _DropdownScheduleState extends State<DropdownSchedule> {
  late RegisterListBloc _registerListBloc;

  late List<ScheduleInfo> _schedules = [];

  @override
  void initState() {
    _registerListBloc = context.read<RegisterListBloc>();
    _fetchData();
    super.initState();
  }

  _fetchData() async {
    var data = await _registerListBloc.forceFetchRegisterSchedule();
    setState(() {
      _schedules = data;
    });
  }

  @override
  Widget build(BuildContext context) {
    ScheduleInfo? dropdownValue = _schedules.length > 0 ? _schedules.first : null;
    return Container(
        margin: const EdgeInsets.fromLTRB(
          Dimens.marginPaddingSizeXMini,
          0,
          Dimens.marginPaddingSizeXMini,
          Dimens.marginPaddingSizeXMini,
        ),
        child: PrimaryDropdownButtonFormField<ScheduleInfo>(
          value: dropdownValue,
          labelText: "Schedule",
          items: _schedules.map((schedule) {
            return DropdownMenuItem(
              value: schedule,
              child: PrimaryTextView(schedule.code),
            );
          }).toList(),
          // onChanged: (ScheduleInfo? selectedWarehouse) =>
          //     _onWarehouseChanged(selectedWarehouse, schedule),
        ));
  }
}
