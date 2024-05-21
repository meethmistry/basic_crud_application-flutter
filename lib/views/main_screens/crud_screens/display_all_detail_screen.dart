import 'package:basic_crud_application/views/main_screens/dailogbox/delete_dailogbox.dart';
import 'package:basic_crud_application/views/main_screens/crud_screens/update_screen.dart';
import 'package:flutter/material.dart';

class DisplayAllDetails extends StatelessWidget {
  const DisplayAllDetails({super.key, this.studentData});
  final dynamic studentData;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 4,
        backgroundColor: Colors.lightBlueAccent,
        foregroundColor: Colors.white,
        title: const Text(
          "Student Details",
          style: TextStyle(
              fontSize: 20, letterSpacing: 3, fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                IconButton(
                  onPressed: ()  {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return DeleteDailogbox(studentData: studentData,);
                      },
                    );
                  },
                  icon: Icon(
                    Icons.delete,
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
                backgroundImage: studentData['studentImageUrl'] != null ? NetworkImage(
                  studentData['studentImageUrl'].toString()) : null,
                backgroundColor: studentData['studentImageUrl'] != null ? null : Colors.lightBlueAccent,  
              radius: 70,
            ),
            const SizedBox(
              height: 25,
            ),
            Container(
              padding: const EdgeInsets.only(left: 35),
              child: ListTile(
                title: Text(
                  studentData['studentName'].toString(),
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 18),
                ),
                subtitle: Text(
                  studentData['studentEmail'].toString(),
                  style: const TextStyle(
                      fontWeight: FontWeight.w700, fontSize: 15),
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Divider(
                color: Colors.greenAccent.shade700,
                height: 2.5,
              ),
            ),
            const SizedBox(
              height: 25,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Student ID : ",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  Flexible(
                    child: Text(
                      studentData['studentId'].toString(),
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
              padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
              child: Row(
                children: [
                  const Text(
                    "Age : ",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    studentData['studentAge'].toString(),
                    style: const TextStyle(
                        fontSize: 18, fontWeight: FontWeight.w500),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Address : ",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  Flexible(
                    child: Text(
                      studentData['studentAddress'].toString(),
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
              padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
              child: Row(
                children: [
                  const Text(
                    "Mobile Number : ",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    studentData['studentNumber'].toString(),
                    style: const TextStyle(
                        fontSize: 18, fontWeight: FontWeight.w500),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomSheet: InkWell(
        onTap: () {
          Navigator.push(context, MaterialPageRoute(
            builder: (context) {
              return UpdateStudent(
                studentData: studentData,
              );
            },
          ));
        },
        child: Container(
          alignment: Alignment.center,
          margin: EdgeInsets.all(15),
          height: 60,
          width: MediaQuery.sizeOf(context).width - 45,
          decoration: BoxDecoration(
              color: Colors.lightBlueAccent,
              borderRadius: BorderRadius.circular(25)),
          child: Text(
            "Update Student Details",
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
                letterSpacing: 3,
                color: Colors.white),
          ),
        ),
      ),
    );
  }
}
