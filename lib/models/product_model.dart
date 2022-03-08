import 'package:lego_flutter_app/models/category_model.dart';

class ProductModel{
  final int legoId;
  final String legoName;
  final int age;
  final String legoImage;
  final String legoManual;
  final double price;

  ProductModel({
    required this.legoId,
    required this.legoName,
    required this.age,
    required this.legoImage,
    required this.legoManual,
    required this.price,
  });

  static ProductModel fromJson(json)
  {
    return ProductModel(
      legoId: json['legoId'],
      legoName: json['legoName'],
      age: json['age'],
      legoImage: json['legoImage'],
      legoManual: json['legoManual'],
      price: json['price']
    );
  }

  static Map<String, dynamic> toJson(ProductModel product) {
    Map<String, dynamic> jsonMap = {
      "legoId": product.legoId,
      "legoName": product.legoName,
      "age": product.age,
      "legoImage": product.legoImage,
      "legoManual": product.legoManual,
      "price": product.price
    };

    return jsonMap;
  }
}