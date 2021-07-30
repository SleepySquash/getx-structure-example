import 'dart:html' as html;

class HtmlHelper {
  static void pushState(dynamic data, String title, String? url) {
    html.window.history.pushState(data, title, url);
  }
}
