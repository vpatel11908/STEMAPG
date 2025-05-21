import 'package:flutter/material.dart';
import 'package:stemcalendar/data/project.dart';

//shows the name and duration of the project that was clicked on in the project list to display this page
class ProjectPage extends StatefulWidget {
  final Project project; //stores the data for the project that is passed to the project page
  const ProjectPage({super.key, required this.project});

  @override
  State<ProjectPage> createState() => _ProjectPageState();
  }

class _ProjectPageState extends State<ProjectPage> {
  Widget? activeWidget;
  
  late Project projectCalendar;
  late List<double> finalHoursList;

  @override
  void initState() {
    super.initState();
    // Initialize projectCalendar and finalHoursList here
    projectCalendar = widget.project;
    finalHoursList = projectCalendar.generateProjectSchedule(1, 100, 1);
  }

  @override
  //widget that allows the user to see the list of tasks and when they should be completed by 
  //in the future, this would be aplace for the user to edit the project
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.project.getName()),
         backgroundColor: Color.fromARGB(255, 226, 227, 197)
      ),
      body:
      ListView(
        physics: const BouncingScrollPhysics(),
        children: [
      Center(
        child: 
        Column(
          children: <Widget>[
            Column(
              children: <Widget>[
                 Text ('Total Project Duration: ${widget.project.getDuration().toString()}' ' hours'),
                  for (int i = 0; i < finalHoursList.length; i++) //display the hours that the user must work on the project each day 
                      //each day is given a number from 1 to the number of days until the due date
                        Card(
                          child: ListTile(
                            title: Text('Day ${i + 1}'),
                            subtitle: Text('Work minutes: ${finalHoursList[i]}'),
                          ),
                        ),
              ],
            ),
          ],
        ),
      ),
        ]
      ),
    );
  }
}