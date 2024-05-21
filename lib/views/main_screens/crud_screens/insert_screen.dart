import 'dart:typed_data';
import 'package:basic_crud_application/controllers/students_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:image_picker/image_picker.dart';

class AddNewStudent extends StatefulWidget {
  const AddNewStudent({super.key});

  @override
  State<AddNewStudent> createState() => _AddNewStudentState();
}

class _AddNewStudentState extends State<AddNewStudent> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController _fullName = TextEditingController();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _number = TextEditingController();
  final TextEditingController _age = TextEditingController();
  final TextEditingController _address = TextEditingController();

  final StudentController _auth = StudentController();

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

  bool _validateAge(String age) {
    final RegExp ageValidatorRegExp = RegExp(r'^\d+$');
    return ageValidatorRegExp.hasMatch(age);
  }

  Uint8List? selectedImage;
  selectImage() async {
    Uint8List? image = await _auth.pickProfileImage(ImageSource.gallery);
    setState(() {
      selectedImage = image;
    });
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

  saveStudent() async {
    if (_formKey.currentState!.validate()) {
      EasyLoading.show(
          indicator: const CircularProgressIndicator(
        color: Colors.lightBlueAccent,
        backgroundColor: Colors.transparent,
      ));
      try {
        await _auth
            .addNewStudent(
                _fullName.text.toString(),
                _email.text.toString(),
                _number.text.toString(),
                _age.text.toString(),
                _address.text.toString(),
                selectedImage)
            .whenComplete(() {
          showSnake("New Student Added Successfull.", Colors.greenAccent);
          _formKey.currentState!.reset();
          selectedImage = null;
          EasyLoading.dismiss();
          Navigator.pop(context);
        });
      } catch (e) {
        EasyLoading.dismiss();
        print(e.toString());
      }
    } else {
      EasyLoading.dismiss();
      showSnake("Enter Vailed Data.", Colors.redAccent);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.lightBlueAccent,
        foregroundColor: Colors.white,
        title: const Text(
          "Add New Student",
          style: TextStyle(
              fontSize: 20, letterSpacing: 3, fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Center(
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 25),
              alignment: Alignment.center,
              width: MediaQuery.sizeOf(context).width - 25,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
              ),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    selectedImage == null
                        ? CircleAvatar(
                            radius: 64,
                            backgroundColor: Colors.lightBlueAccent,
                            child: IconButton(
                                onPressed: () {
                                  selectImage();
                                },
                                icon: const Icon(
                                  Icons.photo,
                                  color: Colors.white,
                                  size: 30,
                                )),
                          )
                        : CircleAvatar(
                            radius: 64,
                            backgroundColor: Colors.greenAccent.shade700,
                            backgroundImage: MemoryImage(selectedImage!),
                          ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 8),
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
                          horizontal: 10, vertical: 8),
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
                          horizontal: 10, vertical: 8),
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
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 8),
                      child: TextFormField(
                        controller: _age,
                        decoration: const InputDecoration(
                          labelText: "Age",
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your age';
                          } else if (!_validateAge(value)) {
                            return 'Please enter a valid age';
                          } else if (int.parse(value) <= 18 &&
                              int.parse(value) >= 54) {
                            return 'Age must be in range (18 - 54)';
                          }

                          return null;
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 8),
                      child: TextFormField(
                        controller: _address,
                        decoration: const InputDecoration(
                          labelText: "Address",
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Address can't be empty!";
                          } else {
                            return null;
                          }
                        },
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    InkWell(
                      onTap: () {
                        saveStudent();
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
                          "Add New Student",
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
        ),
      ),
    );
  }
}
