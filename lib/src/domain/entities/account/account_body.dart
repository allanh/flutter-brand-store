// To parse this JSON data, do
//
//     final accountBody = accountBodyFromJson(jsonString);

import 'dart:convert';

AccountBody accountBodyFromJson(String str) => AccountBody.fromJson(json.decode(str));

String accountBodyToJson(AccountBody data) => json.encode(data.toJson());

class AccountBody {
  AccountBody({
    required this.name,
    this.mobileCode,
    this.mobile,
    this.email,
    required this.pwd,
    this.gender,
    this.birth,
    this.zip,
    this.cityNo,
    this.areaNo,
    this.address,
  });

  String name;
  String? mobileCode;
  String? mobile;
  String? email;
  String pwd;
  String? gender;
  DateTime? birth;
  String? zip;
  String? cityNo;
  String? areaNo;
  String? address;

  factory AccountBody.fromJson(Map<String, dynamic> json) => AccountBody(
    name: json["name"],
    mobileCode: json["mobile_code"],
    mobile: json["mobile"],
    email: json["email"],
    pwd: json["pwd"],
    gender: json["gender"],
    birth: DateTime.parse(json["birth"]),
    zip: json["zip"],
    cityNo: json["cityno"],
    areaNo: json["areano"],
    address: json["address"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "mobile_code": mobileCode,
    "mobile": mobile,
    "email": email,
    "pwd": pwd,
    "gender": gender,
    "birth": birth == null ? null : "${birth?.year.toString().padLeft(4, '0')}-${birth?.month.toString().padLeft(2, '0')}-${birth?.day.toString().padLeft(2, '0')}",
    "zip": zip,
    "cityno": cityNo,
    "areano": areaNo,
    "address": address,
  };
}
