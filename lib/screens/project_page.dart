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
                 Text ('Project Duration: ${widget.project.getDuration().toString()}'),
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