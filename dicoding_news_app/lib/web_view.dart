import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebView extends StatelessWidget {
  static const routeName = '/article_web';

  final String url;
  const WebView({super.key, required this.url});

  @override
  Widget build(BuildContext context) {
    final controller = WebViewController()..loadRequest(Uri.parse(url));
    return Scaffold(
      appBar: AppBar(
        title: Text('News App'),
      ),
      body: WebViewWidget(
        controller: controller,
        
      ),
    );
  }
}
