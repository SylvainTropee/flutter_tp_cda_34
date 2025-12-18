import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:manahattan_cda_34/common/contribution-form.dart';

import '../models/project.dart';

class ProjectEditPage extends StatelessWidget {
  final Project project;

  const ProjectEditPage({required this.project, super.key});

  void _onUpdate(Project project, BuildContext context) {
    context.go("/");
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text("Projet ${project.title} édité !")));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(project.title)),
      body: ContributionForm(
        onSubmitForm: (project) {
          _onUpdate(project, context);
        },
        project: project,
      ),
    );
  }
}
