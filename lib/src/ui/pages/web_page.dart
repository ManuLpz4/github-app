import 'dart:async';

import 'package:flutter/material.dart';

import 'package:url_launcher/url_launcher.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebPage extends StatefulWidget {
  @override
  _WebPageState createState() => _WebPageState();
}

class _WebPageState extends State<WebPage> {
  final String _initialUrl = 'https://github.com';
  WebViewController _webViewController;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: SafeArea(
        child: WebView(
          initialUrl: _initialUrl,
          javascriptMode: JavascriptMode.unrestricted,
          onWebViewCreated: _onWebViewCreated,
          navigationDelegate: _navigationDelegate,
        ),
      ),
    );
  }

  /// Goes back only if it cans, avoiding unexpected app closing
  /// and enabling web navigation
  Future<bool> _onWillPop() async {
    final bool canGoBack = await _webViewController.canGoBack();
    if (canGoBack) _webViewController.goBack();
    return !canGoBack;
  }

  /// Setups the WebViewController once the web view is created
  void _onWebViewCreated(WebViewController webViewController) =>
      _webViewController = webViewController;

  /// Handles the navigation to external links
  FutureOr<NavigationDecision> _navigationDelegate(
      NavigationRequest navigationRequest) async {
    if (!navigationRequest.url.startsWith(_initialUrl)) {
      if (await canLaunch(navigationRequest.url)) {
        launch(navigationRequest.url);
        return NavigationDecision.prevent;
      }
    }
    return NavigationDecision.navigate;
  }
}
