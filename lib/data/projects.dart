import 'calendar.dart';
//stores the data for the projects that the user creates
class Project extends Calendar {
  static String projectName = '';
  static DateTime projectDueDate = DateTime.parse('0000-00-00');
  static String projectDuration = '';
  static List<Project> projectList = [];
  
  Project (name, dueDate, duration){
    projectName = name;
    projectDueDate = DateTime.parse(dueDate);
    projectDuration = duration;
    projectList.add(this);
  }

  String getName() {
    return projectName;
  }

  DateTime getProjectDueDate() {
    return projectDueDate;
  }

  String getDuration() {
    return projectDuration;
  }

  static void setName(String newName) {
    projectName = newName;
  }

  static void setProjectDueDate(DateTime newProjectDueDate) {
    projectDueDate = newProjectDueDate;
  }

  static void setDuration(String newDuration){
    projectDuration = newDuration;
  }
  List<double> generateProjectSchedule(double sessionLength, double maxVal, double motivation,) {
  // Calculate timePeriod as number of days until due date 
    DateTime now = DateTime.now();
    print('Due date: $projectDueDate');
    double timePeriod = projectDueDate.difference(now).inDays.toDouble();
  

    // Total work time in minutes (used to be in hours)
    double totalLength = (double.parse(projectDuration)).round().toDouble();
    List<double> finalhoursAvailable = [];
    for(int i = 0; i<timePeriod; i++){
      finalhoursAvailable.add(1000); // 100 hours available for each day (this is just a placeholder, you can change it to the actual hours available)
    }
  

    return fixCalendar(sessionLength,  timePeriod, maxVal, motivation,totalLength, finalhoursAvailable);
}
  int gettotalLength(){
    int totalLength = (double.parse(projectDuration) * 60).round();
    return totalLength;
  }
   static fromJson(projectMap) {}

  toJson() {}

}

