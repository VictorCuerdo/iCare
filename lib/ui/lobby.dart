// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:icare/ui/formulario.dart';
import 'package:icare/ui/dashboard.dart';
import 'package:icare/ui/news.dart';
import 'package:icare/ui/hospitals.dart';
import 'package:lottie/lottie.dart';
import 'dart:async';

class Lobby extends StatefulWidget {
  @override
  _LobbyState createState() => _LobbyState();
}

class _LobbyState extends State<Lobby> with SingleTickerProviderStateMixin {
  int selectedGrid = -1;
  static const Color selectedGridColor = Colors.white;
  bool animationFinished = false;
  List<Color> gridColors = [
    const Color.fromARGB(255, 241, 193, 154),
    const Color.fromARGB(255, 245, 206, 118),
    const Color.fromARGB(255, 211, 179, 221),
    const Color.fromARGB(255, 213, 223, 226),
  ];

  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
    _controller.addListener(() {
      if (_controller.status == AnimationStatus.completed) {
        setState(() {
          animationFinished = true;
        });
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Widget createGridItem(int index, IconData icon, String text) {
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedGrid = index;
          _controller.reset();
        });
        Timer(const Duration(seconds: 4), () {
          if (animationFinished) {
            switch (index) {
              case 0:
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const Formulario()),
                );
                break;
              case 1:
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const Dashboard()),
                );
                break;
              case 2:
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const NewsPage()),
                );
                break;
              case 3:
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const Hospitals()),
                );
                break;
            }
          }
        });
      },
      child: Container(
        color: selectedGrid == index ? selectedGridColor : gridColors[index],
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            selectedGrid == index
                ? Lottie.asset(
                    'assets/images/circleload.json',
                    width: 150,
                    height: 150,
                    controller: _controller,
                    onLoaded: (composition) {
                      _controller
                        ..duration = composition.duration
                        ..forward();
                    },
                  )
                : Icon(icon, size: 50),
            const SizedBox(height: 20),
            Flexible(
              child: Text(
                text,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontFamily: 'Lora',
                  fontSize: 21,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;
    var appBarHeight = AppBar().preferredSize.height;
    var statusBarHeight = MediaQuery.of(context).padding.top;
    var remainingHeight = screenHeight - appBarHeight - statusBarHeight;

    return Scaffold(
      backgroundColor: Colors.blueGrey[900],
      body: Center(
        child: SizedBox(
          height: remainingHeight,
          child: GridView.count(
            crossAxisCount: 2,
            mainAxisSpacing: 10,
            crossAxisSpacing: 10,
            padding: const EdgeInsets.all(10),
            childAspectRatio: (screenWidth / 2) / (remainingHeight / 1.9),
            children: <Widget>[
              createGridItem(0, Icons.document_scanner_outlined, "Formulario"),
              createGridItem(1, Icons.dashboard, "Dashboard"),
              createGridItem(2, Icons.newspaper, "Noticias         COV-19"),
              createGridItem(3, Icons.apartment, "Centros de Atención"),
            ],
          ),
        ),
      ),
    );
  }
}
