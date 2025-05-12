import 'package:flutter/material.dart';
import 'package:stemcalendar/data/projects.dart';
import 'package:stemcalendar/data/shared_preferences.dart';
import 'package:stemcalendar/main.dart';
import 'package:stemcalendar/screens/calendar_page.dart';
import '../data/projectList.dart';

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
    late TextEditingController nameController = TextEditingController();
    late TextEditingController dateController = TextEditingController();
    late TextEditingController lengthController = TextEditingController();


    void finishProjectCreation() {
    Navigator.pushAndRemoveUntil<MainApp>(
    context,
    MaterialPageRoute<MainApp>(builder: (BuildContext context) => const CalendarPage()),
    (Route<dynamic> route) => false,
    );
    }

    @override
    void dispose() {
      nameController.dispose();
      dateController.dispose();
      lengthController.dispose();
      super.dispose();
  }


    return Scaffold(
      appBar: AppBar(
        title: const Text('Add a New Project'),
        backgroundColor: Color.fromARGB(255, 226, 227, 197),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text('Enter the name of this project:'),
            TextField( //allows the user to enter the name of the project
              controller: nameController,
              decoration: const InputDecoration(
                labelText: 'Project Name',
                border: OutlineInputBorder(),

              ),
        ),
         SizedBox(height: 20),
         Text('Enter the due date of the project in the yyyy-MM-dd format:'),
        TextField( //allows the user to enter the due date of the project
              controller: dateController,
              decoration: const InputDecoration(
                labelText: 'Due date of the Project',
                border: OutlineInputBorder(),

              ),
        ),
         SizedBox(height: 20),
         Text('Enter the estimated length of the project in hours :'),
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
            if (nameController.text.isEmpty || dateController.text.isEmpty || lengthController.text.isEmpty) {
              //if any of the text fields are empty, tell the user to fill them in
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Please fill in all fields'),
                  duration: Duration(seconds: 2),
                  backgroundColor: Colors.green,
                  elevation: 10,
                  behavior: SnackBarBehavior.floating,
                  margin: EdgeInsets.all(10),
                ),
              );
              return;
            } 
            else{
              //if the text fields contain text, check if the date is in the correct format
              if (RegExp(r'^\d{4}-(0[1-9]|1[012])-(0[1-9]|[12][0-9]|3[01])$').hasMatch(dateController.text)) {
                if (double.tryParse(lengthController.text) == null) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Please enter a numeric duration'),
                      duration: Duration(seconds: 2),
                      backgroundColor: Colors.green,
                      elevation: 10,
                      behavior: SnackBarBehavior.floating,
                      margin: EdgeInsets.all(10),
                    ),
                  );
                  return;
                }
                else{
                  var project = Project(nameController.text, dateController.text, lengthController.text); 
                  project.setDuration(lengthController.text); //sets the duration of the project
                  ProjectList.addToProjectList(project);
                  ProjectRegistry().saveProjectsToSharedPreferences();  //adds the project to the list so it can be displayed on the calendar page
                  finishProjectCreation();
                }  
              }
              else {
              //if the date is not in the yyyy-mm-dd format, tell the user to fix it
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Please enter the date in the yyyy-MM-dd format'),
                    duration: Duration(seconds: 2),
                    backgroundColor: Colors.green,
                    elevation: 10,
                    behavior: SnackBarBehavior.floating,
                    margin: EdgeInsets.all(10),
                  ),
                );
                return;
              }
            }
          },
        child: const Text('Create Task'),
        ),
          ],
      ),
    ),
  );
  }
}
