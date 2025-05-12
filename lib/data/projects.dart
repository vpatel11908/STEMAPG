import 'calendar.dart';
import 'dart:convert';
import 'projectList.dart';
import 'shared_preferences.dart';

//stores the data for the projects that the user creates
class Project extends Calendar {
  late final String projectName;
  late final DateTime projectDueDate;
  late final double projectDuration;
  List<Project> projectList = [];
  final projectRegistry = ProjectRegistry(); // An instance of ProjectRegistry

  Project(String name, String dueDate, String duration) {
    projectName = name;
    projectDueDate = DateTime.parse(dueDate);
    projectDuration = double.parse(duration);
    projectList.add(this);
  }
   // Convert a Project object to JSON
  Map<String, dynamic> toJson() {
    return {
      'name': projectName,
      'dueDate': projectDueDate.toIso8601String(),
      'duration': projectDuration,
    };
  }

  // Create a Project object from JSON
  factory Project.fromJson(Map<String, dynamic> json) {
  return Project(
    json['name'] as String,
    json['dueDate'] as String,
    json['duration'].toString(), 
  );
}


  String getName() {
    return projectName;
  }

  DateTime getProjectDueDate() {
    return projectDueDate;
  } 

  double getDuration() {
    return projectDuration;
  }

  List<double> generateProjectSchedule(double sessionLength, double maxVal, double motivation,) {
  // Calculate timePeriod as number of days until due date 
    DateTime now = DateTime.now();
    print('Due date: $projectDueDate');
    double timePeriod = projectDueDate.difference(now).inDays.toDouble();
  

    // Total work time in minutes (used to be in hours)
    double totalLength = (projectDuration);
    List<double> finalhoursAvailable = [];
    for(int i = 0; i<timePeriod; i++){
      finalhoursAvailable.add(1000); // 100 hours available for each day (this is just a placeholder, you can change it to the actual hours available)
    }
  

    return fixCalendar(sessionLength,  timePeriod, maxVal, motivation,totalLength, finalhoursAvailable);
  }

  int gettotalLength(){
    int totalLength = (projectDuration * 60).round();
    return totalLength;
  }

  Future<void> saveProjectsToJson() async {
    final projectListJson = ProjectList.projects.map((p) => p.toJson()).toList();
    await projectRegistry.prefsWithCache.setString('projects', jsonEncode(projectListJson));
  }

  Future<void> loadProjectsFromJson(String json) async {
    final List<dynamic> decodedProjects = jsonDecode(json);
    projectList = decodedProjects.map((json) => Project.fromJson(json)).toList().cast<Project>();
    for (var project in projectList) {
      ProjectList.addToProjectList(project);
    }
  } 
}