import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class Results extends StatefulWidget {
  const Results({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _ResultsState createState() => _ResultsState();
}

class _ResultsState extends State<Results> {

  @override
  void initState() {
    super.initState();
    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            // Update loading bar.
          },
          onPageStarted: (String url) {},
          onPageFinished: (String url) {},
          onWebResourceError: (WebResourceError error) {},
          onNavigationRequest: (NavigationRequest request) {
            if (request.url.startsWith('https://app.powerbi.com/view?r=eyJrIjoiNWM2YzM0YjgtOTQ0Zi00YmVlLWFhYWMtNTFiMGRjNDhjYzMzIiwidCI6ImJhYjBiNjc5LWJkNWYtNGZlOC1iNTE2LWM2YjhiMzE3Yzc4MiIsImMiOjR9')) {
              return NavigationDecision.prevent;
            }
            return NavigationDecision.navigate;
          },
        ),
      )
      ..loadRequest(Uri.parse('https://app.powerbi.com/view?r=eyJrIjoiNWM2YzM0YjgtOTQ0Zi00YmVlLWFhYWMtNTFiMGRjNDhjYzMzIiwidCI6ImJhYjBiNjc5LWJkNWYtNGZlOC1iNTE2LWM2YjhiMzE3Yzc4MiIsImMiOjR9'));
  }

  late WebViewController _controller;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFF4093CE),
              Color(0xFF9BCEF3),
            ],
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: WebViewWidget(
                controller: _controller
              )
            )
          ],
        ),
      ),
    );
  }
}
