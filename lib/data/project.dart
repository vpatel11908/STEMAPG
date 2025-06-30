import 'calendar.dart';
import 'dart:convert';
import 'projectList.dart';
import 'project_registry.dart';

//stores the data for the projects that the user creates
class Project extends Calendar {
  late String projectName;
  late DateTime projectDueDate;
  late double projectDuration;
  List<Project> projectList = [];
  final projectRegistry = ProjectRegistry(); // An instance of ProjectRegistry
   bool isCompleted;

  Project(String name, String dueDate, String duration, {this.isCompleted = false}) {
    // Constructor to initialize the project
    projectName = name;
    projectDueDate = DateTime.parse(dueDate);
    projectDuration = double.parse(duration);
    projectList.add(this);
}
  bool getIsCompleted() {
    return isCompleted;
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

//getter for project name
  String getName() {
    return projectName;
  }
//getter for project due date
  DateTime getProjectDueDate() {
    return projectDueDate;
  } 
//getter for project duration
  double getDuration() {
    return projectDuration;
  }
//sets the name of the project
  void setName(String newName) {
    projectName = newName;
  }
//sets due date of the project
  void setProjectDueDate(DateTime newProjectDueDate) {
    projectDueDate = newProjectDueDate;
  }
//sets duration of the project
  void setDuration(newDuration){
    projectDuration = double.parse(newDuration);
  }
//generates a schedule for the project
  List<double> generateProjectSchedule(double sessionLength, double maxVal, double motivation,) {
  // Calculate timePeriod as number of days until due date 
    DateTime now = DateTime.now();
    print('Due date: $projectDueDate');
    double timePeriod = projectDueDate.difference(now).inDays.toDouble();
  

    // Total work time in minutes (used to be in hours)
    double totalLength = (projectDuration).round().toDouble();
    List<double> finalhoursAvailable = [];
    for(int i = 0; i<timePeriod; i++){
      finalhoursAvailable.add(100); // 100 hours available for each day (this is just a placeholder, you can change it to the actual hours available)
    }
  
//calls fixcalendar to generate the calendar since now the parameters have been defined
    return fixCalendar(sessionLength,  timePeriod, maxVal, motivation,totalLength, finalhoursAvailable);
  }
//getter for total length 
  int gettotalLength(){
    int totalLength = ((projectDuration) * 60).round();
    return totalLength;
  }

//saves the projects in the project list to shared preferences in JSON format
  Future<void> saveProjectsToJson() async {
    final projectListJson = ProjectList.projects.map((p) => p.toJson()).toList();
    await projectRegistry.prefsWithCache.setString('projects', jsonEncode(projectListJson));
  }

//loads the projects from JSON and adds them to the project list, this is called when the app is opened
  Future<void> loadProjectsFromJson(String json) async {
    final List<dynamic> decodedProjects = jsonDecode(json);
    projectList = decodedProjects.map((json) => Project.fromJson(json)).toList().cast<Project>();
    for (var project in projectList) {
      ProjectList.addToProjectList(project);
    }
  } 
}