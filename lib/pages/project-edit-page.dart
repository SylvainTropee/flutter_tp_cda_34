import 'package:flutter/material.dart';
import 'package:manahattan_cda_34/common/contribution-form.dart';

import '../models/project.dart';

class ProjectEditPage extends StatelessWidget {
  final Project project;
  const ProjectEditPage({required this.project, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(project.title)),
      body: ContributionForm(onSubmitForm: (Project) {}, project : project),
    );
  }
}
