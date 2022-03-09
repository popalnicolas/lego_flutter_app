import 'dart:convert';

import 'package:http/http.dart';
import 'package:lego_flutter_app/models/review_model.dart';

class ReviewService
{
  final String url = "http://192.168.87.140:8080/api/lego/review";

  Future<List<ReviewModel>> getReviewsByLegoId(int legoId) async
  {
    try{

      Response response = await get(Uri.parse("$url/$legoId"));
      Iterable responseGet = jsonDecode(response.body);

      print(response.body);

      List<ReviewModel> reviews = List<ReviewModel>.from(responseGet.map((e) => ReviewModel.fromJson(e)));

      return reviews;
    } catch(e) {
      print(e.toString());
      return List.empty();
    }
  }
}