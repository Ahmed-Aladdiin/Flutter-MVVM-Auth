import 'package:client/core/models/user_model.dart';

class LogInResponseModel {
  UserModel user;
  String token;

  LogInResponseModel({
    required this.user,
    required this.token,
  });

  factory LogInResponseModel.fromJson(Map<String, dynamic> json) => LogInResponseModel(
        user: UserModel.fromMap(json["user"]),
        token: json["token"],
      );
}
