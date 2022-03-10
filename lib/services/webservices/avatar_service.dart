import 'dart:convert';

import 'package:http/http.dart';
import 'package:lego_flutter_app/models/avatar_model.dart';

class AvatarService
{
  final String url = "http://192.168.87.140:8080/api/lego/avatar";

  Future<List<AvatarModel>> getAvatars() async
  {
    try{
      Response response = await get(Uri.parse(url));

      Iterable responseGet = jsonDecode(response.body);

      List<AvatarModel> avatars = List<AvatarModel>.from(responseGet.map((e) => AvatarModel.fromJson(e)));

      return avatars;
    } catch(e) {
      print(e.toString());
      return List.empty();
    }
  }
}