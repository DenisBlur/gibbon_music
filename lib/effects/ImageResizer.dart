import 'dart:io';
import 'package:image/image.dart';
import 'package:path_provider/path_provider.dart';

class ImageSupport {
  static Future<File> resize(String urlImage) async {
    final directory = await getApplicationDocumentsDirectory();
    Image? image = decodeJpg(File(urlImage).readAsBytesSync());
    Image thumbnail = copyResize(image!, width: 1920, height: 1080);
    File("${directory.path}/document_app/mica.png").writeAsBytesSync(encodePng(thumbnail));
    return File("${directory.path}/document_app/mica.png");
  }
}