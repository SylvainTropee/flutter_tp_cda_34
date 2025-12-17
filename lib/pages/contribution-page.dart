import 'package:flutter/material.dart';
import 'package:manahattan_cda_34/models/project.dart';

class ContributionPage extends StatefulWidget {
  final Function(Project) onSubmitForm;

  const ContributionPage({required this.onSubmitForm});

  @override
  State<ContributionPage> createState() => _ContributionPageState();
}

class _ContributionPageState extends State<ContributionPage> {
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  DateTime? _pickedDate;
  String? title, desc;
  ProjectStatus? status;
  TextEditingController _dateController = TextEditingController();

  void _submitForm() {
    if (_formkey.currentState!.validate()) {
      //TODO création d'un projet et ajout dans la liste
      _formkey.currentState!.save();
      var project = Project(
        title: title ?? "",
        desc: desc ?? "",
        status: status ?? ProjectStatus.upComing,
        date: _pickedDate,
      );
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
