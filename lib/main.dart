import 'package:flutter/material.dart';
import 'package:manahattan_cda_34/models/project.dart';
import 'package:manahattan_cda_34/pages/contribution-page.dart';
import 'package:manahattan_cda_34/pages/projects-page.dart';

void main() {
  runApp(const ProjectManhattanApp());
}

class ProjectManhattanApp extends StatelessWidget {
  const ProjectManhattanApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Gestion de projets",
      home: HomeScreen(),
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        primarySwatch: Colors.indigo,
        scaffoldBackgroundColor: Color(0xffeceaea),
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.indigo,
          foregroundColor: Colors.white,
        ),
      ),
    );
  }
}

class HomeScreen extends StatefulWidget {
  HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  final List<Project> _projects = [
    Project(title: "Projet Manhattan", desc: "Un projet vraiment énorme"),
    Project(title: "Projet important", desc: "Un projet très important"),
    Project(
      title: "Projet impofdfsdfrtant",
      desc: "Un projet très imfgfgportant",
    ),
  ];

  void _addProject() {
    setState(() {
      int num = _projects.length + 1;
      _projects.add(
        Project(title: "Nouveau projet $num", desc: "Nouveau projet"),
      );
    });
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Mes projets"),
        centerTitle: true,
        leading: Icon(Icons.rocket_launch),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.grey,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.folder_outlined),
            label: "Projets",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add_circle_outline),
            label: "Contribuer",
          ),
        ],
      ),
      floatingActionButton: ProjectFAB(addProjectCallback: _addProject),
      body: _selectedIndex == 0
          ? ProjectsPage(projects: _projects)
          : ContributionPage(),
    );
  }
}

class ProjectFAB extends StatelessWidget {
  void Function() _addProjectCallback;

  ProjectFAB({required addProjectCallback})
    : _addProjectCallback = addProjectCallback;

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      child: Icon(Icons.add, size: 40),
      onPressed: _addProjectCallback,
    );
  }
}
