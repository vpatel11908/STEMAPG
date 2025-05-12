// ignore_for_file: unused_local_variable
//will be used to create a login page and a create account page 

import 'package:flutter/material.dart';
import 'package:stemcalendar/screens/questions_screen.dart';
import 'package:stemcalendar/main.dart';

//Login page - this page would be used to log in to an existing account, then navigate to the main app (got rid of this and store the data locally)
class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

// Widget to log in to an account
class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    final textController = TextEditingController();
    final secondController = TextEditingController();
    return Scaffold(
      appBar: AppBar(
        title: Text('Login to your account'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0), 
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center, 
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 20.0), 
                child: Text(
                  'Please enter your username and password',
                  style: TextStyle(fontSize: 20),
                ),
              ),
              SizedBox(height: 20), 
              SizedBox(
                width: 300,
                child: Column(
                  children: [
                    TextField( //username field
                      controller: textController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'Enter username',
                      ),
                    ),
                    SizedBox(height: 20), 
                    TextField( //password field 
                      controller: secondController, 
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'Enter password',
                      ),
                      obscureText: true, 
                    ),
                    SizedBox(height: 20), 
                    ElevatedButton(
                      onPressed: () {
                        var username = textController.text;
                        var password = secondController.text;
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const MainApp()),//change to some way to save the login info and move to the create task page
                        );
                      },
                      child: Text('Enter'),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

//Starts the proccess of creating an account by having the user start a work/learning style quiz
// This page is the first step in creating an account
class CreateAccountPage extends StatelessWidget {
  const CreateAccountPage({super.key});

//Widget to create an account by having the user start a work/learning style quiz
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Create an Account'),
      ),
      body: Center(
        child: SizedBox(
          width: 800,
          child: Padding(
            padding: EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  'To create an account, we ask you to take a short quiz about your work/learning styles so we can personalize your schedule. To start the quiz, click the button below.',
                ),
                SizedBox(height: 20), 
                ElevatedButton( // button to start the quiz that navigates to the QuestionsScreen
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const QuestionsScreen()),
                    );
                  },
                  child: Text('Start Quiz'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}