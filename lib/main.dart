import 'package:course_php/app/auth/login.dart';
import 'package:course_php/app/auth/signup.dart';
import 'package:course_php/app/auth/succsess.dart';
import 'package:course_php/app/home.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

late SharedPreferences sharedPref;
void main(List<String> args) async {
  WidgetsFlutterBinding.ensureInitialized();
  sharedPref = await SharedPreferences.getInstance();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "course php",
      initialRoute: sharedPref.getString("id") == null ? "login" : "home",
      routes: {
        "login": (context) => const Login(),
        "signup": (context) => const signup(),
        "home": (context) => const Home(),
        "success": (context) => const Success(),
      },
    );
  }
}
