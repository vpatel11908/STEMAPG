import 'package:stemcalendar/main.dart';
//stores the data for the projects that the user creates
class Project extends Calendar {
  String projectName = '';
  String projectDueDate = '';
  String duration = '';
  static List<Project> projectList = [];
  
  Project (name, dueDate, projectDuration){
    projectName = name;
    projectDueDate = dueDate;
    duration = projectDuration;
  }

  String getName() {
    return projectName;
  }

  String getProjectDueDate() {
    return projectDueDate;
  }

  String getDuration() {
    return duration;
  }

  void setName(String newName) {
    projectName = newName;
  }

  void setProjectDueDate(String newProjectDueDate) {
    projectDueDate = newProjectDueDate;
  }

  void setDuration(String newDuration){
    duration = newDuration;
  }

  void addToProjectList(Project project) {
    projectList.add(project);
  }

  List<Project> getProjectList() {
    return projectList;
  }
  List<double> generateProjectSchedule({
  required double sessionLength,
  required double maxVal,
  required double motivation,
}) {
  // Calculate timePeriod as number of days until due date 
  DateTime now = DateTime.now();
  DateTime dueDate = DateTime.parse(projectDueDate); // has to be in 'yyyy-MM-dd' format otherwise it wont work
  double timePeriod = dueDate.difference(now).inDays.toDouble();
  

  // Total work time in minutes (used to be in hours)
  int totalLength = (double.parse(duration) * 60).round();

  return generateCalendar(sessionLength,  timePeriod, maxVal, motivation,totalLength);
}

}