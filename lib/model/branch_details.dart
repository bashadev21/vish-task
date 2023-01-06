// To parse this JSON data, do
//
//     final branchModel = branchModelFromJson(jsonString);

import 'dart:convert';

List<BranchModel> branchModelFromJson(String str) => List<BranchModel>.from(
    json.decode(str).map((x) => BranchModel.fromJson(x)));

String branchModelToJson(List<BranchModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class BranchModel {
  BranchModel({
    required this.name,
    required this.commit,
    required this.protected,
  });

  String name;
  Commit commit;
  bool protected;

  factory BranchModel.fromJson(Map<String, dynamic> json) => BranchModel(
        name: json["name"],
        commit: Commit.fromJson(json["commit"]),
        protected: json["protected"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "commit": commit.toJson(),
        "protected": protected,
      };
}

class Commit {
  Commit({
    required this.sha,
    required this.url,
  });

  String sha;
  String url;

  factory Commit.fromJson(Map<String, dynamic> json) => Commit(
        sha: json["sha"],
        url: json["url"],
      );

  Map<String, dynamic> toJson() => {
        "sha": sha,
        "url": url,
      };
}
