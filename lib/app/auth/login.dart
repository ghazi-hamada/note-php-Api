import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:course_php/components/cistomtextform.dart';
import 'package:course_php/components/crud.dart';
import 'package:course_php/constant/linkAPI.dart';
import 'package:course_php/main.dart';
import 'package:flutter/material.dart';

import '../../components/valid.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  Crud crud = Crud();
  bool isLoading = false;
  login() async {
    if (formstate.currentState!.validate()) {
      isLoading = true;
      try {
        var response = await crud.postRequest(linkLogin, {
          "email": email.text,
          "password": password.text,
        });
        if (response["status"] == "success") {
          sharedPref.setString("id", response["data"]["id"].toString());
          sharedPref.setString("username", response["data"]["username"]);
          sharedPref.setString("email", response["data"]["email"]);
          Navigator.of(context)
              .pushNamedAndRemoveUntil("home", (route) => false);
        } else {
          AwesomeDialog(
              context: context,
              title: "تنبيه",
              body: const Center(
                child: Text(
                    "خطأ في ادخال كلمة المرور او البريد الالكتروني او الحساب غير موجود"),
              )).show();
        }
      } catch (e) {
        print(e);
      }
    }
    isLoading = false;
  }

  GlobalKey<FormState> formstate = GlobalKey();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: isLoading
            ? const Center(child: CircularProgressIndicator())
            : Padding(
                padding: const EdgeInsets.all(10.0),
                child: ListView(
                  children: [
                    Form(
                      key: formstate,
                      child: Column(
                        children: [
                          Image.asset(
                            "images/logo.jpg",
                            width: 200,
                            height: 200,
                          ),
                          Cistomtextform(
                            hint: "email",
                            mycontroller: email,
                            valid: (val) => validinput(val!, 5, 50),
                          ),
                          const SizedBox(height: 10),
                          Cistomtextform(
                            hint: "password",
                            mycontroller: password,
                            valid: (val) => validinput(val!, 6, 50),
                          ),
                          const SizedBox(height: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text("Don't have an account?"),
                              InkWell(
                                onTap: () {
                                  Navigator.pushReplacementNamed(
                                      context, "signup");
                                },
                                child: Text(
                                  " Sign up",
                                  style: TextStyle(color: Colors.blue[600]),
                                ),
                              )
                            ],
                          ),
                          const SizedBox(height: 10),
                          MaterialButton(
                            color: Colors.amber[300],
                            padding: const EdgeInsets.symmetric(
                                horizontal: 70, vertical: 10),
                            onPressed: () async {
                              await login();
                            },
                            child: const Text("Log in"),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ));
  }
}
