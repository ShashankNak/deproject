import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:html/dom.dart' as dom;

class WebCrawler {
  static Future<List<String>> getProductDetail(String code) async {
    log("fetching started");
    try {
      final url = Uri.parse("https://www.google.com/search?q=$code&oq=$code");
      final response = await http.get(url).then((value) {
        log("fetching completed");
        return value;
      });
      dom.Document html = dom.Document.html(response.body);

      final titles = html.getElementsByTagName("h3").map((e) {
        var t = "nothing";
        RegExp exp = RegExp(r'<div class=".*?">(.*?)</div>');
        Iterable<Match> matches = exp.allMatches(e.innerHtml.trim());

        if (matches.isNotEmpty) {
          t = matches.elementAt(0).group(1)!;
        }
        return t;
      }).toList();

      for (final title in titles) {
        log(title);
      }
      return titles;
    } catch (e) {
      log("error: $e ");
      return [];
    }
  }
}
