import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Ice Breakers',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF004AAD),
          primary: const Color(0xFF004AAD),
          secondary: const Color(0xFF38B6FF),
          background: Colors.white,
        ),
        useMaterial3: true,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 210,
        flexibleSpace: ClipRect(
          child: Align(
            alignment: Alignment.bottomCenter,
            heightFactor: 0.7,
            child: Stack(
              fit: StackFit.expand,
              children: [
                Image.asset(
                  'assets/app-bar.png',
                  fit: BoxFit.cover,
                  alignment: Alignment.topCenter,
                ),
                Container(
                  alignment: Alignment.bottomLeft,
                  padding: const EdgeInsets.only(
                      left: 16.0, top: 16.0, right: 16.0, bottom: 80.0),
                  child: const Text(
                    'Ice Breakers',
                    style: TextStyle(
                      fontFamily: 'TT-Bluescreens',
                      color: Colors.white,
                      fontSize: 40.0,
                    ),
                  ),
                ),
                Container(
                  alignment: Alignment.bottomRight,
                  padding: const EdgeInsets.only(
                      left: 16.0, top: 16.0, right: 16.0, bottom: 80.0),
                  child: IconButton(
                    icon: const Icon(Icons.account_circle, color: Colors.white),
                    onPressed: () {
                      // Add account button functionality here
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: AnimationLimiter(
        child: GridView.count(
          crossAxisCount: 2,
          padding: const EdgeInsets.all(16),
          children: List.generate(
            6,
            (int index) {
              final sections = [
                'Theoretical',
                'Friendship',
                'Conflict',
                'Funny',
                'Viral Questions',
                'Best Ice Breakers'
              ];
              final icons = [
                Icons.lightbulb,
                Icons.people,
                Icons.warning,
                Icons.mood,
                Icons.trending_up,
                Icons.ac_unit
              ];
              return AnimationConfiguration.staggeredGrid(
                position: index,
                duration: const Duration(milliseconds: 375),
                columnCount: 2,
                child: ScaleAnimation(
                  child: FadeInAnimation(
                    child: GestureDetector(
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: Text(sections[index]),
                              content: SizedBox(
                                width: double.maxFinite,
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    TextField(
                                      decoration: InputDecoration(
                                        hintText: 'Search questions...',
                                        prefixIcon: Icon(Icons.search),
                                      ),
                                    ),
                                    SizedBox(height: 16),
                                    Expanded(
                                      child: ListView(
                                        children: [
                                          Text('What is your name?'),
                                          SizedBox(height: 8),
                                          Text('Question 2'),
                                          SizedBox(height: 8),
                                          Text('Question 3'),
                                          // Add more questions here
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        );
                      },
                      child: Card(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(icons[index], size: 48),
                            SizedBox(height: 8),
                            Text(sections[index], textAlign: TextAlign.center),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
