import 'dart:convert';

import 'package:http/http.dart';
import 'package:lego_flutter_app/models/product_model.dart';

class ProductService{
  final String url = "http://192.168.87.140:8080/api/lego";

  Future<List<ProductModel>?> getAllLegosByCategory(int categoryId) async
  {
    try{

      Response response = await get(Uri.parse("$url?categoryId=$categoryId"));
      Iterable responseGet = jsonDecode(response.body);

      print(response.body);

      List<ProductModel> products = List<ProductModel>.from(responseGet.map((e) => ProductModel.fromJson(e)));

      return products;
    } catch(e) {
      print(e.toString());
      return null;
    }
  }

  Future<ProductModel?> getLegoById(int legoId) async
  {
    try{
      Response response = await get(Uri.parse("$url/$legoId"));

      return ProductModel.fromJson(response.body);
    } catch(e) {
      print(e.toString());
      return null;
    }
  }
}