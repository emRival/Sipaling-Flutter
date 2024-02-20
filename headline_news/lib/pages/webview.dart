import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:headline_news/pages/main_page.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebView extends StatefulWidget {
  static String routeName = 'web_view';
  final String url;
  const WebView({super.key, required this.url});

  @override
  State<WebView> createState() => _WebViewState();
}

class _WebViewState extends State<WebView> {
  WebViewController controller = WebViewController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(Colors.white)
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (progress) {
            const SpinKitCubeGrid(
              color: Colors.amber,
            );
          },
          onPageStarted: (url) {},
          onPageFinished: (url) {},
        ),
      )
      ..loadRequest(Uri.parse(widget.url));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Web View"),
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.pushReplacementNamed(context,
                MainPage.routeName); // Tutup halaman jika tidak bisa kembali
          },
        ),
      ),
      body: WebViewWidget(controller: controller),
    );
  }
}
