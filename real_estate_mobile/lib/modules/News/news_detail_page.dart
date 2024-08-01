import 'package:flutter/material.dart';

class NewsDetailPage extends StatelessWidget {
  final Map<String, String> newsItem;

  NewsDetailPage({required this.newsItem});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(newsItem['title']!)),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.network(newsItem['image']!),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              newsItem['text']!,
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ),
        ],
      ),
    );
  }
}
