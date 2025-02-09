import 'dart:ui';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:news_app/api_manager.dart';
import 'package:news_app/models/news_data_response.dart';
import 'package:news_app/screens/search_screen.dart';
import 'package:news_app/widgets/news_item.dart';

import '../models/source_response.dart';
import 'news_item_details.dart';

class SourcesSection extends StatefulWidget {
  static const String routeName = "SourcesSection";
  final Articles article;
  List<Sources> sources = [];


  SourcesSection({super.key, required this.article});

  @override
  _SourcesSectionState createState() => _SourcesSectionState();
}

class _SourcesSectionState extends State<SourcesSection> {
  int selectedIndex = 0;
  Articles? selectedArticle;
  List<Sources> sources = []; // Store sources data


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF171717),
      appBar: AppBar(
        backgroundColor: const Color(0xFF171717),
        title: const Text(
          'Home',
          style: TextStyle(fontSize: 20, color: Colors.white, fontWeight: FontWeight.w500),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              if (sources.isNotEmpty) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => LatestNewsScreen(
                      sourceId: sources[selectedIndex].id ?? '',
                    ),
                  ),
                );
              }
            },
            icon: const Icon(Icons.search, size: 32, color: Colors.white),
          )
        ],
      ),

      body: GestureDetector(
        onTap: () {
          setState(() {
            selectedArticle = null;
          });
        },
        child: Stack(
          children: [
            FutureBuilder(
              future: ApiManager.getResources(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(
                    child: Text(
                      "Error: ${snapshot.error}",
                      style: const TextStyle(color: Colors.white),
                    ),
                  );
                } else {
                  List<Sources> data = snapshot.data?.sources ?? [];
                  sources = data;
                  return Column(
                    children: [
                      DefaultTabController(
                        initialIndex: selectedIndex,
                        length: data.length,
                        child: TabBar(
                          onTap: (value) {
                            setState(() {
                              selectedIndex = value;
                            });
                          },
                          isScrollable: true,
                          labelColor: Colors.white,
                          unselectedLabelColor: Colors.white70,
                          indicatorColor: Colors.white,
                          tabs: data
                              .map((element) => Tab(text: element.name))
                              .toList(),
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: FutureBuilder<NewsDataResponse>(
                            future: ApiManager.getNewsData(
                                data[selectedIndex].id ?? ''),
                            builder: (context, snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return const Center(
                                    child: CircularProgressIndicator());
                              } else if (snapshot.hasError) {
                                return Center(
                                  child: Text(
                                    "Error: ${snapshot.error}",
                                    style: const TextStyle(color: Colors.white),
                                  ),
                                );
                              } else {
                                var articles = snapshot.data?.articles ?? [];
                                return ListView.builder(
                                    itemCount: articles.length,
                                    itemBuilder: (context, index) {
                                      return GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            selectedArticle = articles[index];
                                          });
                                        },
                                        child: NewsItem(
                                          article: articles[index],
                                          onTap: () {
                                            setState(() {
                                              selectedArticle = articles[
                                                  index]; // Store selected article
                                            });
                                          },
                                        ),
                                      );
                                    });
                              }
                            },
                          ),
                        ),
                      )
                    ],
                  );
                }
              },
            ),
            if (selectedArticle != null)
              GestureDetector(
                onTap: () {
                  setState(() {
                    selectedArticle = null;
                  });
                },
                child: Container(
                  color: Colors.black.withOpacity(0.5),
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 1, sigmaY: 1),
                    child: Center(
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 300),
                        width: MediaQuery.of(context).size.width * 0.9,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(16),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.3),
                              blurRadius: 10,
                              spreadRadius: 2,
                            ),
                          ],
                        ),
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(16),
                              child: CachedNetworkImage(
                                imageUrl: selectedArticle!.urlToImage ?? '',
                                height: 220,
                                width: double.infinity,
                                fit: BoxFit.fill,
                                placeholder: (context, url) => const Center(
                                    child: CircularProgressIndicator()),
                                errorWidget: (context, url, error) =>
                                    const Icon(Icons.error),
                              ),
                            ),
                            const SizedBox(height: 10),
                            Text(
                              selectedArticle!.title ?? '',
                              style: const TextStyle(
                                fontSize: 20,
                                color: Colors.black,
                                fontWeight: FontWeight.w500,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(height: 10),
                            Text(
                              'By: ${selectedArticle!.author ?? 'Unknown'} | ${selectedArticle!.publishedAt?.substring(0, 10) ?? ''}',
                              style: const TextStyle(
                                fontSize: 18,
                                color: Colors.black54,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            const SizedBox(height: 15),
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.black,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(16),
                                ),
                                padding: const EdgeInsets.symmetric(
                                    vertical: 12, horizontal: 32),
                              ),
                              onPressed: () async {
                                await Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => NewsDetailScreen(
                                      title: selectedArticle!.title ?? '',
                                      subtitle:
                                          selectedArticle!.description ?? '',
                                      author: selectedArticle!.author ?? '',
                                      date: selectedArticle!.publishedAt ?? '',
                                      urlToImage:
                                          selectedArticle!.urlToImage ?? '',
                                      content: selectedArticle!.content ?? '',
                                    ),
                                  ),
                                );
                                setState(() {
                                  selectedArticle = null;
                                });
                              },
                              child: const Text(
                                'View Full Article',
                                style: TextStyle(
                                  fontSize: 18,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
