import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hexatour/core/theme/colors.dart';
import 'package:hexatour/core/utils/Helpers.dart';

import 'package:sizer/sizer.dart';

class CustomTextField extends StatefulWidget {
  final Function()? textFieldTap;
  final Function()? onEditingComplete;
  final TextEditingController? control;
  final String? type;
  final int? maxLength;
  final bool isNumber;
  final TextStyle style;
  final ValueChanged<String>? onChanged;
  final TextInputAction textInputAction;
  final TextInputType keyboardType;
  final String? hint;
  final bool isRequired;
  final IconData? icon;
  final Function()? onTap;
  final bool? isReadOnly;
  final Color? fillColor;
  final FocusNode? focusNode;
  final EdgeInsets? contentPadding;
  final String? labelText;
  final Widget? prefIcon;
  final InputBorder? enabledBorder;
  final InputBorder? focusedBorder;
  final int? minLine;
  final int? maxLine;
  final String? errortext;
  // ignore: deprecated_member_use
  final ToolbarOptions? toolbarOptions;
  const CustomTextField(
      {this.textFieldTap,
      this.enabledBorder,
      this.focusedBorder,
      this.prefIcon,
      this.onEditingComplete,
      this.hint,
      this.control,
      required this.isRequired,
      required this.keyboardType,
      this.type,
      this.maxLength,
      required this.isNumber,
      this.onChanged,
      required this.textInputAction,
      this.icon,
      this.onTap,
      this.isReadOnly,
      required this.style,
      this.fillColor,
      this.focusNode,
      this.contentPadding,
      this.labelText,
      this.minLine,
      this.maxLine,
      this.errortext,
      this.toolbarOptions,
      super.key});

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  bool _isVisible = false;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
        minLines: widget.minLine ?? 1,
        maxLines: widget.maxLine ?? 1,
        cursorColor: ColorConst.blackColor,
        onEditingComplete: widget.onEditingComplete,
        controller: widget.control,
        focusNode: widget.focusNode,
        keyboardType: widget.keyboardType,
        onTap: widget.textFieldTap,
        validator: (value) {
          if (widget.isRequired) {
            switch (widget.type) {
              case 'normal':
                return Helpers.validateField(value!);
              case 'email':
                return Helpers.validateEmail(value!);
              case 'phone':
                return Helpers.validatePhone(value!);
              case 'password':
                return Helpers.validatePassword(value!);
              default:
                return Helpers.validateField(value!);
            }
          }
          return null;
        },
        onChanged: (value) {
          if (widget.onChanged != null) {
            widget.onChanged!(value);
          }
        },
        inputFormatters: widget.isNumber
            ? [
                FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
              ]
            : widget.type == "username"
                ? [
                    FilteringTextInputFormatter.deny(RegExp(r'\s')),
                  ]
                : null,
        style: widget.style,
        obscureText: widget.type == "password" ? !_isVisible : _isVisible,
        textInputAction: widget.textInputAction,
        enableInteractiveSelection: true,
        readOnly: widget.isReadOnly ?? false,
        maxLength: widget.maxLength,
        decoration: InputDecoration(
            labelText: widget.labelText,
            alignLabelWithHint: true,
            contentPadding:
                widget.contentPadding ?? EdgeInsets.only(top: 2.h, left: 4.w),
            hintText: widget.hint,
            hintStyle: Theme.of(context).textTheme.displaySmall?.copyWith(
                color: Color(0xffC6C5C5), fontWeight: FontWeight.w500),
            counterText: '',
            filled: true,
            prefixIcon: widget.prefIcon ?? null,
            fillColor: widget.fillColor ?? Color(0xffF4F6F8),
            enabledBorder: widget.enabledBorder ??
                OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide:
                      BorderSide(color: Theme.of(context).disabledColor),
                ),
            focusedBorder: widget.focusedBorder ??
                OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(color: Theme.of(context).primaryColor),
                ),
            suffixIcon: widget.type == "password"
                ? IconButton(
                    splashColor: Colors.transparent,
                    onPressed: () {
                      setState(() {
                        _isVisible = !_isVisible;
                      });
                    },
                    icon: _isVisible
                        ? Icon(
                            Icons.visibility_outlined,
                            color: Theme.of(context).primaryColor,
                          )
                        : const Icon(Icons.visibility_off_outlined,
                            color: Colors.black38),
                    color: Theme.of(context).iconTheme.color,
                  )
                : widget.icon != null
                    ? IconButton(
                        padding: EdgeInsets.zero,
                        onPressed: widget.onTap,
                        icon: Icon(widget.icon, color: ColorConst.blackColor))
                    : null));
  }
}
