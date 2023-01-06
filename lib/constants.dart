import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'view/auth/login.dart';
import 'view/home/home.dart';

//Git credentials

const clientId = '1cd1085f73cc090c85ae';
const clientSecrect = '98134a622b52e504f656aa0f2cf21d9561633771';
const redirectUrl = 'https://vish-task.firebaseapp.com/__/auth/handler';

//Colors

const backgroundColor = Color(0xff24292e);

//Images

const githubLogo = 'assets/github-mark.png';

//Local storage Keys

const gitAuthID = 'token';

//Route

Widget get initScreen =>
    GetStorage().read(gitAuthID) != null ? const HomeView() : LoginView();
