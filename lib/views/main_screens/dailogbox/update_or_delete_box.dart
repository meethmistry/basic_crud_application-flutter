import 'package:basic_crud_application/views/main_screens/crud_screens/update_students_screen.dart';
import 'package:basic_crud_application/views/main_screens/dailogbox/delete_dailogbox.dart';
import 'package:flutter/material.dart';

class UpdateOrDeleteBox extends StatefulWidget {
  const UpdateOrDeleteBox({super.key, this.studentData});
  final dynamic studentData;

  @override
  State<UpdateOrDeleteBox> createState() => _UpdateOrDeleteBoxState();
}

class _UpdateOrDeleteBoxState extends State<UpdateOrDeleteBox> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.white,
      content: Container(
        alignment: Alignment.center,
        height: 230,
        width: 300,
        decoration: BoxDecoration(
          color: Colors.lightBlueAccent,
          borderRadius: BorderRadius.circular(15),
        ),
        child: const Text(
          "Would you like to modify the details of your item.\n or \nremove the item permanently your item? ",
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
                margin: const EdgeInsets.symmetric(horizontal: 10),
                padding: EdgeInsets.symmetric(vertical: 5),
                alignment: Alignment.center,
                width: 70,
                height: 45,
                decoration: BoxDecoration(
                  color: Colors.lightBlueAccent,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Text(
                  "Back",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 3),
                ),
              ),
            ),
            InkWell(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(
                  builder: (context) {
                    return UpdateStudent(
                      studentData: widget.studentData,
                    );
                  },
                ));
              },
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 10),
                padding: EdgeInsets.symmetric(vertical: 5),
                alignment: Alignment.center,
                height: 45,
                width: 70,
                decoration: BoxDecoration(
                  color: Colors.lightBlueAccent,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Text(
                  "Update",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 3),
                ),
              ),
            ),
            InkWell(
              onTap: () async {
                showDialog(
                  context: context,
                  builder: (context) {
                    return DeleteDailogbox(
                      studentData: widget.studentData,
                    );
                  },
                );
              },
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 10),
                padding: EdgeInsets.symmetric(vertical: 5),
                alignment: Alignment.center,
                height: 45,
                width: 70,
                decoration: BoxDecoration(
                  color: Colors.lightBlueAccent,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Text(
                  "Delete",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 12,
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
