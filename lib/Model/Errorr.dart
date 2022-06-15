// To parse this JSON data, do
//
//     final errorMsg = errorMsgFromJson(jsonString);

import 'dart:convert';

ErrorMsg errorMsgFromJson(String str) => ErrorMsg.fromJson(json.decode(str));

String errorMsgToJson(ErrorMsg data) => json.encode(data.toJson());

class ErrorMsg {
  ErrorMsg({
    this.message,
    this.errors,
  });

  String? message;
  Errors? errors;

  factory ErrorMsg.fromJson(Map<String, dynamic> json) => ErrorMsg(
    message: json["message"],
    errors: Errors.fromJson(json["errors"]),
  );

  Map<String, dynamic> toJson() => {
    "message": message,
    "errors": errors?.toJson(),
  };
}

class Errors {
  Errors({
    required this.mobile,
  });

  List<String> mobile;

  factory Errors.fromJson(Map<String, dynamic> json) => Errors(
    mobile: List<String>.from(json["mobile"].map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "mobile": List<dynamic>.from(mobile.map((x) => x)),
  };
}
