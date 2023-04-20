import 'package:ddnc_new/commons/constants.dart';
import 'package:ddnc_new/ui/resources/dimens.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';

class PrimaryDropdownButtonFormField<T> extends StatelessWidget {
  const PrimaryDropdownButtonFormField({
    Key? key,
    this.validateMode,
    this.labelText,
    this.value,
    required this.items,
    this.errorText,
    this.validator,
    this.onChanged,
  }) : super(key: key);

  final AutovalidateMode? validateMode;
  final String? labelText;
  final T? value;
  final List<DropdownMenuItem<T>> items;
  final String? errorText;
  final String? Function(T?)? validator;
  final Function(T?)? onChanged;

  @override
  Widget build(BuildContext context) {
    ThemeData _theme = Theme.of(context);
    return DropdownButtonFormField2<T>(
      value: value,
      isDense: true,
      selectedItemHighlightColor: _theme.colorScheme.primary.withOpacity(.2),
      dropdownDecoration: const BoxDecoration(
        borderRadius:
            BorderRadius.all(Radius.circular(Dimens.mediumComponentRadius)),
      ),
      decoration: InputDecoration(
        labelText: labelText,
        isDense: true,
        errorMaxLines: Constants.errorMaxLines,
        suffixIcon: Icon(
          Icons.keyboard_arrow_down_rounded,
          color: _theme.colorScheme.secondary,
          size: Dimens.iconSize,
        ),
        errorText: errorText,
      ).applyDefaults(_theme.inputDecorationTheme),
      validator: validator,
      autovalidateMode: validateMode,
      icon: const SizedBox.shrink(),
      isExpanded: true,
      items: items,
      onChanged: onChanged,
    );
  }
}
