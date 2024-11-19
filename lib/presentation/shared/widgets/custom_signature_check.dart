import 'package:app_remision/core/settings/theme_settings.dart';
import 'package:flutter/material.dart';

class CustomSignatureCheck extends StatelessWidget {
  const CustomSignatureCheck({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 50,
          width: double.infinity,
          decoration: BoxDecoration(
            border: Border.all(color: ThemeColors.primaryRed),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 20,
                height: 20,
                color: Colors.green,
                child: const Icon(Icons.check, color: Colors.white, size: 15),
              ),
              const SizedBox(
                width: 15,
              ),
              const Text('Documento Firmado')
            ],
          ),
        )
      ],
    );
  }
}
