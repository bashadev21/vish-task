import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:github_sign_in/github_sign_in.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:vishtask/model/branch_details.dart';
import 'package:vishtask/model/orgs_details.dart';
import 'package:vishtask/model/repo_details.dart';
import 'package:vishtask/view/home/home.dart';

import '../api_urls.dart';
import '../base_client.dart';
import 'package:get/get.dart';

import '../constants.dart';
import '../model/user_details.dart';

class Controller extends GetxController with BaseController {
  UserModel userData = UserModel();
  List<RepoModel> repoData = [];
  List<OrgsModel> orgsData = [];
  List<BranchModel> branchData = [];

  var localStorage = GetStorage();
  var showLoad = false;
  //repo page number
  int _page = 1;

  //repo page limit
  final int _limit = 30;
  late ScrollController scrollcon;

  //reload endpoint for pagination
  var repoEndPoint = '';
  @override
  void onInit() {
    init();
    super.onInit();
  }

  bool hasNextPage = true;
  bool isLoadMoreRunning = false;

  void init() {
    if (GetStorage().read(gitAuthID) != null) {
      getUserDetails();
      scrollcon = ScrollController()..addListener(_loadMore);
    }
  }

  void _loadMore() async {
    if (hasNextPage == true &&
        showLoad == false &&
        isLoadMoreRunning == false &&
        scrollcon.position.extentAfter < 300) {
      isLoadMoreRunning = true; // Display a progress indicator at the bottom
      update();
      _page += 1; // Increase _page by 1
      try {
        getRepoDetails(repoEndPoint);
      } catch (err) {
        if (kDebugMode) {
          print('Something went wrong!');
        }
      }
      isLoadMoreRunning = false;
      update();
    }
  }

  Future signInWithGitHub() async {
    showLoading('Authenticating');
    // Create a GitHubSignIn instance
    final GitHubSignIn gitHubSignIn = GitHubSignIn(
        clientId: clientId,
        clientSecret: clientSecrect,
        redirectUrl: redirectUrl);

    // Trigger the sign-in flow
    final result = await gitHubSignIn.signIn(Get.context);

    // Create a credential from the access token
    if (result.token != null) {
      final githubAuthCredential = GithubAuthProvider.credential(result.token);
      GetStorage().write(gitAuthID, result.token.toString());
      // Once signed in, return the UserCredential
      await FirebaseAuth.instance.signInWithCredential(githubAuthCredential);
      //Success-Redirection
      init();
      hideLoading();
      Get.offAll(() => const HomeView());
    } else {
      hideLoading();
      debugPrint("User cancelled");
    }
  }

  Future getUserDetails() async {
    var response =
        await BaseClient().get(baseUrl + userDetails).catchError(handleError);
    if (response == null) return;
    userData = userModelFromJson(response);
    getRepoDetails(userData.reposUrl);
    repoEndPoint = userData.reposUrl!;
    getOrgsDetails(userData.organizationsUrl);
    update();
  }

  Future getRepoDetails(endPoint) async {
    if (_page == 1) {
      showLoad = true;
    }
    var response = await BaseClient()
        .get(endPoint + '?per_page=$_limit&page=$_page')
        .catchError(handleError);
    if (response == null) return;
    var fetchrepoData = repoModelFromJson(response);
    if (fetchrepoData.isEmpty) {
      hasNextPage = false;
    } else {
      repoData.addAll(fetchrepoData);
    }
    if (_page == 1) {
      showLoad = false;
    }
    update();
  }

  Future getOrgsDetails(endPoint) async {
    var response = await BaseClient().get(endPoint).catchError(handleError);
    if (response == null) return;
    orgsData = orgsModelFromJson(response);
    update();
  }

  Future getBranchDetails(endPoint) async {
    var response = await BaseClient().get(endPoint).catchError(handleError);
    if (response == null) return;
    branchData = branchModelFromJson(response);
    update();
  }
}
