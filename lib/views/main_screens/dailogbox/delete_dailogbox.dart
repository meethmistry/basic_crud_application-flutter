import 'package:basic_crud_application/controllers/students_controller.dart';
import 'package:basic_crud_application/views/main_screens/main_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class DeleteDailogbox extends StatefulWidget {
  const DeleteDailogbox({super.key, this.studentData});
  final dynamic studentData;

  @override
  State<DeleteDailogbox> createState() => _DeleteDailogboxState();
}

class _DeleteDailogboxState extends State<DeleteDailogbox> {
  final StudentController _auth = StudentController();

  showSnake(String msg, Color color) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        backgroundColor: color,
        content: Text(
          msg,
          style: const TextStyle(
              color: Colors.white,
              fontSize: 15,
              letterSpacing: 2,
              fontWeight: FontWeight.bold),
        )));
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.white,
      content: Container(
        alignment: Alignment.center,
        height: 150,
        width: 280,
        decoration: BoxDecoration(
          color: Colors.lightBlueAccent,
          borderRadius: BorderRadius.circular(15),
        ),
        child: const Text(
          "Sure! you want to delete student.",
          textAlign: TextAlign.center,
          style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.w600,
              letterSpacing: 3),
        ),
      ),
      actions: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            InkWell(
              onTap: () {
                Navigator.of(context).pop();
              },
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 20),
                alignment: Alignment.center,
                height: 45,
                width: 80,
                decoration: BoxDecoration(
                  color: Colors.lightBlueAccent,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Text(
                  "No",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 3),
                ),
              ),
            ),
            InkWell(
              onTap: () async {
                EasyLoading.show(
                    indicator: const CircularProgressIndicator(
                  color: Colors.lightBlueAccent,
                  backgroundColor: Colors.transparent,
                ));
                await _auth
                    .deleteStudent(widget.studentData['studentId'].toString());
                showSnake(
                    "Student Deleted Successfully", Colors.redAccent);
                EasyLoading.dismiss();
                Navigator.push(context, MaterialPageRoute(
                  builder: (context) {
                    return const MainHomeScreen();
                  },
                ));
              },
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 20),
                alignment: Alignment.center,
                height: 45,
                width: 80,
                decoration: BoxDecoration(
                  color: Colors.lightBlueAccent,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Text(
                  "Yes",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 3),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
