import 'projects.dart';

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
  
}


