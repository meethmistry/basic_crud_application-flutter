import 'package:basic_crud_application/views/main_screens/crud_screens/insert_screen.dart';
import 'package:flutter/material.dart';

class StudentsScreen extends StatelessWidget {
  const StudentsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 4,
        backgroundColor: Colors.greenAccent.shade700,
        foregroundColor: Colors.white,
        title: const Text(
          "Students",
          style: TextStyle(
              fontSize: 20, letterSpacing: 3, fontWeight: FontWeight.bold),
        ),
      ),
      body: const Column(
        children: [
          
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.greenAccent.shade700,
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(
            builder: (context) {
              return const AddNewStudent();
            },
          ));
        },
        child: const Icon(
          Icons.add,
          color: Colors.white,
          size: 25,
        ),
      ),
    );
  }
}
