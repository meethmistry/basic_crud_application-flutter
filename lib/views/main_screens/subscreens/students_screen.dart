import 'package:basic_crud_application/views/main_screens/crud_screens/display_all_detail_screen.dart';
import 'package:basic_crud_application/views/main_screens/crud_screens/insert_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class StudentsScreen extends StatefulWidget {
  const StudentsScreen({super.key});

  @override
  State<StudentsScreen> createState() => _StudentsScreenState();
}

class _StudentsScreenState extends State<StudentsScreen> {
  final Stream<QuerySnapshot> _studentStream = FirebaseFirestore.instance
      .collection('students')
      .where('mentorId', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
      .snapshots();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 4,
        backgroundColor: Colors.lightBlueAccent,
        foregroundColor: Colors.white,
        title: const Text(
          "Students",
          style: TextStyle(
              fontSize: 20, letterSpacing: 3, fontWeight: FontWeight.bold),
        ),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: _studentStream,
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return const Text('Something went wrong');
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(
                color: Colors.blue.shade900,
              ),
            );
          }

          return ListView.builder(
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (context, index) {
              final studentData = snapshot.data!.docs[index];
              return InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return DisplayAllDetails(studentData: studentData,);
                      },
                    ),
                  );
                },
                onLongPress: () {},
                child: Container(
                  height: 75,
                  width: MediaQuery.sizeOf(context).width - 20,
                  margin:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 5, vertical: 2.5),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      const BoxShadow(
                          color: Colors.grey,
                          blurRadius: 5,
                          offset: Offset(3, 5))
                    ],
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: ListTile(
                    title: Text(
                      studentData['studentName'],
                      style: const TextStyle(
                          fontWeight: FontWeight.w400, fontSize: 16),
                    ),
                    subtitle: Text(
                      studentData['studentEmail'],
                      style: const TextStyle(fontSize: 12),
                    ),
                    trailing: const Icon(
                      Icons.arrow_forward_ios,
                      color: Color.fromARGB(255, 104, 103, 103),
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.lightBlueAccent,
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
