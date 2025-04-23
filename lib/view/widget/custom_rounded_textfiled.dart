import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:sizer/sizer.dart';
import 'package:suktha_crm/Constants/colors.dart';

class CustomRoundedTextField extends StatelessWidget {
  final String label;
  double? height;
  double? width;

  String? hint;
  Iterable<String>? autofillHints;
  bool? enabled;
  int? multilines;
  int? maxLength;
  Function(String)? onchanged;
  Function()? onEditingComplete;
  Function()? ontap;

  Function(PointerDownEvent)? ontapOutside;
  FloatingLabelBehavior? labelBehavior;
  TextInputType? textInputType;
  String? errortext;
  final FormFieldValidator validator;
  final TextInputAction textInputAction;
  Widget? suffixIcon;
  List<TextInputFormatter>? inputFormat;
  final bool obscure;
  final bool? readonly;
  final TextEditingController controller;
  CustomRoundedTextField({
    this.inputFormat,
    this.ontap,
    this.onchanged,
    this.onEditingComplete,
    this.labelBehavior,
    this.enabled,
    this.height,
    this.width,
    this.hint,
    this.ontapOutside,
    this.multilines,
    this.maxLength,
    this.autofillHints,
    this.textInputType,
    required this.validator,
    required this.textInputAction,
    this.suffixIcon,
    required this.obscure,
    required this.controller,
    required this.label,
    Key? key,
    this.errortext,
    this.readonly,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(1.2.w),
      child: TextFormField(
        onTap: ontap,
        readOnly: readonly ?? false,
        onChanged: onchanged,
        inputFormatters: inputFormat,
        keyboardType: textInputType,
        enabled: enabled,
        autofillHints: autofillHints,
        maxLines: multilines,
        onTapOutside: ontapOutside,
        onEditingComplete: onEditingComplete,
        validator: validator,
        controller: controller,
        maxLength: maxLength,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        obscureText: obscure,
        textCapitalization: TextCapitalization.sentences,
        style: TextStyle(fontWeight: FontWeight.normal),
        textInputAction: textInputAction,
        decoration: InputDecoration(
          hintText: hint,
          contentPadding: EdgeInsets.all(2.w),
          floatingLabelBehavior: labelBehavior,
          suffixIcon: suffixIcon,
          labelText: label,
          labelStyle: TextStyle(
            overflow: TextOverflow.fade,
            fontSize: 15.sp,
            color: Color.fromARGB(255, 78, 78, 78),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(3.w),
            borderSide: BorderSide(color: Colors.red),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(3.w),
            borderSide: BorderSide(color: Colors.red),
          ),
          disabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(3.w),
            borderSide: BorderSide(color: kColorgrey),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(3.w),
            borderSide: BorderSide(color: kColorgrey),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(3.w),
            borderSide: BorderSide(color: kColorgrey),
          ),
        ),
      ),
    );
  }
}
