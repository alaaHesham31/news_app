import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

class NewsDetailScreen extends StatelessWidget {
  final String title;
  final String subtitle;
  final String author;
  final String date;
  final String urlToImage;
  final String content;

  const NewsDetailScreen({
    Key? key,
    required this.title,
    required this.subtitle,
    required this.author,
    required this.date,
    required this.urlToImage,
    required this.content,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('News Details'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              Text(
                subtitle,
                style: const TextStyle(fontSize: 18, color: Colors.grey, fontWeight: FontWeight.w500),
              ),
              const SizedBox(height: 20),
              Column(
                children: [
                  Text(
                    'By $author',
                    style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.blue),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    date,
                    style: const TextStyle(fontSize: 14, color: Colors.grey),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: CachedNetworkImage(
                  imageUrl: urlToImage,
                  width: double.infinity,
                  height: 240,
                  fit: BoxFit.cover,
                  placeholder: (context, url) => const Center(child: CircularProgressIndicator()),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                ),
              ),
              const SizedBox(height: 16),
              Text(
                content,
                style: const TextStyle(fontSize: 16, height: 1.5),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
