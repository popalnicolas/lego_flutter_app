import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:lego_flutter_app/models/category_model.dart';
import 'package:lego_flutter_app/models/product_model.dart';
import 'package:lego_flutter_app/models/review_model.dart';
import 'package:lego_flutter_app/services/local_storage/localstorage_user_service.dart';

import '../constants.dart';
import '../hex_color.dart';

class ReviewsScreen extends StatefulWidget {
  const ReviewsScreen({Key? key, required this.reviews, required this.product, required this.category}) : super(key: key);

  final List<ReviewModel> reviews;
  final ProductModel product;
  final CategoryModel category;

  @override
  _ReviewsScreenState createState() => _ReviewsScreenState();
}

class _ReviewsScreenState extends State<ReviewsScreen> {

  final _authLocalStorage = UserLocalStorageService();

  String _reviewText = "";
  bool _isLogged = true;
  String _errorMsg = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: HexColor.fromHex(widget.category.categoryColor).withOpacity(0.5),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: Icon(Icons.arrow_back_ios),
        ),
      ),
      body: Stack(
        children: [
          Container(
            width: double.infinity,
            height: double.infinity,
            decoration: BoxDecoration(
              image: DecorationImage(
                alignment: Alignment.topCenter,
                image: NetworkImage(widget.category.categoryImage,),
                fit: BoxFit.fitWidth,
                colorFilter: ColorFilter.mode(Colors.black.withOpacity(0.5), BlendMode.darken),
              ),
            ),
            child: Padding(
              padding: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.24),
              child: Container(
                width: double.infinity,
                height: double.infinity,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(50)
                    )
                ),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(defaultPadding, defaultPadding*2, defaultPadding, defaultPadding/2),
                  child: Column(
                    children: [
                      SizedBox(
                        height: MediaQuery.of(context).size.height*0.2,
                        child: Column(
                          children: [
                            TextField(
                              decoration: InputDecoration(
                                  border: OutlineInputBorder(),
                              ),
                              keyboardType: TextInputType.multiline,
                              maxLines: 2,
                              onChanged: (text) {
                                setState(() {
                                  _reviewText = text;
                                });
                              },
                            ),
                            _isLogged ? Container() : Text(_errorMsg, style: TextStyle(color: colorLegoRed),),
                            ElevatedButton(
                              onPressed: () async {
                                if(await _authLocalStorage.isLoggedIn()) {
                                  print(_reviewText);
                                }
                                else{
                                  setState(() {
                                    _isLogged = false;
                                    _errorMsg = "You must be logged in.";
                                  });
                                }
                              },
                              child: Text("Add review"),
                            ),
                          ],
                        ),
                      ),
                      Flexible(
                        child: SizedBox(
                          height: MediaQuery.of(context).size.height*0.55,
                          child: ListView.builder(
                            shrinkWrap: true,
                            padding: EdgeInsets.zero,
                            itemCount: widget.reviews.length,
                            itemBuilder: (BuildContext context, int index) {
                              return Column(
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(widget.reviews[index].userEmail, style: TextStyle(color: Colors.grey[400]),),
                                      Row(
                                        children: [
                                          SvgPicture.asset("assets/images/lego-brick.svg", color: widget.reviews[index].rating >= 1 ? colorLegoYellow : colorGrey,height: 15,),
                                          SizedBox(width: defaultPadding/6,),
                                          SvgPicture.asset("assets/images/lego-brick.svg", color: widget.reviews[index].rating >= 2 ? colorLegoYellow : colorGrey,height: 15,),
                                          SizedBox(width: defaultPadding/6,),
                                          SvgPicture.asset("assets/images/lego-brick.svg", color: widget.reviews[index].rating >= 3 ? colorLegoYellow : colorGrey,height: 15,),
                                          SizedBox(width: defaultPadding/6,),
                                          SvgPicture.asset("assets/images/lego-brick.svg", color: widget.reviews[index].rating >= 4 ? colorLegoYellow : colorGrey,height: 15,),
                                          SizedBox(width: defaultPadding/6,),
                                          SvgPicture.asset("assets/images/lego-brick.svg", color: widget.reviews[index].rating >= 5 ? colorLegoYellow : colorGrey,height: 15,),
                                        ],
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: defaultPadding,),
                                  Text(widget.reviews[index].comment),
                                  SizedBox(height: defaultPadding/1.5,),
                                  Divider(color: Colors.grey[400],)
                                ],
                              );
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          Align(
              alignment: Alignment.topCenter,
              child: Padding(
                padding: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height*0.1,
                ),
                child: Text(widget.product.legoName, style: TextStyle(color: Colors.white, fontSize: 28, fontWeight: FontWeight.bold),),
              )
          ),
        ],
      ),
    );
  }
}