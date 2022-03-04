import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:lego_flutter_app/models/user_model.dart';

class UserLocalStorageService
{
  final _storage = new FlutterSecureStorage();

  Future<bool> isLoggedIn() async
  {
    return await _storage.read(key: "login_details") != null;
  }

  Future<UserModel> getUser() async
  {
    String? userData = await _storage.read(key: "login_details");

    return UserModel.fromJson(jsonDecode(userData!));
  }

  Future saveUser(UserModel user) async
  {
    await _storage.write(key: "login_details", value: jsonEncode(UserModel.toJson(user)));
  }

  Future removeUser() async
  {
    await _storage.delete(key: "login_details");
  }
}