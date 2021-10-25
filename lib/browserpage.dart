import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewExample extends StatefulWidget {
  String url = "";

  WebViewExample(this.url);

  @override
  WebViewExampleState createState() => WebViewExampleState(url);
}

class WebViewExampleState extends State<WebViewExample> {
  String url = "";

  WebViewExampleState(this.url);

  @override
  void initState() {
    super.initState();
    // Enable hybrid composition.
    if (Platform.isAndroid) WebView.platform = SurfaceAndroidWebView();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Web Browser'),),

      body: WebView(
        initialUrl: url,
      ),
    );
  }
}
