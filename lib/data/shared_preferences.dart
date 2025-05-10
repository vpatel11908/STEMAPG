import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stemcalendar/data/projects.dart';

//stores the data in shared preferences so that the data isn't lost when the app is closed
class ProjectRegistry {
  late final SharedPreferencesWithCache prefsWithCache;

  ProjectRegistry._();

  static Future<ProjectRegistry> create() async {
    final registry = ProjectRegistry._();
    registry.prefsWithCache = await SharedPreferencesWithCache.create(
      cacheOptions: const SharedPreferencesWithCacheOptions(allowList: null),
    );
    return registry;
  }

  // Save projects to SharedPreferences
  Future<void> saveProjectsToSharedPreferences() async {
    final projectListJson = _projectList.map((p) => p.toJson()).toList();
    await prefsWithCache.setString('projects', jsonEncode(projectListJson));
  }

  // Load the project list from SharedPreferences
  Future<void> loadProjectsFromSharedPreferences() async {
    final projectString = prefsWithCache.getString('projects');
    if (projectString != null) {
      final List<dynamic> projectJsonList = jsonDecode(projectString);
      _projectList =
          projectJsonList
              .map((json) => Project.fromJson(json))
              .toList()
              .cast<Project>();
    }
  }

  //store the projects as a list so they can be iterated through on the calendar page
  static List<Project> _projectList = [];

  static void addProject(Project project) {
    _projectList.add(project);
  }

  static Project? getProjectByName(String name) {
  try {
    return _projectList.firstWhere((p) => p.getName() == name);
  } catch (_) {
    return null;
  }
}

  static List<Project> getProjectList() {
    return List.unmodifiable(_projectList);
  }

  static void clearProjects() {
    _projectList.clear();
  }
}
