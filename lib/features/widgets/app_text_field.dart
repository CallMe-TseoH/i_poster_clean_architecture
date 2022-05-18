import 'package:flutter/material.dart';
import 'package:i_poster/config/theme/theme.dart';

class AppTextField extends StatelessWidget {
  const AppTextField({
    super.key,
    required this.labelText,
    this.enabled = true,
    this.onChanged,
    TextInputType textInputType = TextInputType.text,
    this.suffixIcon,
    this.value,
    this.maxLine,
    this.hintText,
  }) : _textInputType = textInputType;

  final String labelText;
  final String? value;
  final String? hintText;
  final bool enabled;
  final TextInputType _textInputType;
  final int? maxLine;
  final void Function(String)? onChanged;
  final Widget? suffixIcon;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      textInputAction: TextInputAction.next,
      keyboardType: _textInputType,
      initialValue: value,
      maxLines: maxLine,
      style: TextStyle(color: AppColors.dark.withOpacity(.65)),
      decoration: InputDecoration(
        enabled: enabled,
        labelText: labelText,
        hintText: hintText,
        labelStyle: const TextStyle(color: Colors.black38),
        focusColor: Colors.black,
        hoverColor: Colors.black,
        suffixIcon: suffixIcon,
        focusedBorder: const UnderlineInputBorder(),
      ),
      onChanged: onChanged,
    );
  }
}
