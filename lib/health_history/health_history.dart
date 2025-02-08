import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class HealthHistoryPage extends StatefulWidget {
  final String uid; // The user's UID passed from the previous screen or Firebase authentication

  HealthHistoryPage({required this.uid});

  @override
  _HealthHistoryPageState createState() => _HealthHistoryPageState();
}

class _HealthHistoryPageState extends State<HealthHistoryPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _diseaseController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _statusController = TextEditingController();
  final TextEditingController _doctorController = TextEditingController();
  final TextEditingController _medicationController = TextEditingController();

  Future<void> saveHealthHistory() async {
    if (_formKey.currentState!.validate()) {
      // Convert medication input to an array
      List<String> medications = _medicationController.text.split(',').map((med) => med.trim()).toList();

      // Prepare the health history map
      Map<String, dynamic> healthHistory = {
        'disease_name': _diseaseController.text,
        'diagnosed_date': _dateController.text,
        'status': _statusController.text,
        'medication': medications,
        'doctor_name': _doctorController.text,
      };

      // Add health history to Firestore
      FirebaseFirestore.instance
          .collection('Users')
          .doc(widget.uid)  // User's UID
          .collection('healthHistory')
          .add(healthHistory)
          .then((value) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Medical History Updated!")));
        // Clear the form
        _formKey.currentState!.reset();
      }).catchError((error) {
        print("🔥 Firestore Error: $error"); 
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Failed to update medical history")));
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Health History",
        style: TextStyle(
          color:Colors.white
        ),),
        backgroundColor: Color.fromRGBO(10, 78, 159, 1),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                controller: _diseaseController,
                decoration: InputDecoration(labelText: "Disease Name"),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a disease name';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _dateController,
                decoration: InputDecoration(labelText: "Diagnosed Date (YYYY-MM-DD)"),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a diagnosed date';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _statusController,
                decoration: InputDecoration(labelText: "Status"),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the status of the disease';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _doctorController,
                decoration: InputDecoration(labelText: "Doctor Name"),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the doctor\'s name';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _medicationController,
                decoration: InputDecoration(labelText: "Medication (comma separated)"),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the medication';
                  }
                  return null;
                },
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: ElevatedButton(
                   style: ElevatedButton.styleFrom(
    backgroundColor: Color.fromRGBO(10, 78, 159, 1),
     // Text color
  ),
                  onPressed: saveHealthHistory,
                  child: Text("Save Health History",
                  style: TextStyle(
                    color: Colors.white
                  ),),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
