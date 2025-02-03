import 'dart:ui';
import 'package:flutter/material.dart';

class SourcesSection extends StatefulWidget {
  static const String routeName = "SourcesSection";

  const SourcesSection({super.key});

  @override
  _SourcesSectionState createState() => _SourcesSectionState();
}

class _SourcesSectionState extends State<SourcesSection> {
  int? selectedIndex;

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
        actions: const [
          Icon(Icons.search, size: 32, color: Colors.white),
        ],
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: List.generate(5, (index) {
                  bool isSelected = selectedIndex == index;

                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedIndex = isSelected ? null : index;
                      });
                    },
                    child: Container(
                      margin: const EdgeInsets.only(bottom: 16),
                      decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: Colors.white, width: 2),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            ClipRRect(
                              borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(16),
                                topRight: Radius.circular(16),
                              ),
                              child: const Image(
                                image: AssetImage('assets/images/frame.png'),
                              ),
                            ),
                            const SizedBox(height: 10),
                            const Text(
                              '40-year-old man falls 200 feet to his death while canyoneering at national park',
                              style: TextStyle(fontSize: 20, color: Colors.white, fontWeight: FontWeight.w500),
                            ),
                            const SizedBox(height: 10),
                            const Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'By : Jon Haworth',
                                  style: TextStyle(fontSize: 18, color: Colors.grey, fontWeight: FontWeight.w500),
                                ),
                                Text(
                                  '15 minutes ago',
                                  style: TextStyle(fontSize: 18, color: Colors.grey, fontWeight: FontWeight.w500),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                }),
              ),
            ),
          ),

          // The floating selected item
          if (selectedIndex != null)
            Positioned.fill(
              child: GestureDetector(
                onTap: () => setState(() => selectedIndex = null),
                child: Container(
                  color: Colors.black.withOpacity(0.5), // Dark overlay
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
                              child: const Image(
                                image: AssetImage('assets/images/frame.png'),
                              ),
                            ),
                            const SizedBox(height: 10),
                            const Text(
                              '40-year-old man falls 200 feet to his death while canyoneering at national park',
                              style: TextStyle(fontSize: 20, color: Colors.black, fontWeight: FontWeight.w500),
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(height: 10),
                            const Text(
                              'By : Jon Haworth | 15 minutes ago',
                              style: TextStyle(fontSize: 18, color: Colors.black54, fontWeight: FontWeight.w500),
                            ),
                            const SizedBox(height: 15),
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.black,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(16),
                                ),
                                padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 32),
                              ),
                              onPressed: () {
                                // Open full article
                              },
                              child: const Text(
                                'View Full Article',
                                style: TextStyle(fontSize: 18, color: Colors.white, fontWeight: FontWeight.w500),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
