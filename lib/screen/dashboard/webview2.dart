import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

class WebviewFileUploadScreen extends StatefulWidget {
  final String url;
  const WebviewFileUploadScreen({super.key, required this.url});

  @override
  State<WebviewFileUploadScreen> createState() =>
      _WebviewFileUploadScreenState();
}

class _WebviewFileUploadScreenState extends State<WebviewFileUploadScreen> {
  InAppWebViewController? webViewController;
  double progress = 0;

  Future<bool> _onWillPop() async {
    if (webViewController != null) {
      bool canGoBack = await webViewController!.canGoBack();
      if (canGoBack) {
        webViewController!.goBack();
        return false;
      }
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        appBar: AppBar(title: const Text("terms & Conditions")),
        body: SafeArea(
          child: Column(
            children: [
              if (progress < 1) LinearProgressIndicator(value: progress),
              Expanded(
                child: InAppWebView(
                  initialUrlRequest: URLRequest(url: WebUri(widget.url)),
                  initialSettings: InAppWebViewSettings(
                    javaScriptEnabled: true,
                    allowsInlineMediaPlayback: true,
                    useShouldOverrideUrlLoading: true,
                    mediaPlaybackRequiresUserGesture: false,
                  ),
                  onWebViewCreated: (controller) {
                    webViewController = controller;
                  },
                  onLoadStart: (controller, url) {
                    debugPrint("🌍 Loading Started: $url");
                  },
                  onLoadStop: (controller, url) async {
                    debugPrint("✅ Page Loaded: $url");
                  },
                  onProgressChanged: (controller, progressValue) {
                    setState(() {
                      progress = progressValue / 100;
                    });
                  },
                  onReceivedError: (controller, request, error) {
                    debugPrint("❌ ERROR: ${error.description}");
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
