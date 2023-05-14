// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:icare/ui/news.dart';

class MyNewsPage extends StatefulWidget {
  const MyNewsPage({Key? key}) : super(key: key);

  @override
  _MyNewsPageState createState() => _MyNewsPageState();
}

class _MyNewsPageState extends State<MyNewsPage> {
  News news = News();
  dynamic newsData;

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  void fetchData() async {
    newsData = await news.fetchCountries();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Covid-19 News'),
      ),
      body: newsData == null
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: newsData['response']
                  .length, // assuming 'response' is the key containing the list of countries
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(newsData['response'][index]),
                );
              },
            ),
    );
  }
}
