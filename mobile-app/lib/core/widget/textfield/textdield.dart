import 'package:flutter/material.dart';
import '../../theme/colors.dart';

class WidgetTextField extends StatelessWidget {
  const WidgetTextField({
    super.key,
    this.width = double.infinity,
    // General
    this.controller,
    this.keyboardType,
    this.initialValue,
    this.isPass = false,
    this.validator,
    this.onSaved,
    this.onChanged,
    this.maxLines = 1,
    this.minLines,
    // decoration
    this.enabledBorderColor,
    this.focusedBorderColor,
    this.labelText,
    this.hintText,
    this.helperText,
    this.suffixIcon,
    this.iconBefore,
    this.errorText,
    this.isShowIconPass = false,
  });

  // General
  final TextEditingController? controller;
  final TextInputType? keyboardType;
  final String? initialValue;
  final bool isPass;
  final String? Function(String?)? validator;
  final void Function(String?)? onSaved;
  final void Function(String)? onChanged;
  final int? minLines;
  final int? maxLines;
  // decoration
  final Color? enabledBorderColor;
  final Color? focusedBorderColor;
  final String? labelText;
  final String? hintText;
  final String? errorText;

  final String? helperText;
  final IconData? iconBefore;
  final bool isShowIconPass;
  final double width;
  final IconButton? suffixIcon;
  @override
  Widget build(BuildContext context) {
    const double borderRadius = 25;
    double width = MediaQuery.of(context).size.width * .8;
    double height = MediaQuery.of(context).size.height * .09;

    return TextFormField(
      // General
      controller: controller,
      // close keyboard when click outside text field
      onTapOutside: (PointerDownEvent event) =>
          FocusManager.instance.primaryFocus?.unfocus(),
    
      keyboardType: keyboardType,
      initialValue: initialValue,
      obscureText: isPass,
      obscuringCharacter: '*',
      validator: validator,
      onSaved: onSaved,
      onChanged: onChanged,
      minLines: minLines,
      maxLines: maxLines,
      // Decoration
      decoration: InputDecoration(
        border: InputBorder.none,
        label: Text(labelText ?? ''),
        hintText: (hintText ?? ''),
        helperText: helperText,
        helperMaxLines: 2,
        errorText: errorText,
        errorStyle: Theme.of(context).textTheme.labelMedium,
        // icon
        prefixIcon: Icon(
          iconBefore,
        ),
        //todo will make an eye for obscure password with bloc controller
        suffixIcon: isShowIconPass ? suffixIcon : null,
    
        // Border Style
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(borderRadius),
          borderSide: const BorderSide(color: ColorsTheme.greyBorder),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(borderRadius),
          borderSide: const BorderSide(color: ColorsTheme.greyBorder),
        ),
    
        // error
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(borderRadius),
          borderSide: const BorderSide(color: ColorsTheme.red),
        ),
    
        errorMaxLines: 2,
      ),
    );
  }
}
