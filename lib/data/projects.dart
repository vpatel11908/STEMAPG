import 'calendar.dart';
//stores the data for the projects that the user creates
class Project extends Calendar {
  static String projectName = '';
  static DateTime projectDueDate = DateTime.parse('0000-00-00');
  static double projectDuration = 0;
  static List<Project> projectList = [];
  
  Project (name, dueDate, duration){
    projectName = name;
    projectList.add(this);
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

  static void setName(String newName) {
    projectName = newName;
  }

  static void setProjectDueDate(DateTime newProjectDueDate) {
    projectDueDate = newProjectDueDate;
  }

  static void setDuration(String newDuration){
    projectDuration = double.parse(newDuration);
  }
  List<double> generateProjectSchedule(double sessionLength, double maxVal, double motivation,) {
  // Calculate timePeriod as number of days until due date 
    DateTime now = DateTime.now();
    print('Due date: $projectDueDate');
    double timePeriod = projectDueDate.difference(now).inDays.toDouble();
  

    // Total work time in minutes (used to be in hours)
    double totalLength = (projectDuration).round().toDouble();
    List<double> finalhoursAvailable = [];
    for(int i = 0; i<timePeriod; i++){
      finalhoursAvailable.add(1000); // 100 hours available for each day (this is just a placeholder, you can change it to the actual hours available)
    }
  

    return fixCalendar(sessionLength,  timePeriod, maxVal, motivation,totalLength, finalhoursAvailable);
}
  int gettotalLength(){
    int totalLength = ((projectDuration) * 60).round();
    return totalLength;
  }
   static fromJson(projectMap) {}

  toJson() {}

}

