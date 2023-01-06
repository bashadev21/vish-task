// To parse this JSON data, do
//
//     final orgsModel = orgsModelFromJson(jsonString);

import 'dart:convert';

List<OrgsModel> orgsModelFromJson(String str) =>
    List<OrgsModel>.from(json.decode(str).map((x) => OrgsModel.fromJson(x)));

String orgsModelToJson(List<OrgsModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class OrgsModel {
  OrgsModel({
    required this.login,
    required this.id,
    required this.nodeId,
    required this.url,
    required this.reposUrl,
    required this.eventsUrl,
    required this.hooksUrl,
    required this.issuesUrl,
    required this.membersUrl,
    required this.publicMembersUrl,
    required this.avatarUrl,
    required this.description,
  });

  String login;
  int id;
  String nodeId;
  String url;
  String reposUrl;
  String eventsUrl;
  String hooksUrl;
  String issuesUrl;
  String membersUrl;
  String publicMembersUrl;
  String avatarUrl;
  String description;

  factory OrgsModel.fromJson(Map<String, dynamic> json) => OrgsModel(
        login: json["login"],
        id: json["id"],
        nodeId: json["node_id"],
        url: json["url"],
        reposUrl: json["repos_url"],
        eventsUrl: json["events_url"],
        hooksUrl: json["hooks_url"],
        issuesUrl: json["issues_url"],
        membersUrl: json["members_url"],
        publicMembersUrl: json["public_members_url"],
        avatarUrl: json["avatar_url"],
        description: json["description"],
      );

  Map<String, dynamic> toJson() => {
        "login": login,
        "id": id,
        "node_id": nodeId,
        "url": url,
        "repos_url": reposUrl,
        "events_url": eventsUrl,
        "hooks_url": hooksUrl,
        "issues_url": issuesUrl,
        "members_url": membersUrl,
        "public_members_url": publicMembersUrl,
        "avatar_url": avatarUrl,
        "description": description,
      };
}
