import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:manahattan_cda_34/models/project.dart';
import '../common/contribution-form.dart';

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

  void onSubmitForm(Project project) {
    setState(() {
      _projects.add(project);
      _selectedIndex = 0;
    });

    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text("Projet ${project.title} ajouté !")));
  }

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
        title: Text(_selectedIndex == 0 ? "Mes projets" : "Contribuer"),
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
          : ContributionForm(onSubmitForm: onSubmitForm),
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

class ProjectsPage extends StatelessWidget {
  final List<Project> _projects;

  const ProjectsPage({required projects}) : _projects = projects;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: EdgeInsets.all(16),
      itemCount: _projects.length,
      itemBuilder: (context, index) {
        return Card(
          margin: EdgeInsets.symmetric(vertical: 8),
          child: ListTile(
            leading: Icon(Icons.work_outline_outlined, color: Colors.indigo),
            title: Text(_projects[index].title),
            subtitle: Text(_projects[index].desc),
            trailing: Icon(Icons.arrow_forward_ios),
            onTap: () {
              context.push("/detail", extra: _projects[index]);
            },
          ),
        );
      },
    );
  }
}
