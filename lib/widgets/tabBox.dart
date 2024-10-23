import 'package:flutter/material.dart';

class TabBox extends StatelessWidget {
  const TabBox({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(10.0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 3,
            blurRadius: 7,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        children: [
          const TabBar(
            tabs: [
              Tab(text: "Details"),
              Tab(text: "Remakes"),
            ],
          ),
          // The TabBarView must have a fixed height
          SizedBox(
            height: 300, // Set a fixed height for TabBarView
            child: TabBarView(
              children: [
                // First Tab: Just an Icon
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    "This build is good for birds of paradise. I'm a full-time student and it took 4 weeks on and off building."
                  ),
                ),
                // Second Tab: GridView in 2 columns
                GridView.count(
                  crossAxisCount: 2, // Number of columns
                  crossAxisSpacing: 10, // Space between columns
                  mainAxisSpacing: 10, // Space between rows
                  padding: const EdgeInsets.all(16.0),
                  physics: const BouncingScrollPhysics(), // Enable scrolling
                  children: List.generate(6, (index) {
                    return Column(
                      children: [
                        Image.network(
                          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSSSJnWD9t8MD7US_LayX11WejXM4plJRVrgA&s',
                          height: 100,
                          width: 100,
                        ),
                        SizedBox(height: 8), // Space between image and text
                        Text('Remake ${index + 1}'),
                      ],
                    );
                  }),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
