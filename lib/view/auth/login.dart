import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:github_sign_in/github_sign_in.dart';
import 'package:vishtask/controller/controller.dart';
import 'package:get/get.dart';
import '../../constants.dart';

class LoginView extends StatelessWidget {
  LoginView({super.key});
  final Controller con = Get.find();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton.icon(
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 12),
              backgroundColor: Colors.black,
            ),
            onPressed: () => con.signInWithGitHub(),
            icon: Padding(
              padding: const EdgeInsets.only(right: 10),
              child: Image.asset(githubLogo, height: 30, color: Colors.white),
            ),
            label: const Text('Continue with github')),
      ),
    );
  }
}
