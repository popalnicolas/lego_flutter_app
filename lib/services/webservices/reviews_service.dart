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

  Future leaveReview(int legoId, int rating, String comment, String header) async
  {
    try{
      Map<String, dynamic> map = {
        "rating": rating,
        "comment": comment,
        "lego": {
          "legoId": legoId
        }
      };

      Response response = await post(Uri.parse(url),
          headers: {
            "Content-Type": "application/json",
            "Authorization": "Bearer $header"
          },
          body: jsonEncode(map)
      );
    } catch(e) {
      print(e.toString());
    }
  }
}