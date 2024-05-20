import 'package:basic_crud_application/controllers/teachers_controllers.dart';
import 'package:basic_crud_application/views/auth/registration_screen.dart';
import 'package:basic_crud_application/views/main_screens/main_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();

  final AuthController _auth = AuthController();

  bool _validateEmail(String email) {
    final RegExp emailValidatorRegExp =
        RegExp(r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+.com");
    return emailValidatorRegExp.hasMatch(email);
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

  loginUser() async {
    if (_formKey.currentState!.validate()) {
      EasyLoading.show(
          indicator: CircularProgressIndicator(
        color: Colors.greenAccent,
        backgroundColor: Colors.transparent,
      ));
      String res = await _auth.loginUsers(_email.text, _password.text);
      if (res == "Success") {
        Navigator.push(context, MaterialPageRoute(
          builder: (context) {
            EasyLoading.dismiss();
            return MainHomeScreen();
          },
        ));
      } else {
        EasyLoading.dismiss();
        showSnake("Inccorect email or password.", Colors.redAccent.shade700);
      }
    } else {
      EasyLoading.dismiss();
      showSnake("Login data are not valid", Colors.redAccent.shade700);
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
                  margin: const EdgeInsets.only(top: 170),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 3, vertical: 15),
                  alignment: Alignment.center,
                  height: 470,
                  width: MediaQuery.sizeOf(context).width - 25,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "LogIn",
                          style: TextStyle(
                              color: Colors.greenAccent.shade700,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 2,
                              fontSize: 28),
                        ),
                        const SizedBox(
                          height: 10,
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
                            loginUser();
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
                              "LogIn",
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
                            const Text("Don't have an account?"),
                            TextButton(
                                onPressed: () {
                                  Navigator.push(context, MaterialPageRoute(
                                    builder: (context) {
                                      return const RegistrationScreen();
                                    },
                                  ));
                                },
                                child: Text(
                                  "SignUp Now",
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
            ],
          ),
        ),
      ),
    );
  }
}
