import 'package:flutter/material.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Scaffold(
          body: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min, // Ensures the column takes up minimal space
              children: [
                Icon(
                  Icons.favorite,
                  size: 200,
                ),
                Text(
                  'Variny Project Planner',
                  style: TextStyle(fontSize: 30),
                ),
              ],
            ),
          ),
        ),
      );
        }
      }
