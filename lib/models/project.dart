import 'package:manahattan_cda_34/models/task.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

enum ProjectStatus { inProgess, done, upComing }

class Project {
  String _title;
  String _desc;
  ProjectStatus _status;
  DateTime? _date;
  List<Task> tasks = [];

  Project({
    required String title,
    required String desc,
    ProjectStatus status = ProjectStatus.upComing,
    DateTime? date,
  }) : _title = title,
       _desc = desc,
       _status = status,
       _date = date;

  String get desc => _desc;

  set desc(String value) {
    _desc = value;
  }

  String get title => _title;

  set title(String value) {
    _title = value;
  }

  DateTime? get date => _date;

  set date(DateTime? value) {
    _date = value;
  }

  ProjectStatus get status => _status;

  set status(ProjectStatus value) {
    _status = value;
  }

  Future<void> initTasks() async {
    var response = await http.get(
      Uri.parse("https://jsonplaceholder.typicode.com/users/1/todos"),
    );

    if (response.statusCode == 200) {
      tasks = List.from(
          jsonDecode(response.body).map((t) => Task.fromJson(t)));
    }
  }

  @override
  String toString() {
    return 'Project{_title: $_title, _desc: $_desc, _status: $_status, _date: $_date}';
  }
}
