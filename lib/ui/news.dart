// ignore_for_file: prefer_interpolation_to_compose_strings, library_private_types_in_public_api

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:icare/ui/lobby.dart';

class NewsPage extends StatefulWidget {
  const NewsPage({super.key});

  @override
  _NewsPageState createState() => _NewsPageState();
}

class _NewsPageState extends State<NewsPage> {
  final List _news = [];
  int _currentPage = 0;
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    fetchNews(_currentPage);
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        fetchNews(_currentPage);
      }
    });
  }

  Future fetchNews(int page) async {
    var response = await http.get(Uri.parse(
        'https://api.nytimes.com/svc/search/v2/articlesearch.json?q=Covid&page=$page&api-key=NlNhqik4GePhM4XN7EakGuYhQqTV1hZ1'));

    if (response.statusCode == 200) {
      var result = jsonDecode(response.body);
      setState(() {
        _news.addAll(result["response"]["docs"]);
        _currentPage++;
      });
    } else {
      throw Exception('Failed to load news');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          ListView.builder(
            controller: _scrollController,
            itemCount: _news.length,
            itemBuilder: (context, index) {
              var article = _news[index];
              var imageUrl = article['multimedia'].isNotEmpty
                  ? 'https://www.nytimes.com/' + article['multimedia'][0]['url']
                  : null;
              return Card(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: <Widget>[
                      imageUrl != null
                          ? Image.network(imageUrl)
                          : Container(height: 200, color: Colors.grey),
                      const SizedBox(height: 8.0),
                      Text(
                        article['headline']['main'],
                        style: const TextStyle(
                            fontSize: 20.0, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 8.0),
                      Text(
                        article['snippet'],
                        style: const TextStyle(fontSize: 16.0),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
          SafeArea(
            child: Padding(
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
          ),
        ],
      ),
    );
  }
}
