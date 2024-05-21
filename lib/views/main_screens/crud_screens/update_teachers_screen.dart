import 'package:basic_crud_application/controllers/teachers_controllers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class UpdateTeachersScreen extends StatefulWidget {
  const UpdateTeachersScreen({super.key, this.data});
  final dynamic data;
  @override
  State<UpdateTeachersScreen> createState() => _UpdateTeachersScreenState();
}

class _UpdateTeachersScreenState extends State<UpdateTeachersScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController _fullName = TextEditingController();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _number = TextEditingController();

  final AuthController _auth = AuthController();

  bool _validateEmail(String email) {
    final RegExp emailValidatorRegExp =
        RegExp(r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+.com");
    return emailValidatorRegExp.hasMatch(email);
  }

  bool _validateName(String fullName) {
    final RegExp nameValidatorRegExp = RegExp('[a-zA-Z]');
    return nameValidatorRegExp.hasMatch(fullName);
  }

  bool _validatePhoneNumber(String phoneNumber) {
    final RegExp phoneNumberValidatorRegExp = RegExp(r"(0/91)?[7-9][0-9]{9}");
    return phoneNumberValidatorRegExp.hasMatch(phoneNumber);
  }

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

  saveUser() async {
    if (_formKey.currentState!.validate()) {
      EasyLoading.show(
          indicator: CircularProgressIndicator(
        color: Colors.lightBlueAccent,
        backgroundColor: Colors.transparent,
      ));
      try {
        await _auth
            .updateTeacher(_fullName.text.toString(), _email.text.toString(),
                _number.text.toString(), widget.data['teacherId'].toString())
            .whenComplete(() {
          showSnake("Student Updated Successfull.", Colors.greenAccent);
          EasyLoading.dismiss();
          Navigator.pop(context);
        });
      } catch (e) {
        EasyLoading.dismiss();
        print(e.toString());
      }
      showSnake("Data Updated Successfull.", Colors.blueAccent);
      EasyLoading.dismiss();
    } else {
      showSnake("Fill All Data.", Colors.redAccent.shade700);
      EasyLoading.dismiss();
    }
  }

  @override
  void initState() {
    _fullName.text = widget.data['fullName'].toString();
    _email.text = widget.data['email'].toString();
    _number.text = widget.data['number'].toString();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 4,
        backgroundColor: Colors.lightBlueAccent,
        foregroundColor: Colors.white,
        title: const Text(
          "Update Profile",
          style: TextStyle(
              fontSize: 20, letterSpacing: 3, fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                child: Center(
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const SizedBox(
                          height: 30,
                        ),
                        CircleAvatar(
                            radius: 64,
                            backgroundColor: Colors.lightBlueAccent,
                            child: IconButton(
                                onPressed: () {},
                                icon: const Icon(
                                  Icons.photo,
                                  color: Colors.white,
                                  size: 30,
                                ))),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 15, vertical: 8),
                          child: TextFormField(
                            controller: _fullName,
                            decoration: const InputDecoration(
                              labelText: "Full Name",
                            ),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Name can't be empty!";
                              } else if (!_validateName(value)) {
                                return "Enter vailed name!";
                              }
                              return null;
                            },
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 15, vertical: 8),
                          child: TextFormField(
                            controller: _email,
                            decoration: const InputDecoration(
                              labelText: "Email",
                            ),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Email can't be empty!";
                              } else if (!_validateEmail(value)) {
                                return "Enter vailed email!";
                              }
                              return null;
                            },
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 15, vertical: 8),
                          child: TextFormField(
                            controller: _number,
                            decoration: const InputDecoration(
                              labelText: "Number",
                            ),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Number can't be empty!";
                              } else if (!_validatePhoneNumber(value)) {
                                return "Enter vailed number!";
                              }
                              return null;
                            },
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        InkWell(
                          onTap: () {
                            saveUser();
                          },
                          child: Container(
                            alignment: Alignment.center,
                            height: 60,
                            width: MediaQuery.sizeOf(context).width - 45,
                            decoration: BoxDecoration(
                              color: Colors.lightBlueAccent,
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: const Text(
                              "Update Profile",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 2,
                                  fontSize: 22),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
