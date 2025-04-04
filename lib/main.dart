import 'package:flutter/material.dart';

void main() {
  runApp(
    const MaterialApp(
      title: 'Navigation Basics', 
      home: MainApp(),
    ),
  );
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        
      ),  
      body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 20.0),
                child: Icon(
                  Icons.edit_calendar, // will be changed to the logo once we make one
                  color: Color.fromARGB(255, 70, 52, 237),
                  size: 150,
                ),
              ),
               Padding(
                padding: const EdgeInsets.only(bottom: 50.0),
                child: Text(
                  'Variny Project Planner',
                  style: TextStyle(fontSize: 30),
              ),
               ),
              SizedBox(height: 20), // Add spacing between the text and the row
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                      context, 
                      MaterialPageRoute(builder: (context) => const LoginPage()),
                    );
                    },
                    child: Text('Login'),
                  ),
                  SizedBox(width: 40), // Add spacing between the buttons
                  ElevatedButton(
                    onPressed: () {
                       Navigator.push(
                        context, 
                        MaterialPageRoute(builder: (context) => const CreateAccountPage()),
                    );
                    },
                    child: Text('Create Account'),
                  ),
                ],
              ),
            ],
          ),
        ),
      );
      }
}

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login to your account'),
      ),
      body: Center(
        child: Text('Welcome to the Second Route!'), //switch to username and password fields
      ),
    );
  }
}

class CreateAccountPage extends StatelessWidget {
  const CreateAccountPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Create an Account'),
      ),
      body: Center(
        child: Text('To create an account, we ask you to take a short quiz about your work/learning styles so we can personalize your schedule. To start the quiz, click the button below'), //switch to quiz 
      ),
    );
  }
}
