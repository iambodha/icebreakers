import 'package:flutter/material.dart';

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
                      left: 16.0, top: 16.0, right: 16.0, bottom: 84.0),
                  child: const Text(
                    'Ice Breakers',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24.0,
                      fontWeight: FontWeight.bold,
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
      body: const Center(
        child: Text('Your app content goes here'),
      ),
    );
  }
}
