import 'dart:convert';

import 'package:http/http.dart';
import 'package:lego_flutter_app/models/category_model.dart';

class CategoryService{

  final String url = "http://192.168.87.140:8080/api/lego/category";

  Future<List<CategoryModel>?> getAllCategories() async
  {
    try{

      Response response = await get(Uri.parse(url));
      Iterable responseGet = jsonDecode(response.body);
      List<CategoryModel> categories = List<CategoryModel>.from(responseGet.map((e) => CategoryModel.fromJson(e)));

      return categories;
    } catch(e) {
      print(e.toString());
      return null;
    }
  }
}