import 'package:flutter/material.dart';
import 'package:icare/ui/lobby.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:get/get.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  late WebViewController _controller;

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
            if (request.url.startsWith(
                'https://app.powerbi.com/view?r=eyJrIjoiNWM2YzM0YjgtOTQ0Zi00YmVlLWFhYWMtNTFiMGRjNDhjYzMzIiwidCI6ImJhYjBiNjc5LWJkNWYtNGZlOC1iNTE2LWM2YjhiMzE3Yzc4MiIsImMiOjR9')) {
              return NavigationDecision.prevent;
            }
            return NavigationDecision.navigate;
          },
        ),
      )
      ..loadRequest(Uri.parse(
          'https://app.powerbi.com/view?r=eyJrIjoiNWM2YzM0YjgtOTQ0Zi00YmVlLWFhYWMtNTFiMGRjNDhjYzMzIiwidCI6ImJhYjBiNjc5LWJkNWYtNGZlOC1iNTE2LWM2YjhiMzE3Yzc4MiIsImMiOjR9'));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey,
      body: SafeArea(
        child: Stack(
          children: [
            WebViewWidget(controller: _controller),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Align(
                alignment: Alignment.topRight,
                child: IconButton(
                  onPressed: () {
                    Get.off(() => Lobby());
                  },
                  icon: const Icon(Icons.widgets_outlined, size: 40),
                  color: Colors.blueGrey,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
