import 'package:pdfx/pdfx.dart';

Future<PdfPageImage?> getImage({int pageIndex = 1, required String path}) async {
  final document = await PdfDocument.openAsset(path);

  final page = await document.getPage(pageIndex);

  final image = await page.render(
    width: page.width * 2,
    height: page.height * 2,
    format: PdfPageImageFormat.jpeg,
    backgroundColor: '#ffffff',
  );

  return image;
}
