import 'package:basic_crud_application/views/auth/registration_screen.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.greenAccent.shade700,
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: Container(
                margin: EdgeInsets.only(top: 170),
                alignment: Alignment.center,
                height: 470,
                width: MediaQuery.sizeOf(context).width - 20,
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
                      SizedBox(
                        height: 10,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: TextFormField(
                          decoration: InputDecoration(
                            labelText: "Email",
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: TextFormField(
                          decoration: InputDecoration(
                            labelText: "Password",
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Container(
                        alignment: Alignment.center,
                        height: 60,
                        width: MediaQuery.sizeOf(context).width - 40,
                        decoration: BoxDecoration(
                          color: Colors.greenAccent.shade700,
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Text(
                          "LogIn",
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 2,
                              fontSize: 22),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("Don't have an account?"),
                          TextButton(
                              onPressed: () {
                                Navigator.push(context, MaterialPageRoute(
                                  builder: (context) {
                                    return RegistrationScreen();
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
    );
  }
}
