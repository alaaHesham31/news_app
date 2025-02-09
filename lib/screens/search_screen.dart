import 'package:flutter/material.dart';
import 'package:news_app/api_manager.dart';
import 'package:news_app/models/news_data_response.dart';
import 'package:news_app/widgets/news_item.dart';
import 'news_item_details.dart';

class LatestNewsScreen extends StatefulWidget {
  final String sourceId;

  const LatestNewsScreen({super.key, required this.sourceId});

  @override
  _LatestNewsScreenState createState() => _LatestNewsScreenState();
}

class _LatestNewsScreenState extends State<LatestNewsScreen> {
  List<Articles> articles = [];
  List<Articles> filteredArticles = [];
  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    fetchNews();
    searchController.addListener(_filterArticles);
  }

  Future<void> fetchNews() async {
    var response = await ApiManager.getNewsData(widget.sourceId);
    if (mounted) {
      setState(() {
        articles = response.articles ?? [];
        filteredArticles = articles;
      });
    }
  }

  void _filterArticles() {
    String query = searchController.text.toLowerCase();
    setState(() {
      filteredArticles = articles
          .where((article) =>
      article.title?.toLowerCase().contains(query) == true ||
          article.description?.toLowerCase().contains(query) == true)
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color(0xFF171717),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextField(
                controller: searchController,
                style: const TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  hintText: 'Search News...',
                  hintStyle: const TextStyle(color: Colors.grey),
                  filled: true,
                  fillColor: Colors.black,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: BorderSide.none,
                  ),
                  prefixIcon: const Icon(Icons.search, color: Colors.white),
                ),
              ),
            ),
      
            // News List
            Expanded(
              child: filteredArticles.isEmpty
                  ? const Center(
                child: Text(
                  "No news available",
                  style: TextStyle(color: Colors.white),
                ),
              )
                  : ListView.builder(
                padding: const EdgeInsets.all(16.0),
                itemCount: filteredArticles.length,
                itemBuilder: (context, index) {
                  return NewsItem(
                    article: filteredArticles[index],
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => NewsDetailScreen(
                            title: filteredArticles[index].title ?? '',
                            subtitle: filteredArticles[index].description ?? '',
                            author: filteredArticles[index].author ?? '',
                            date: filteredArticles[index].publishedAt ?? '',
                            urlToImage: filteredArticles[index].urlToImage ?? '',
                            content: filteredArticles[index].content ?? '',
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
