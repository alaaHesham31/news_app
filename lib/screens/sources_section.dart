import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:news_app/api_manager.dart';
import 'package:news_app/models/news_data_response.dart';
import 'package:news_app/widgets/news_item.dart';

import '../models/source_response.dart';

class SourcesSection extends StatefulWidget {
  static const String routeName = "SourcesSection";

  const SourcesSection({super.key});

  @override
  _SourcesSectionState createState() => _SourcesSectionState();
}

class _SourcesSectionState extends State<SourcesSection> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xFF171717),
        appBar: AppBar(
          backgroundColor: const Color(0xFF171717),
          title: const Text(
            'Home',
            style: TextStyle(
                fontSize: 20, color: Colors.white, fontWeight: FontWeight.w500),
          ),
          centerTitle: true,
          actions: const [
            Icon(Icons.search, size: 32, color: Colors.white),
          ],
        ),
        body: FutureBuilder(
          future: ApiManager.getResources(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (snapshot.hasError) {
              return Center(
                child: Text(
                  "Error: ${snapshot.error}",
                  style: TextStyle(color: Colors.white),
                ),
              );
            } else {
              List<Sources> data = snapshot.data?.sources ?? [];
              return Column(children: [
                DefaultTabController(
                    initialIndex: selectedIndex,
                    length: data.length,
                    child: TabBar(
                        onTap: (value) {
                          selectedIndex = value;
                          setState(() {});
                        },
                        isScrollable: true,
                        labelColor: Colors.white,
                        unselectedLabelColor: Colors.white70,
                        indicatorColor: Colors.white,
                        tabs: data
                            .map((element) => Tab(
                                  text: element.name,
                                ))
                            .toList())),
                Expanded(
                    child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: FutureBuilder<NewsDataResponse>(
                      future: ApiManager.getNewsData(
                          data[selectedIndex].id ?? ''),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return Center(
                            child: CircularProgressIndicator(),
                          );
                        } else if (snapshot.hasError) {
                          return Center(
                            child: Text(
                              "Error: ${snapshot.error}",
                              style: TextStyle(color: Colors.white),
                            ),
                          );
                        } else {
                          var data = snapshot.data?.articles ?? [];
                          return ListView.builder(
                              itemCount: data.length,
                              itemBuilder: (context, index) {
                                return NewsItem(article: data[index]);
                              });
                        }
                      }),
                ))
              ]);
            }
          },
        ));
  }
}
