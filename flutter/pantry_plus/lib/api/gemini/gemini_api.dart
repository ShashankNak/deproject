import 'dart:io';

import 'package:flutter_gemini/flutter_gemini.dart';

class GeminiApi {
  static Future<String> getGeminiResponse(String img) async {
    try {
      final gemini = Gemini.instance;
      final value = await gemini.textAndImage(
          text:
              "Just give me the name of the object in this image in this format: {'image': [image]}",
          images: [File(img).readAsBytesSync()],
          modelName: "models/gemini-pro-vision");
      if (value != null && value.output != null) {
        return value.output!;
      } else {
        throw "";
      }
    } catch (e) {
      return "";
    }
  }
}
