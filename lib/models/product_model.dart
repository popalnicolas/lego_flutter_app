import 'package:lego_flutter_app/models/category_model.dart';

class ProductModel{
  final int legoId;
  final String legoName;
  final int age;
  final int pieces;
  final String legoImage;
  final String legoManual;
  final double price;
  final CategoryModel? category;

  ProductModel({
    required this.legoId,
    required this.legoName,
    required this.age,
    required this.pieces,
    required this.legoImage,
    required this.legoManual,
    required this.price,
    this.category
  });

  static ProductModel fromJson(json)
  {
    return ProductModel(
      legoId: json['legoId'],
      legoName: json['legoName'],
      age: json['age'],
      pieces: json['pieces'],
      legoImage: json['legoImage'],
      legoManual: json['legoManual'],
      price: json['price'],
      category: CategoryModel.fromJson(json['category'])
    );
  }

  static Map<String, dynamic> toJson(ProductModel product) {
    Map<String, dynamic> jsonMap = {
      "legoId": product.legoId,
      "legoName": product.legoName,
      "age": product.age,
      "pieces": product.pieces,
      "legoImage": product.legoImage,
      "legoManual": product.legoManual,
      "price": product.price,
      "category": CategoryModel.toJson(product.category!)
    };

    return jsonMap;
  }
}