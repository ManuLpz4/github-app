import 'package:flutter/material.dart';

import 'package:webview_flutter/webview_flutter.dart';

class WebPage extends StatefulWidget {
  @override
  _WebPageState createState() => _WebPageState();
}

class _WebPageState extends State<WebPage> {
  WebViewController _webViewController;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _goBack,
      child: SafeArea(
        child: WebView(
          initialUrl: 'https://github.com/',
          javascriptMode: JavascriptMode.unrestricted,
          onWebViewCreated: (WebViewController webViewController) =>
              _webViewController = webViewController,
        ),
      ),
    );
  }

  /// Goes back only if it cans, avoiding unexpected app closing
  /// and enabling web navigation
  Future<bool> _goBack() async {
    final bool canGoBack = await _webViewController.canGoBack();
    if (canGoBack) _webViewController.goBack();
    return !canGoBack;
  }
}
