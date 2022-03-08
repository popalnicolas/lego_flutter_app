import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:lego_flutter_app/models/product_model.dart';

class LikedLegoLocalStorageService
{
  final _storage = new FlutterSecureStorage();

  Future<List<ProductModel>?> getLikedLegos() async
  {
    String? likedLegos = await _storage.read(key: "liked_products");

    if(likedLegos == null)
      return null;

    Iterable getResponse = jsonDecode(likedLegos);
    List<ProductModel> legos = List<ProductModel>.from(getResponse.map((e) => ProductModel.fromJson(e)));

    return legos;
  }

  Future<bool> isPhotoLiked(ProductModel lego) async
  {
    var likedLegos = await getLikedLegos();

    if(likedLegos == null)
      return false;

    for(ProductModel legoModel in likedLegos){
      if(legoModel.legoId == lego.legoId)
        return true;
    }

    return false;
  }

  Future likePhoto(ProductModel lego) async{
    var likedLegos = await getLikedLegos();

    List<Map> newList = [];

    if(likedLegos == null){
      newList.add(ProductModel.toJson(lego));
    }
    else{
      likedLegos.add(lego);
      for(ProductModel legos in likedLegos){
        newList.add(ProductModel.toJson(legos));
      }
    }
    _storage.write(key: "liked_products", value: jsonEncode(newList));
  }

  Future dislikePhoto(ProductModel lego) async{
    var likedLegos = await getLikedLegos();

    List<Map> newList = [];
    likedLegos!.removeWhere((element) => element.legoId == lego.legoId);
    for(ProductModel legos in likedLegos){
      newList.add(ProductModel.toJson(legos));
    }
    _storage.write(key: "liked_products", value: jsonEncode(newList));
  }
}