import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../models/project.dart';

class ProjectDetailPage extends StatefulWidget {
  final Project project;

  const ProjectDetailPage({required this.project, super.key});

  @override
  State<ProjectDetailPage> createState() => _ProjectDetailPageState();
}

class _ProjectDetailPageState extends State<ProjectDetailPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadTasks();
  }

  Future<void> loadTasks() async {
    if (widget.project.tasks.isEmpty) {
      await widget.project.initTasks();
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.project.title),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              context.push("/edit", extra: widget.project);
            },
            icon: Icon(Icons.edit),
          ),
        ],
      ),
      body: Column(
        children: [
          switch (widget.project.status) {
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
            "Date de début : ${widget.project.date?.day}/${widget.project.date?.month}/${widget.project.date?.year}",
            style: TextStyle(color: Colors.black),
          ),
          Text(widget.project.desc, style: TextStyle(color: Colors.black)),
          Flexible(
            child: ListView.builder(
              itemCount: widget.project.tasks.length,
              itemBuilder: (context, index) {
                var task = widget.project.tasks[index];

                return Card(
                  child: ListTile(
                    title: Text(task.name, style: TextStyle(decoration : task.isCompleted ? TextDecoration.lineThrough : TextDecoration.none)),
                    subtitle: task.isCompleted
                        ? Text(
                            "Tâche complétée",
                            style: TextStyle(color: Colors.green),
                          )
                        : Text("Aucun détail"),
                    leading: task.isCompleted
                        ? Icon(Icons.check, color: Colors.green)
                        : Icon(Icons.chevron_right, color: Colors.yellow),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        IconButton(
                          onPressed: () {
                            setState(() {
                              task.isCompleted = !task.isCompleted;
                            });
                          },
                          icon: task.isCompleted
                              ? Icon(Icons.restart_alt,)
                              : Icon(Icons.check_box, color: Colors.yellow),
                        ),
                        IconButton(
                          onPressed: () {
                            setState(() {
                              widget.project.tasks.removeAt(index);
                            });
                          },
                          icon: Icon(Icons.delete_forever_rounded)
                        )
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
