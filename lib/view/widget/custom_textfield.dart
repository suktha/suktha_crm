import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:sizer/sizer.dart';
import 'package:work_Force/Constants/colors.dart';

class CustomTextField extends StatelessWidget {
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
  TextCapitalization? textCapitalization;

  final bool obscure;
  final bool? readonly;
  final TextEditingController controller;
  CustomTextField({
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
    this.textCapitalization = TextCapitalization.sentences,
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
        textCapitalization: textCapitalization!,
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
            fontSize: 16.sp,
            color: Color.fromARGB(255, 78, 78, 78),
          ),
          focusedErrorBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.red),
          ),
          errorBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.red),
          ),
          disabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: kColorgrey),
          ),
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: kColorgrey),
          ),
          border: UnderlineInputBorder(
            borderSide: BorderSide(color: kColorgrey),
          ),
        ),
      ),
    );
  }
}

class buildTextField extends StatelessWidget {
  String? label;
  TextEditingController? titleController;
  bool isRequired = false;
  IconButton? suffixIcon;
  VoidCallback? functionOntap;
  int? maxLengthCount;
  TextInputType? keyboardType;
  buildTextField({
    super.key,
    this.titleController,
    this.label,
    this.functionOntap,
    required this.isRequired,
    this.keyboardType,
    this.maxLengthCount,
    this.suffixIcon,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: TextFormField(
        textCapitalization: TextCapitalization.sentences, // Capitalizes the first letter of each sentence
        maxLength: maxLengthCount,
        // keyboardType: keyBoard,
        maxLines: label == "Specification/Description" ? null : 1,
        onTap: functionOntap,
        controller: titleController,
        keyboardType: keyboardType,
        decoration: InputDecoration(
          suffixIcon: suffixIcon,
          labelText: label,
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey.shade300, width: 1.0), // Default border
            borderRadius: BorderRadius.circular(8.0),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.blue.shade300, width: 1.0), // Border when focused
            borderRadius: BorderRadius.circular(8.0),
          ),
          errorBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.red, width: 1.0), // Border on validation error
            borderRadius: BorderRadius.circular(8.0),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.orange, width: 1.0), // Focused error border
            borderRadius: BorderRadius.circular(8.0),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        validator: (value) {
          if (isRequired && (value == null || value.isEmpty)) {
            return "$label is required";
          }
          return null;
        },
      ),
    );
  }
}
