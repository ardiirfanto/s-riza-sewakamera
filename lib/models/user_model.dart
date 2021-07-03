import 'dart:convert';

User userFromJson(String str) => User.fromJson(json.decode(str));

String userToJson(User data) => json.encode(data.toJson());

class User {
  User({
    this.userId,
    this.custId,
    this.username,
    this.roles,
    this.custName,
    this.custAddress,
    this.custPhone,
  });

  int userId;
  int custId = 0;
  String username;
  String roles;
  String custName = "";
  String custAddress = "";
  String custPhone = "";

  factory User.fromJson(Map<String, dynamic> json) => User(
        userId: json["user_id"] ?? json["id"],
        custId: json["cust_id"] ?? 0,
        username: json["username"],
        roles: json["roles"],
        custName: json["cust_name"] ?? "",
        custAddress: json["cust_address"] ?? "",
        custPhone: json["cust_phone"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "user_id": userId,
        "cust_id": custId ?? 0,
        "username": username,
        "roles": roles,
        "cust_name": custName ?? "",
        "cust_address": custAddress ?? "",
        "cust_phone": custPhone ?? "",
      };
}
