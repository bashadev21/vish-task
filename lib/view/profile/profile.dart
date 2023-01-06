import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:vishtask/model/user_details.dart';
import 'package:vishtask/widgets/appbar.dart';

import '../../constants.dart';
import '../auth/login.dart';

class ProfileView extends StatelessWidget {
  final UserModel userModel;
  const ProfileView({super.key, required this.userModel});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const BaseAppBar(),
      body: Column(
        children: [
          const SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Hero(
                tag: 'profile-pic',
                child: CircleAvatar(
                  radius: 60,
                  backgroundImage: NetworkImage(
                    userModel.avatarUrl!,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 15,
          ),
          Text(
            userModel.name!,
            style: const TextStyle(
                color: Colors.white, fontSize: 22, fontWeight: FontWeight.w500),
          ),
          Text(
            '@${userModel.login!}',
            style: const TextStyle(
                color: Colors.white, fontSize: 15, fontWeight: FontWeight.w500),
          ),
          const SizedBox(
            height: 20,
          ),
          ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
              onPressed: () {
                GetStorage().remove(gitAuthID);
                Get.offAll(() => LoginView());
              },
              child: const Text('Logout'))
        ],
      ),
    );
  }
}
