import 'package:flutter/material.dart';
import 'package:manahattan_cda_34/models/project.dart';

class ContributionForm extends StatefulWidget {
  final Function(Project) onSubmitForm;
  final Project? project;

  const ContributionForm({required this.onSubmitForm, this.project});

  @override
  State<ContributionForm> createState() => _ContributionFormState();
}

class _ContributionFormState extends State<ContributionForm> {
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  DateTime? _pickedDate;
  String? title, desc;
  ProjectStatus? status;
  TextEditingController _dateController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (widget.project?.date != null) {
      _dateController.text =
          "${widget.project?.date?.day}/${widget.project?.date?.month}/${widget.project?.date?.year}";
    }
  }

  void _submitForm() {
    if (_formkey.currentState!.validate()) {
      //TODO création d'un projet et ajout dans la liste
      _formkey.currentState!.save();

      var project = widget.project;

      if (project == null) {
        project = Project(
          title: title ?? "",
          desc: desc ?? "",
          status: status ?? ProjectStatus.upComing,
          date: _pickedDate,
        );
      } else {
        project.title = title ?? "";
        project.desc = desc ?? "";
        project.status = status ?? ProjectStatus.upComing;
        project.date = _pickedDate;
      }
      widget.onSubmitForm(project);
    }
  }

  Future<void> _selectedDate() async {
    var date = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(DateTime.now().year + 2),
    );

    setState(() {
      _pickedDate = date;
      _dateController.text = "${date!.day}/${date.month}/${date.year}";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formkey,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextFormField(
              initialValue: widget.project?.title,
              onSaved: (value) {
                title = value;
              },
              style: TextStyle(color: Colors.black),
              validator: (value) =>
                  value == null || value.isEmpty ? "Champ requis" : null,
              decoration: InputDecoration(
                labelText: "Titre du projet",
                labelStyle: TextStyle(color: Colors.black),
                hintText: "Un nouveau projet",
                hintStyle: TextStyle(color: Colors.black),
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16),
            TextFormField(
              initialValue: widget.project?.desc,
              onSaved: (value) {
                desc = value;
              },
              maxLines: 4,
              validator: (value) =>
                  value == null || value.isEmpty ? "Champ requis" : null,
              style: TextStyle(color: Colors.black),
              decoration: InputDecoration(
                alignLabelWithHint: true,
                labelStyle: TextStyle(color: Colors.black),
                labelText: "Description",
                hintText: "Un nouveau projet",
                hintStyle: TextStyle(color: Colors.black),
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16),
            DropdownButtonFormField<ProjectStatus>(
              initialValue: widget.project?.status,
              onSaved: (value) {
                status = value;
              },
              onChanged: (value) {},
              style: TextStyle(color: Colors.purple),
              decoration: InputDecoration(
                labelText: "Statut",
                labelStyle: TextStyle(color: Colors.black),
              ),
              items: [
                DropdownMenuItem(
                  child: Text("En cours"),
                  value: ProjectStatus.inProgess,
                ),
                DropdownMenuItem(
                  child: Text("Terminé"),
                  value: ProjectStatus.done,
                ),
                DropdownMenuItem(
                  child: Text("A venir"),
                  value: ProjectStatus.upComing,
                ),
              ],
            ),
            SizedBox(height: 16),
            TextFormField(
              readOnly: true,
              controller: _dateController,
              onTap: _selectedDate,
              style: TextStyle(color: Colors.black),
              validator: (value) =>
                  value == null || value.isEmpty ? "Champ requis" : null,
              decoration: InputDecoration(
                labelText: "Date de début",
                labelStyle: TextStyle(color: Colors.black),
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16),
            ElevatedButton.icon(
              onPressed: _submitForm,
              icon: Icon(Icons.send),
              style: ElevatedButton.styleFrom(backgroundColor: Colors.indigo),
              label: Text("Soumettre"),
            ),
          ],
        ),
      ),
    );
  }
}
