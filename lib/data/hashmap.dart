import 'dart:collection';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stemcalendar/data/projects.dart';

// creates a Linked HashMap to store the projects by name and allows the hasmap to be accessed and edited
class ProjectRegistry {
  late final SharedPreferencesWithCache prefsWithCache;
  
  ProjectRegistry() {
    initializePrefsWithCache();
    
  }
  Future<void> initializePrefsWithCache() async {
    prefsWithCache = await SharedPreferencesWithCache.create(
      cacheOptions: const SharedPreferencesWithCacheOptions(
        allowList: null,
      ),
    );
  }
  Future<void> saveProjectsToSharedPreferences() async {
    final projectList = projectsByName.entries
        .map((entry) => {'name': entry.key, 'data': entry.value.toJson()})
        .toList();
    await prefsWithCache.setString('projects', projectList.toString());
  }

  Future<void> loadProjectsFromSharedPreferences() async {
    final projectString = prefsWithCache.getString('projects');
    if (projectString != null) {
      final List<dynamic> projectList = List.from(jsonDecode(projectString));
      for (var projectMap in projectList) {
        final name = projectMap['name'];
        final project = Project.fromJson(projectMap['data']);
        projectsByName[name] = project;
      }
    }
  }


  static final LinkedHashMap<String, Project> projectsByName = LinkedHashMap();

  static void addToHashMap(String name, Project project) {
    projectsByName[name] = project;
  }

  static Project? getFromHashMap(String name) {
    return projectsByName[name];
  }

  static LinkedHashMap<String, Project> getProjectsByName() {
    return projectsByName;
  }
}
