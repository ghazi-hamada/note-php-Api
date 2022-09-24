import 'package:course_php/components/cistomtextform.dart';
import 'package:course_php/components/crud.dart';
import 'package:course_php/components/valid.dart';
import 'package:course_php/constant/linkAPI.dart';
import 'package:flutter/material.dart';

class signup extends StatefulWidget {
  const signup({Key? key}) : super(key: key);

  @override
  _signupState createState() => _signupState();
}

class _signupState extends State<signup> {
  bool isloading = false;
  final Crud _crud = Crud();
  GlobalKey<FormState> formstate = GlobalKey();
  TextEditingController username = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  signup() async {
    if (formstate.currentState!.validate()) {
      try {
        isloading = true;
        setState(() {});
        var response = await _crud.postRequest(linkSignUp, {
          "username": username.text,
          "email": email.text,
          "password": password.text,
        });
        if (response['status'] == "success") {
          Navigator.of(context)
              .pushNamedAndRemoveUntil("success", (route) => false);
        } else {
          print("sign up Feil");
        }
        isloading = false;
      } catch (e) {
        print("$e");
      }
    } else {
      print("Sign up Fail");
    }
  }

  @override
  Widget build(BuildContext context) {
    return isloading
        ? const Center(child: CircularProgressIndicator())
        : Scaffold(
            body: Padding(
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
                        hint: "username",
                        mycontroller: username,
                        valid: (val) => validinput(val!, 3, 20),
                      ),
                      const SizedBox(height: 10),
                      Cistomtextform(
                        hint: "email",
                        mycontroller: email,
                        valid: (val) => validinput(val!, 15, 50),
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
                          const Text("Do have an account?"),
                          InkWell(
                            onTap: () {
                              Navigator.pushReplacementNamed(context, "login");
                            },
                            child: Text(
                              " Sign up",
                              style: TextStyle(color: Colors.blue[600]),
                            ),
                          )
                        ],
                      ),
                      MaterialButton(
                        color: Colors.amber[300],
                        padding: const EdgeInsets.symmetric(
                            horizontal: 70, vertical: 10),
                        onPressed: () async {
                          await signup();
                        },
                        child: const Text("sign up"),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ));
  }
}
