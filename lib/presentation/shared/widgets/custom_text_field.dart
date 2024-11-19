import 'package:app_remision/core/settings/theme_settings.dart';
import 'package:flutter/material.dart';

class CustomTextfield extends StatelessWidget {
  final void Function(String)? onChanged;
  final String? Function(String?)? validator;
  final String? labelText, errorText;
  final bool? oscureText;
  final TextEditingController? controller;
  final bool? readOnly;
  final void Function()? onTap;

  final TextInputType? keyboardType;

  const CustomTextfield(
      {super.key,
      this.onChanged,
      this.validator,
      this.labelText,
      this.oscureText,
      this.keyboardType,
      this.errorText,
      this.controller,
      this.readOnly,
      this.onTap});

  @override
  Widget build(BuildContext context) {
    bool isDarkMode = Theme.of(context).brightness == Brightness.dark;
    Color textColor = isDarkMode ? Colors.white : ThemeColors.secondaryBlue;
    Color borderColor = isDarkMode ? Colors.white : ThemeColors.secondaryBlue;
    Color cursorColor = isDarkMode ? Colors.white : ThemeColors.secondaryBlue;
    return TextFormField(
      onTap: onTap,
      readOnly: readOnly ?? false,
      controller: controller,
      keyboardType: keyboardType,
      obscureText: oscureText ?? false,
      onChanged: onChanged,
      validator: validator,
      decoration: InputDecoration(
        errorText: errorText,
        labelText: labelText,
        labelStyle: TextStyle(color: borderColor), // Color de la etiqueta
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: borderColor), // Línea inferior cuando está habilitado
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: borderColor, width: 2.0), // Línea inferior cuando el campo está enfocado
        ),
        errorBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.red, width: 2.0), // Línea inferior cuando hay error
        ),
        focusedErrorBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.red, width: 2.0), // Línea inferior cuando hay error y está enfocado
        ),
        contentPadding: const EdgeInsets.symmetric(vertical: 10.0),
      ),

      cursorColor: cursorColor, // Color del cursor
      style: TextStyle(color: textColor), // Color del texto
    );
  }
}
