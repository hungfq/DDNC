import 'package:ddnc_new/commons/constants.dart';
import 'package:ddnc_new/ui/resources/dimens.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'primary_suffix_icon.dart';

class PrimaryFilledTextFormField extends StatelessWidget {
  final Function()? onSubmitCallback;

  // Controller
  final TextInputAction textInputAction;
  final TextInputType keyboardType;
  final TextCapitalization textCapitalization;
  final TextEditingController? textEditingController;
  final TextAlignVertical textAlignVertical;
  final Function()? onEndIconPress;
  final Function()? onClick;
  final FocusNode? currentFocus;
  final FocusNode? nextFocus;
  final AutovalidateMode? autovalidateMode;

  // Icon
  final IconData? prefixIcon;
  final IconData? suffixIcon;
  final Widget? suffixWidget;

  // Text
  final String? labelText;
  final String initialValue;
  final String? errorText;
  final String? suffixText;
  final String? hintText;

  // Constraint
  final List<TextInputFormatter>? inputFormatters;
  final String? Function(String?)? validator;
  final String? Function(String?)? onSaved;
  final Function(String)? onChanged;

  // State
  final bool enabled;
  final bool obscureText;
  final bool isDense;
  final int? maxLines;
  final bool isExpand;
  final bool autoFocus;
  final int? maxLength;
  final bool? readOnly;

  const PrimaryFilledTextFormField({
    Key? key,
    this.textInputAction = TextInputAction.done,
    this.keyboardType = TextInputType.text,
    this.onEndIconPress,
    this.labelText,
    this.initialValue = "",
    this.textAlignVertical = TextAlignVertical.center,
    this.validator,
    this.onSaved,
    this.inputFormatters,
    this.errorText,
    this.enabled = true,
    this.prefixIcon,
    this.suffixIcon,
    this.obscureText = false,
    this.nextFocus,
    this.currentFocus,
    this.textCapitalization = TextCapitalization.none,
    this.isDense = true,
    this.onChanged,
    this.textEditingController,
    this.suffixText = "",
    this.maxLines = 1,
    this.isExpand = false,
    this.onSubmitCallback,
    this.hintText,
    this.onClick,
    this.autoFocus = false,
    this.maxLength,
    this.autovalidateMode,
    this.readOnly,
    this.suffixWidget,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);

    if (onClick != null) {
      return GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTap: onClick,
        child: IgnorePointer(
          ignoring: true,
          child: TextFormField(
            autovalidateMode: autovalidateMode,
            autofocus: autoFocus,
            controller: textEditingController,
            focusNode: currentFocus ?? FocusNode(),
            keyboardType: keyboardType,
            obscureText: obscureText,
            style: theme.textTheme.bodyText1!
                .apply(color: theme.colorScheme.onSurface),
            inputFormatters: inputFormatters,
            textInputAction: textInputAction,
            textAlignVertical: textAlignVertical,
            expands: isExpand,
            validator: validator,
            maxLines: maxLines,
            maxLength: maxLength,
            onSaved: onSaved,
            onChanged: onChanged,
            initialValue: textEditingController != null ? null : initialValue,
            textCapitalization: textCapitalization,
            onFieldSubmitted: (_) {
              onSubmitCallback?.call();
              if (textInputAction == TextInputAction.next) {
                if (nextFocus != null) {
                  currentFocus?.unfocus();
                  FocusScope.of(context).requestFocus(nextFocus);
                } else {
                  FocusScope.of(context).nextFocus();
                }
              }
            },
            decoration: InputDecoration(
              labelText: labelText,
              suffixText: suffixText,
              errorText: errorText,
              hintText: hintText,
              isDense: isDense,
              errorMaxLines: Constants.errorMaxLines,
              prefixIcon: prefixIcon != null
                  ? Icon(
                      prefixIcon,
                      size: Dimens.iconSize,
                    )
                  : null,
              suffixIcon: suffixWidget ??
                  (suffixIcon != null
                      ? PrimarySuffixIcon(
                          icon: suffixIcon!,
                          onClicked: onEndIconPress,
                        )
                      : null),
            ).applyDefaults(theme.inputDecorationTheme),
          ),
        ),
      );
    } else {
      return TextFormField(
        autovalidateMode: autovalidateMode,
        autofocus: autoFocus,
        controller: textEditingController,
        readOnly: readOnly ?? false,
        focusNode: currentFocus ?? FocusNode(),
        keyboardType: keyboardType,
        obscureText: obscureText,
        style: theme.textTheme.bodyText1!.apply(
            color: enabled
                ? theme.colorScheme.onSurface
                : theme.colorScheme.onBackground),
        inputFormatters: inputFormatters,
        textInputAction: textInputAction,
        textAlignVertical: textAlignVertical,
        expands: isExpand,
        validator: validator,
        maxLines: maxLines,
        maxLength: maxLength,
        onSaved: onSaved,
        onChanged: onChanged,
        initialValue: textEditingController != null ? null : initialValue,
        textCapitalization: textCapitalization,
        onFieldSubmitted: (_) {
          onSubmitCallback?.call();
          if (textInputAction == TextInputAction.next) {
            if (nextFocus != null) {
              currentFocus?.unfocus();
              FocusScope.of(context).requestFocus(nextFocus);
            } else {
              FocusScope.of(context).nextFocus();
            }
          }
        },
        decoration: InputDecoration(
          labelText: labelText,
          enabled: enabled,
          suffixText: suffixText,
          hintText: hintText,
          errorText: errorText,
          isDense: isDense,
          errorMaxLines: Constants.errorMaxLines,
          prefixIcon: prefixIcon != null
              ? Icon(
                  prefixIcon,
                  size: Dimens.iconSize,
                )
              : null,
          suffixIcon: suffixWidget != null
              ? suffixWidget
              : suffixIcon != null
                  ? PrimarySuffixIcon(
                      icon: suffixIcon!,
                      onClicked: onEndIconPress,
                    )
                  : null,
        ).applyDefaults(theme.inputDecorationTheme),
      );
    }
  }
}
