import 'dart:typed_data';

import 'package:basic_crud_application/controllers/teachers_controllers.dart';
import 'package:basic_crud_application/views/auth/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({super.key});

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController _fullName = TextEditingController();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _number = TextEditingController();
  final TextEditingController _password = TextEditingController();

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

  saveUser() async {
    if (_formKey.currentState!.validate()) {
      await _auth
          .signUpUser(_fullName.text, _email.text, _number.text, _password.text,
              selectedImage)
          .whenComplete(() {
        setState(() {
          _formKey.currentState!.reset();
          selectedImage = null;
        });
        showSnake("Registration Successfull.", Colors.blueAccent);
      });
    } else {
      showSnake("Fill All Data.", Colors.redAccent.shade700);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.greenAccent.shade700,
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                child: Container(
                  margin: const EdgeInsets.only(top: 80),
                  padding: const EdgeInsets.symmetric(horizontal: 3, vertical: 15),
                  alignment: Alignment.center,
                  height: 700,
                  width: MediaQuery.sizeOf(context).width - 25,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Center(
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "SignUp",
                            style: TextStyle(
                                color: Colors.greenAccent.shade700,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 2,
                                fontSize: 28),
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                         selectedImage == null ?
                          CircleAvatar(
                            radius: 64,
                            backgroundColor: Colors.greenAccent.shade700,
                            child: IconButton(
                                onPressed: () {
                                  selectImage();
                                },
                                icon: const Icon(
                                  Icons.photo,
                                  color: Colors.white,
                                  size: 30,
                                )),
                          ) : CircleAvatar(
                            radius: 64,
                            backgroundColor: Colors.greenAccent.shade700,
                            backgroundImage: MemoryImage(selectedImage!),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
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
                            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
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
                            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
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
                            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
                            child: TextFormField(
                              controller: _password,
                              decoration: const InputDecoration(
                                labelText: "Password",
                              ),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return "Password can't be empty!";
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
                              saveUser();
                            },
                            child: Container(
                              alignment: Alignment.center,
                              height: 60,
                              width: MediaQuery.sizeOf(context).width - 45,
                              decoration: BoxDecoration(
                                color: Colors.greenAccent.shade700,
                                borderRadius: BorderRadius.circular(15),
                              ),
                              child: const Text(
                                "SignUp",
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
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text("Already have an account?"),
                              TextButton(
                                  onPressed: () {
                                    Navigator.push(context, MaterialPageRoute(
                                      builder: (context) {
                                        return const LoginScreen();
                                      },
                                    ));
                                  },
                                  child: Text(
                                    "logIn Now",
                                    style: TextStyle(
                                      color: Colors.greenAccent.shade700,
                                      fontWeight: FontWeight.bold,
                                      // letterSpacing: 2,
                                    ),
                                  ))
                            ],
                          )
                        ],
                      ),
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
