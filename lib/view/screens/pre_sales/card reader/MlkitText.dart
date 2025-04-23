import 'dart:io';

import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
import 'package:suktha_crm/view/screens/pre_sales/card%20reader/card_reader.dart';

class MLkitTextRecognizer extends ITextRecognizer {
  late TextRecognizer recognizer;

  MLkitTextRecognizer() {
    recognizer = TextRecognizer();
  }

  void dispose() {
    recognizer.close();
  }

  @override
  Future<RecognizedText> processImage(String imgPath) async {
    final image = InputImage.fromFile(File(imgPath));
    final recognized = await recognizer.processImage(image);
    return recognized;
  }
}
