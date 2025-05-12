import 'projects.dart';
import 'shared_preferences.dart';
import 'dart:convert';

class ProjectList{
  static List<Project> projects = [];
  static List<Project> getProjectList() {
    return projects;
  }
  static void addToProjectList(Project p) {
    projects.add(p);
  }
  static void removeFromProjectList(Project p) {
    projects.remove(p);
  }
  static void clearProjectList() {
    projects.clear();
  }
  static int getProjectListLength() {
    return projects.length;
  }
  static Project getProject(int index) {
    return projects[index];
  }
 Future<void> toJson() async {
    final projectListJson = projects.map((p) => p.toJson()).toList();
    final registry = ProjectRegistry(); // Create an instance of ProjectRegistry
    await registry.prefsWithCache.setString('projects', jsonEncode(projectListJson));
  } 

  static Project fromJson(Map<String, dynamic> json) {
    return Project(
      json['name'] as String,
      DateTime.parse(json['dueDate']) as String,
      double.parse(json['duration']) as String,
    );
  }
  
}

extension on Future<void> {
  setString(String s, String jsonEncode) {}
}



