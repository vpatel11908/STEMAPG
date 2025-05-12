import '../data/project.dart'; 
import '../data/project_registry.dart'; 
import 'dart:convert';

//stores the projects that the user creates and converts them to JSON for persistant storage in shared preferences
class ProjectList{
  static List<Project> projects = [];
  static List<Project> getProjectList() {
    return projects;
  }
  //Adds a project to the projectlist
  static void addToProjectList(Project p) {
    projects.add(p);
  }
  //Removes a project from the projectList
  static void removeFromProjectList(Project p) {
    projects.remove(p);
  }
  //clears the project list
  static void clearProjectList() {
    projects.clear();
  }
  //returns the projectlist
  static int getProjectListLength() {
    return projects.length;
  }
  //returns a specific project
  static Project getProject(int index) {
    return projects[index];
  }

//converts the projectList to JSON for persistant storage in shared preferences
//then calls a method to convert all of the data in each project to JSON
  static Future<void> toJson() async {
    final projectListJson = projects.map((p) => p.toJson()).toList();
    final registry = ProjectRegistry(); // Create an instance of ProjectRegistry
    await registry.prefsWithCache.setString('projects', jsonEncode(projectListJson));
  } 

//converts the JSON data for each project back to a project object and adds it to the projectList
  static Project fromJson(Map<String, dynamic> json) {
    return Project(
      json['name'] as String,
      DateTime.parse(json['dueDate']) as String,
      double.parse(json['duration']) as String,
    );
  }
  
}



