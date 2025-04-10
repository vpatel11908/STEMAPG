import 'package:flutter/material.dart';

class QuestionsScreen extends StatefulWidget {
  const QuestionsScreen({super.key});

  @override
  State<QuestionsScreen> createState() => _QuestionsScreenState();
}

class _QuestionsScreenState extends State<QuestionsScreen> {
  Widget? activeWidget;

  @override
  void initState() {
    super.initState();
    activeWidget = const QuestionsScreen();
    switchScreen();
    // Initialize any data or state here if needed
  }

  void switchScreen() {
    setState(() {
     activeWidget = const QuestionsScreen();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Questions Screen'),
      ),
      body: const Center(
        child: Text('This is the Questions Screen'),
      ),
    );
  }
}

/**
 * Use this for the times available 
 * CheckboxSettingsTile(
        settingsKey: 'key-of-your-setting',
        title: 'This is a simple Checkbox',
      ),
 */