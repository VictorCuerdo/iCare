import 'dart:async';
import 'package:flutter/material.dart';
import 'package:icare/ui/homepage.dart';
import 'package:icare/widgets/loading_logo.dart';
import 'package:get/get.dart';
import 'package:webviewx/webviewx.dart';

class Results extends StatefulWidget {
  const Results({Key? key}) : super(key: key);

  @override
  _ResultsState createState() => _ResultsState();
}

class _ResultsState extends State<Results> {
  late WebViewXController wvController;

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
              child: WebViewX(
                initialContent: '<iframe title="Report Section" width="600" height="373.5" src="https://app.powerbi.com/view?r=eyJrIjoiNWM2YzM0YjgtOTQ0Zi00YmVlLWFhYWMtNTFiMGRjNDhjYzMzIiwidCI6ImJhYjBiNjc5LWJkNWYtNGZlOC1iNTE2LWM2YjhiMzE3Yzc4MiIsImMiOjR9" frameborder="0" allowFullScreen="true"></iframe>',
                initialSourceType: SourceType.html,
                onWebViewCreated: (controller) {
                  wvController = controller;
                },
                onPageStarted: (src) {
                  print('Page started loading: $src');
                },
                onPageFinished: (src) {
                  print('Page finished loading: $src');
                },
                onWebResourceError: (error) {
                  print('Error: ${error.description}');
                },
                width: double.infinity,
                height: double.infinity,
              ),
            )
          ],
        ),
      ),
    );
  }
}
