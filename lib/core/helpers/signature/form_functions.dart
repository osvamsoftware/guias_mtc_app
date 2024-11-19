import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:signature/signature.dart';

Future<String?> showSignatureDialog(BuildContext context) async {
  final SignatureController controller = SignatureController(
    penStrokeWidth: 5,
    penColor: Colors.black,
    exportBackgroundColor: Colors.white,
  );

  String? filePath;

  await showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: const Text('Firmar Documento'),
        content: SizedBox(
          height: 400,
          width: 300,
          child: Column(
            children: [
              Signature(
                controller: controller,
                width: 300,
                height: 300,
                backgroundColor: Colors.grey[200]!,
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton(
                    onPressed: () {
                      controller.clear();
                    },
                    child: const Text('Limpiar'),
                  ),
                  TextButton(
                    onPressed: () async {
                      filePath = await _saveSignatureToFile(controller);
                      Navigator.of(context).pop();
                    },
                    child: const Text('Guardar'),
                  ),
                ],
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text('Cancelar'),
          ),
        ],
      );
    },
  );

  return filePath;
}

Future<String> _saveSignatureToFile(SignatureController controller) async {
  final bytes = await controller.toPngBytes();
  final Directory directory = await getApplicationDocumentsDirectory();
  final String filePath = '${directory.path}/signature_${DateTime.now().millisecondsSinceEpoch}.png';
  final File file = File(filePath);

  await file.writeAsBytes(bytes!);

  return filePath;
}
