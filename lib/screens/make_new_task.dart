import 'package:flutter/material.dart';
import 'package:stemcalendar/data/projects.dart';
import 'package:stemcalendar/main.dart';
import 'package:stemcalendar/screens/calendar_page.dart';

class MakeNewTaskPage extends StatefulWidget {
  const MakeNewTaskPage({super.key});

  @override
  State<MakeNewTaskPage> createState() => _MakeNewTaskPageState();
  }


class _MakeNewTaskPageState extends State<MakeNewTaskPage> {
  Widget? activeWidget;
  
  @override
  //widget that allows the user to create a new task and stores the data in the Projects class
  Widget build(BuildContext context) {
    //used to get the data from the text fields where the user enters the project data
    TextEditingController nameController = TextEditingController();
    TextEditingController dateController = TextEditingController();
    TextEditingController lengthController = TextEditingController();

    void finishProjectCreation() {
    Navigator.pushAndRemoveUntil<MainApp>(
    context,
    MaterialPageRoute<MainApp>(builder: (BuildContext context) => const CalendarPage()),
    (Route<dynamic> route) => false,
    );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Make New Project'),

      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField( //allows the user to enter the name of the project
              controller: nameController,
              decoration: const InputDecoration(
                labelText: 'Project Name',
                border: OutlineInputBorder(),

              ),
        ),
         SizedBox(height: 20),
        TextField( //allows the user to enter the due date of the project
              controller: dateController,
              decoration: const InputDecoration(
                labelText: 'Due date of the Project',
                border: OutlineInputBorder(),

              ),
        ),
         SizedBox(height: 20),
        TextField( //allows the user to enter the estimated length of the project
              controller: lengthController,
              decoration: const InputDecoration(
                labelText: 'Estimated Length of the Project',
                border: OutlineInputBorder(),

              ),
        ),
        SizedBox(height: 20),
        ElevatedButton(
          onPressed: () {
            var project = Project(nameController.text, dateController.text, lengthController.text); //stores the data in the project class
            project.addToProjectList(project); //adds the project to the list so it can be displayed on the calendar page
            finishProjectCreation();
            /*
            Navigator.push( //goes back to the calendar page
              context,
              MaterialPageRoute(builder: (context) => const CalendarPage()),

            );
            */
          }, 
          child: const Text('Create Task'),
        )
          ],
        ),
      ),
    );
  }
}



// how to store data:
 //hash maps?
 // SQ Lite - room api? -> gives you methods to use?