import 'package:flutter/material.dart';
import 'package:news_app/widgets/positioned_button_widget.dart';

import '../screens/sources_section.dart';

class CategoriesSection extends StatelessWidget {
  Function onTap;
   CategoriesSection({required this.onTap,super.key});


  final List<String> categories = [
    'general',
    'business',
    'sport',
    'health',
    'science',
    'technology',
    'entertainment'
  ];

  @override
  Widget build(BuildContext context) {
    return  Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Good Morning \nHere is Some News For You',
            style: TextStyle(
                fontSize: 24,
                color: Color(0xFFFFFFFF),
                fontWeight: FontWeight.w500,
                fontFamily: 'Inter'),
          ),
          SizedBox(
            height: 20,
          ),
          Expanded(
            child: ListView.separated(
              itemCount: categories.length,
              separatorBuilder: (context, index) {
                return SizedBox(
                  height: 20,
                );
              },
              itemBuilder: (context, index) {
                return Stack(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(24),
                      child: Image(
                        image: AssetImage(
                            'assets/images/${categories[index]}.png'),
                        width: double.infinity,
                      ),
                    ),
                    PositionedButton(
                      isRight: index.isEven,
                      onTap: () {
                        Navigator.pushNamed(
                          context,
                          SourcesSection.routeName,
                        );
                      },
                    )
                  ],
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
