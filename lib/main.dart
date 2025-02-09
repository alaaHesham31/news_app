import 'package:flutter/material.dart';
import 'package:news_app/screens/home_screen.dart';
import 'package:news_app/screens/sources_section.dart';

import 'models/news_data_response.dart';

void main() {
  runApp(const MyApp());
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      initialRoute: HomeScreen.routeName,
      onGenerateRoute: (settings) {
        if (settings.name == SourcesSection.routeName) {
          final article = settings.arguments as Articles;
          return MaterialPageRoute(
            builder: (context) => SourcesSection(article: article),
          );
        }
        return null; // Default case
      },
      routes: {
        HomeScreen.routeName: (context) => HomeScreen(),
      },
    );
  }
}
