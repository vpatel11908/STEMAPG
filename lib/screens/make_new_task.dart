import 'package:flutter/material.dart';
import 'package:stemcalendar/data/projects.dart';
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
    TextEditingController nameController = TextEditingController();
    TextEditingController dateController = TextEditingController();
    TextEditingController lengthController = TextEditingController();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Make New Task'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: nameController,
              decoration: const InputDecoration(
                labelText: 'Project Name',
                border: OutlineInputBorder(),

              ),
        ),
         SizedBox(height: 20),
        TextField(
              controller: dateController,
              decoration: const InputDecoration(
                labelText: 'Due date of the Project',
                border: OutlineInputBorder(),

              ),
        ),
         SizedBox(height: 20),
        TextField(
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
            print(nameController.text);
            print(project.getName());
            print(dateController.text);
            print(project.getProjectDueDate());
            print(lengthController.text);
            print(project.getDuration());

            project.addToProjectList(project);

            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const CalendarPage()),
            );
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