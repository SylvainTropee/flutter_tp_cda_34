import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../models/project.dart';

class ProjectDetailPage extends StatelessWidget {
  final Project project;

  const ProjectDetailPage({required this.project, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(project.title),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              context.push("/edit", extra: project);
            },
            icon: Icon(Icons.edit),
          ),
        ],
      ),
      body: Column(
        children: [
          switch (project.status) {
            ProjectStatus.inProgess => Text(
              "Statut : En cours",
              style: TextStyle(color: Colors.amber),
            ),
            ProjectStatus.done => Text(
              "Statut : Terminé",
              style: TextStyle(color: Colors.amber),
            ),
            ProjectStatus.upComing => Text(
              "Statut : A venir",
              style: TextStyle(color: Colors.amber),
            ),
          },
          Text(
            "Date de début : ${project.date?.day}/${project.date?.month}/${project.date?.year}",
            style: TextStyle(color: Colors.black),
          ),
          Text(project.desc, style: TextStyle(color: Colors.black)),
        ],
      ),
    );
  }
}
