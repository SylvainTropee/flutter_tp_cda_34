import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:manahattan_cda_34/models/project.dart';
import 'package:manahattan_cda_34/pages/home-page.dart';
import 'package:manahattan_cda_34/pages/project-detail-page.dart';
import 'package:manahattan_cda_34/pages/project-edit-page.dart';

void main() {
  runApp(const ProjectManhattanApp());
}

final GoRouter _router = GoRouter(
  routes: [
    GoRoute(path: "/", builder: (context, state) => HomeScreen()),
    GoRoute(
      path: "/detail",
      builder: (context, state) {
        Project project = state.extra as Project;
        return ProjectDetailPage(project: project);
      },
    ),
    GoRoute(
      path: "/edit",
      builder: (context, state) {
        Project project = state.extra as Project;
        return ProjectEditPage(project: project);
      },
    ),
  ],
);

class ProjectManhattanApp extends StatelessWidget {
  const ProjectManhattanApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: _router,
      title: "Gestion de projets",
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
