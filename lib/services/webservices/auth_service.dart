import 'dart:convert';

import 'package:http/http.dart';
import 'package:lego_flutter_app/models/user_model.dart';

class AuthService
{
  final String url = "http://192.168.87.140:8080/api/auth";

  Future<UserModel?> loginUser(String username, String password) async {
    Map<String, dynamic> jsonMap =
    {
      "username":username,
      "password":password
    };

    try {
      Response responsePost = await post(
        Uri.parse("$url/login"), body: jsonMap,
      );
      Map tokens = jsonDecode(responsePost.body);

      print(responsePost.body);

      Response responseGet = await get(Uri.parse("$url/getUser"), headers: {
        "Authorization": "Bearer ${tokens['access_token']}"
      });

      print(responseGet.body);

      Map userDetails = jsonDecode(responseGet.body);
      UserModel user = UserModel(
          userId: userDetails['userId'],
          userEmail: userDetails['userEmail'],
          access_token: tokens['access_token'],
          avatar: userDetails['avatar']['avatarImage']
      );
      return user;
    } catch(e) {
      print(e.toString());
      return null;
    }
  }

  Future<bool> registerUser(String userEmail, String password) async {

    Map<String, dynamic> jsonMap = {
      "userEmail": userEmail,
      "userPassword": password,
    };

    try{
      Response response = await post(
          Uri.parse("$url/register"),
          headers: {"Content-Type": "application/json"},
          body: json.encode(jsonMap)
      );

      if(response.statusCode == 200)
        return true;
      else
        return false;
    } catch(e) {
      print(e.toString());
      return false;
    }
  }
  
  Future changeAvatar(String header, int avatarId) async
  {
    try{
      await put(
        Uri.parse("$url/avatar?avatarId=$avatarId"),
        headers: {"Content-Type": "application/json", "Authorization": "Bearer $header"},
      );
    } catch(e) {
      print(e.toString());
    }
  }
}