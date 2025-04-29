import 'package:flutter/material.dart';
import 'package:stemcalendar/data/projects.dart';
import 'package:stemcalendar/screens/make_new_task.dart';
import 'package:stemcalendar/screens/project_page.dart';
// Ensure CalendarInfo is imported if it exists in another file
// import 'package:stemcalendar/screens/calendar_info.dart';

class CalendarPage extends StatefulWidget {
  const CalendarPage({super.key});

  @override
  State<CalendarPage> createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
  @override
  Widget build(BuildContext context) {
    // Create the Calendar object here
    List<double> hoursAvailable = List.generate(100, (index) => 100.0);
    Calendar projectCalendar = Calendar();
    List<double> finalHoursList = projectCalendar.fixCalendar(1, 100, 100, 1, 100, hoursAvailable);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Calendar Page'),
      ),
      body: ListView(
        physics: const BouncingScrollPhysics(),
        children: [
          Center(
            child: Column(
              children: <Widget>[
                if (Project.projectList.isEmpty) ...[
                  const Text('Please add a project first!'),
                  const SizedBox(height: 100),
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const MakeNewTaskPage(),
                          ),
                        );
                      });
                    },
                    child: const Text('Add a new Project'),
                  ),
                ] else ...[
                  Column(
                    children: <Widget>[
                      for (int i = 0; i < Project.projectList.length; i++)
                        Card(
                          child: ListTile(
                            title: Text(Project.projectList[i].getName()),
                            subtitle: Text(Project.projectList[i].getProjectDueDate()),
                            trailing: const Icon(Icons.info),
                            onTap: () {
                              setState(() {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => ProjectPage(project: Project.projectList[i]),
                                  ),
                                );
                              });
                            },
                          ),
                        ),
                    ],
                  ),
                  const SizedBox(height: 20), // Spacing between lists
                  Column(
                    children: <Widget>[
                      for (int i = 0; i < finalHoursList.length; i++)
                        Card(
                          child: ListTile(
                            title: Text('Day ${i + 1}'),
                            subtitle: Text('Work hours: ${finalHoursList[i]}'),
                            trailing: const Icon(Icons.info),
                          ),
                        ),
                    ],
                  ),
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const CalendarInfo(), // Ensure CalendarInfo exists
                          ),
                        );
                      });
                    },
                    child: const Text('Calendar Info'),
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}