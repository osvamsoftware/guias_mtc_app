import 'package:app_remision/core/settings/theme_settings.dart';
import 'package:flutter/material.dart';

class CustomNamedDivider extends StatelessWidget {
  final String? label;
  final double fontSize;
  final IconData? icon;
  final Function()? onIconTap;
  const CustomNamedDivider({
    super.key,
    this.label,
    this.fontSize = 22,
    this.icon,
    this.onIconTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Expanded(child: Divider(indent: 5, endIndent: 5, height: 3, color: ThemeColors.secondaryBlue)),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                  constraints: BoxConstraints(maxWidth: MediaQuery.sizeOf(context).width * .7),
                  child: Center(
                      child: Text(label ?? 'label',
                          textAlign: TextAlign.center,
                          style: TextStyle(color: ThemeColors.secondaryBlue, fontSize: fontSize)))),
              if (icon != null) const SizedBox(width: 10),
              if (icon != null) InkWell(onTap: onIconTap, child: Icon(icon))
            ],
          ),
          const Expanded(child: Divider(indent: 5, endIndent: 5, height: 3, color: ThemeColors.secondaryBlue))
        ],
      ),
    );
  }
}
