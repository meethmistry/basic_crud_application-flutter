import 'package:basic_crud_application/views/auth/login_screen.dart';
import 'package:basic_crud_application/views/main_screens/crud_screens/update_teachers_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AccountScreen extends StatefulWidget {
  const AccountScreen({super.key});

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  CollectionReference teachers =
      FirebaseFirestore.instance.collection('teachers');

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<DocumentSnapshot>(
      future: teachers.doc(FirebaseAuth.instance.currentUser!.uid).get(),
      builder:
          (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        if (snapshot.hasError) {
          return const Text("Something went wrong");
        }

        if (snapshot.hasData && !snapshot.data!.exists) {
          return const Text("Document does not exist");
        }

        if (snapshot.connectionState == ConnectionState.done) {
          Map<String, dynamic> data =
              snapshot.data!.data() as Map<String, dynamic>;
          return Scaffold(
            appBar: AppBar(
              elevation: 4,
              backgroundColor: Colors.lightBlueAccent,
              foregroundColor: Colors.white,
              title: const Text(
                "Profile",
                style: TextStyle(
                    fontSize: 20,
                    letterSpacing: 3,
                    fontWeight: FontWeight.bold),
              ),
            ),
            body: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    IconButton(
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(
                          builder: (context) {
                            return UpdateTeachersScreen(data: data,);
                          },
                        ));
                      },
                      icon: const Icon(
                        Icons.edit,
                        size: 30,
                        color: Colors.lightBlueAccent,
                      ),
                    ),
                    const SizedBox(
                      width: 20,
                    )
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                CircleAvatar(
                  radius: 64,
                  backgroundColor: Colors.blue.shade500,
                  backgroundImage: NetworkImage(data['profileImage']),
                ),
                const SizedBox(
                  height: 15,
                ),
                Text(
                  data['fullName'],
                  style: const TextStyle(
                      fontSize: 17, fontWeight: FontWeight.bold),
                ),
                Text(
                  data['email'],
                  style: const TextStyle(
                      fontSize: 15, fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 20,
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: Divider(
                    color: Colors.lightBlueAccent,
                    height: 2.5,
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Teacher ID : ",
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      Flexible(
                        child: Text(
                          data['teacherId'].toString(),
                          style: const TextStyle(
                              fontSize: 18, fontWeight: FontWeight.w500),
                          maxLines: null,
                          overflow: TextOverflow.visible,
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Mobile Number : ",
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      Flexible(
                        child: Text(
                          data['number'].toString(),
                          style: const TextStyle(
                              fontSize: 18, fontWeight: FontWeight.w500),
                          maxLines: null,
                          overflow: TextOverflow.visible,
                        ),
                      ),
                    ],
                  ),
                ),
                ListTile(
                  onTap: () {},
                  leading: const Icon(Icons.settings),
                  title: const Text("Setting"),
                ),
                ListTile(
                  onTap: () async {
                    await _auth.signOut().whenComplete(() {
                      Navigator.push(context, MaterialPageRoute(
                        builder: (context) {
                          return const LoginScreen();
                        },
                      ));
                    });
                  },
                  leading: const Icon(Icons.logout),
                  title: const Text("Logout"),
                ),
              ],
            ),
          );
        }

        return const CircularProgressIndicator();
      },
    );
  }
}
