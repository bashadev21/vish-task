import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vishtask/controller/controller.dart';

import '../../widgets/appbar.dart';
import '../profile/profile.dart';
import 'repo_details.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const BaseAppBar(),
        body: GetBuilder<Controller>(builder: ((controller) {
          final user = controller.userData;
          return controller.userData.avatarUrl == null
              ? const LinearProgressIndicator()
              : ListView(
                  controller: controller.scrollcon,
                  children: [
                    ListTile(
                      onTap: () {
                        Get.to(() => ProfileView(
                              userModel: controller.userData,
                            ));
                      },
                      trailing:
                          const Icon(Icons.arrow_forward, color: Colors.white),
                      leading: Hero(
                        tag: 'profile-pic',
                        child: CircleAvatar(
                            backgroundImage:
                                NetworkImage(user.avatarUrl.toString())),
                      ),
                      title: Text(
                        user.name!.toString(),
                        style: const TextStyle(
                            color: Colors.white, fontWeight: FontWeight.w500),
                      ),
                      subtitle: Text(
                        user.login!.toString(),
                        style: const TextStyle(color: Colors.white),
                      ),
                    ),
                    const ListTile(
                      title: Text(
                        'Repositories :',
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.w500),
                      ),
                    ),
                    controller.showLoad
                        ? const SizedBox(
                            height: 300,
                            child: Center(child: CircularProgressIndicator()))
                        : controller.repoData.isEmpty
                            ? const SizedBox(
                                height: 300,
                                child: Center(
                                    child: Text(
                                  'No Repositories Found',
                                  style: TextStyle(color: Colors.white),
                                )))
                            : ListView.builder(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount: controller.repoData.length,
                                itemBuilder: (BuildContext context, int index) {
                                  final repo = controller.repoData[index];
                                  return ListTile(
                                    onTap: () {
                                      controller.getBranchDetails(repo
                                          .branchesUrl
                                          .toString()
                                          .split('{')[0]);
                                      var lastDate = repo.updatedAt
                                          .toString()
                                          .split('T')[0]
                                          .toString()
                                          .split(" ")[0]
                                          .toString()
                                          .split('-');
                                      Get.to(() => RepoDetailsView(
                                            name: repo.name,
                                            lastUpdate:
                                                '${lastDate[2]}-${lastDate[1]}-${lastDate[0]}',
                                            desc: repo.description.toString(),
                                            size: repo.size.toString(),
                                          ));
                                    },
                                    trailing: const Icon(
                                        Icons.arrow_forward_ios_rounded,
                                        size: 13,
                                        color: Colors.white),
                                    leading: const Icon(Icons.book,
                                        color: Colors.white),
                                    title: Text(repo.name,
                                        style: const TextStyle(
                                            color: Colors.white)),
                                  );
                                },
                              ),
                    if (controller.isLoadMoreRunning == true)
                      const Padding(
                        padding: EdgeInsets.only(top: 10, bottom: 40),
                        child: Center(
                          child: CircularProgressIndicator(),
                        ),
                      ),
                    if (controller.hasNextPage == false)
                      Container(
                        padding: const EdgeInsets.only(top: 30, bottom: 40),
                        color: Colors.black,
                        child: const Center(
                          child: Text(
                              'You have fetched all of the repositories',
                              style: TextStyle(color: Colors.white)),
                        ),
                      ),
                    if (controller.orgsData.isNotEmpty)
                      const ListTile(
                        title: Text(
                          'Organisations :',
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.w500),
                        ),
                      ),
                    ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: controller.orgsData.length,
                      itemBuilder: (BuildContext context, int index) {
                        final repo = controller.orgsData[index];
                        return ListTile(
                          leading: const Icon(Icons.book, color: Colors.white),
                          title: Text(repo.login,
                              style: const TextStyle(color: Colors.white)),
                          subtitle: Text(repo.description.toString(),
                              style: const TextStyle(color: Colors.white)),
                        );
                      },
                    ),
                  ],
                );
        })));
  }
}
