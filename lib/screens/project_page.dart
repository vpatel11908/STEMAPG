import 'package:flutter/material.dart';
import 'package:stemcalendar/data/projects.dart';

class ProjectPage extends StatefulWidget {
  final Project project; //stores the data for the project that is passed to the project page
  const ProjectPage({super.key, required this.project});

  @override
  State<ProjectPage> createState() => _ProjectPageState();
  }

class _ProjectPageState extends State<ProjectPage> {
  Widget? activeWidget;
  
  @override
  //widget that allows the user to see the list of tasks and when they should be completed by 
  //in the future, this would be a calendar or allow the user to pair the app with their calendar
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.project.getName()),
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
                 Text ('Project Duration: ${widget.project.getName()}'),
                 //do something else here after the MVP, probably allow for the user to edit the project
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