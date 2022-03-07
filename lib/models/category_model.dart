class CategoryModel{
  final int categoryId;
  final String categoryName;
  final String categoryImage;
  final String categoryColor;

  CategoryModel({required this.categoryId, required this.categoryName, required this.categoryImage, required this.categoryColor});

  static CategoryModel fromJson(json)
  {
    return CategoryModel(
      categoryId: json['categoryId'],
      categoryName: json['categoryName'],
      categoryImage: json['categoryImage'],
      categoryColor: json['categoryColor']
    );
  }

  static Map<String, dynamic> toJson(CategoryModel category) {
    Map<String, dynamic> jsonMap = {
      "categoryId": category.categoryId,
      "categoryName": category.categoryName,
      "categoryImage": category.categoryImage,
      "categoryColor": category.categoryColor
    };

    return jsonMap;
  }
}