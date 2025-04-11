
//stores the data for the projects that the user creates
class Projects {
  String projectName = '';
  String projectDueDate = '';
  String duration = '';
  
  Projects (name, projectDueDate, duration){
    this.projectName = name;
    this.projectDueDate = projectDueDate;
    this.duration = duration;
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
}