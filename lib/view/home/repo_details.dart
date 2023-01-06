import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vishtask/widgets/appbar.dart';

import '../../controller/controller.dart';

class RepoDetailsView extends StatelessWidget {
  final String name, lastUpdate, desc, size;
  const RepoDetailsView(
      {super.key,
      required this.name,
      required this.lastUpdate,
      required this.desc,
      required this.size});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: BaseAppBar(),
        body: GetBuilder<Controller>(builder: ((controller) {
          return ListView(
            children: [
              ListTile(
                title: Text(name, style: const TextStyle(color: Colors.white)),
                subtitle: Text('Last Updated : $lastUpdate',
                    style: const TextStyle(color: Colors.white, fontSize: 12)),
              ),
              if (desc != 'null')
                ListTile(
                  title: const Text("Description:",
                      style: TextStyle(color: Colors.white)),
                  subtitle:
                      Text(desc, style: const TextStyle(color: Colors.white)),
                ),
              ListTile(
                title:
                    const Text("Size:", style: TextStyle(color: Colors.white)),
                subtitle: Text('$size Kb',
                    style: const TextStyle(color: Colors.white)),
              ),
              Theme(
                data: Theme.of(context).copyWith(
                  unselectedWidgetColor: Colors.white,
                ),
                child: ExpansionTile(
                  title: Text('Branches (${controller.branchData.length})',
                      style: const TextStyle(color: Colors.white)),
                  children: [
                    ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: controller.branchData.length,
                      itemBuilder: (BuildContext context, int index) {
                        return ListTile(
                          title: Text(
                              controller.branchData[index].name.toString(),
                              style: const TextStyle(color: Colors.white)),
                        );
                      },
                    ),
                  ],
                ),
              )
            ],
          );
        })));
  }
}
