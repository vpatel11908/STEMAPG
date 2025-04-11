import 'package:flutter/material.dart';
import 'package:stemcalendar/data/projects.dart';

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
                hintText: ('Enter the name of the project'),

              ),
        ),
        TextField(
              controller: dateController,
              decoration: const InputDecoration(
                labelText: 'Project Name',
                border: OutlineInputBorder(),
                hintText: ('Enter the due date of the project'),

              ),
        ),
        TextField(
              controller: lengthController,
              decoration: const InputDecoration(
                labelText: 'Project Name',
                border: OutlineInputBorder(),
                hintText: ('Enter the number of hours that this project should take to complete'),

              ),
        ),
        ElevatedButton(
          onPressed: () {
            setState(() {
              activeWidget = const MakeNewTaskPage();
            });
            Projects(nameController.text, dateController.text, lengthController.text);
          }, 
          child: const Text('Create Task'),
          )
          ],
        ),
      ),
    );
  }
}