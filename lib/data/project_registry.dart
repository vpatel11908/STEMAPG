import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'project.dart';
import 'projectList.dart';

//stores the project data using shared preferences
class ProjectRegistry {
  static List<Project> projectList = [];

  ProjectRegistry();

  get prefsWithCache => null; // Default constructor

  // Load projects from SharedPreferences
  Future<void> loadProjectsFromSharedPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    final String? projectsJson = prefs.getString('projects');
    
    //ensure there is something in the projectsJson before decoding and loading the data into the projectList
    if (projectsJson != null) {
      final List<dynamic> decodedProjects = jsonDecode(projectsJson);
      ProjectList.projects = decodedProjects.map((json) => Project.fromJson(json)).toList().cast<Project>();
    } else {
      ProjectList.projects = [];
    }
  }

  // Save projects to SharedPreferences
   Future<void> saveProjectsToSharedPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    final String projectsJson = jsonEncode(ProjectList.projects.map((project) => project.toJson()).toList());
    await prefs.setString('projects', projectsJson);
  }

  //create an instance of the ProjectRegistry
  static create() {
    return ProjectRegistry();
  }

  void removeProject(Project project) {
    ProjectList.projects.remove(project);
    saveProjectsToSharedPreferences();
  }
}

