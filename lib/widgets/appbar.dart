import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:vishtask/constants.dart';
import 'package:vishtask/view/auth/login.dart';

class BaseAppBar extends StatelessWidget implements PreferredSizeWidget {
  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
  const BaseAppBar({
    Key? key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,
      centerTitle: true,
      title: Image.asset(
        githubLogo,
        height: 30,
        color: Colors.white,
      ),
      actions: [
        IconButton(
            onPressed: () {
              GetStorage().remove(gitAuthID);
              Get.offAll(() => LoginView());
            },
            icon: const Icon(
              Icons.logout,
              color: Colors.white,
            ))
      ],
      backgroundColor: Colors.black,
    );
  }
}
