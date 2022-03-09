import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lego_flutter_app/hex_color.dart';
import 'package:lego_flutter_app/models/category_model.dart';
import 'package:lego_flutter_app/models/product_model.dart';
import 'package:lego_flutter_app/models/review_model.dart';
import 'package:lego_flutter_app/screens/reviews.dart';
import 'package:lego_flutter_app/services/local_storage/localstorage_likedlego_service.dart';
import 'package:lego_flutter_app/services/webservices/reviews_service.dart';
import 'package:url_launcher/url_launcher.dart';

import '../constants.dart';

class ProductScreen extends StatefulWidget {
  const ProductScreen({Key? key, required this.category, required this.product}) : super(key: key);

  final CategoryModel category;
  final ProductModel product;

  @override
  _ProductScreenState createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {

  final _reviewsService = ReviewService();
  final _likedLegoService = LikedLegoLocalStorageService();

  List<ReviewModel> _reviews = [];
  double _rating = 0;

  bool _isLegoLiked = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _reviewsService.getReviewsByLegoId(widget.product.legoId).then((value) {
      setState(() {
        _reviews = value;
      });
      for(ReviewModel reviewModel in _reviews){
        _rating += reviewModel.rating;
      }
      _rating = _rating/_reviews.length;

      print(_rating);
    });

    _likedLegoService.isPhotoLiked(widget.product).then((value) {
      setState(() {
        _isLegoLiked = value;
      });
    });
  }

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
                  padding: const EdgeInsets.fromLTRB(defaultPadding, defaultPadding, defaultPadding, defaultPadding/2),
                  child: Column(
                    children: [
                      Align(
                        alignment: Alignment.topRight,
                        child: IconButton(
                          onPressed: () async {
                            if(!_isLegoLiked)
                              _likedLegoService.likePhoto(widget.product);
                            else
                              _likedLegoService.dislikePhoto(widget.product);
                            setState(() {
                              _isLegoLiked = !_isLegoLiked;
                            });
                          },
                          icon: Icon(Icons.favorite, color: _isLegoLiked ? colorLegoRed : colorGrey,),
                        ),
                      ),
                      Image.network(widget.product.legoImage,
                        height: MediaQuery.of(context).size.height*0.4,
                        loadingBuilder: (BuildContext context, Widget child,
                          ImageChunkEvent? loadingProgress) {
                        if (loadingProgress == null) return child;
                        return Center(
                          child: CircularProgressIndicator(
                            value: loadingProgress.expectedTotalBytes != null
                                ? loadingProgress.cumulativeBytesLoaded /
                                loadingProgress.expectedTotalBytes!
                                : null,
                          ),
                        );
                      },),
                      SizedBox(height: defaultPadding,),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              children: [
                                Icon(Icons.tag, color: Colors.grey[400],),
                                SizedBox(height: defaultPadding/10,),
                                Text("${widget.product.legoId}", style: TextStyle(color: Colors.grey[400]))
                              ],
                            ),
                            Container(height: 30, child: VerticalDivider(color: Colors.grey[400])),
                            Column(
                              children: [
                                Icon(Icons.cake, color: Colors.grey[400],),
                                SizedBox(height: defaultPadding/10,),
                                Text("${widget.product.age}+", style: TextStyle(color: Colors.grey[400]))
                              ],
                            ),
                            Container(height: 30, child: VerticalDivider(color: Colors.grey[400])),
                            Column(
                              children: [
                                SvgPicture.asset("assets/images/lego-brick.svg", color: Colors.grey[400], height: 20,),
                                SizedBox(height: defaultPadding/10,),
                                Text(
                                  "${widget.product.pieces}"
                                  , style: TextStyle(color: Colors.grey[400]),)
                              ],
                            ),
                            Container(height: 30, child: VerticalDivider(color: Colors.grey[400])),
                            Column(
                              children: [
                                Icon(Icons.monetization_on_outlined, color: Colors.grey[400],),
                                SizedBox(height: defaultPadding/10,),
                                Text(
                                    widget.product.price%1 == 0 ? "DKK ${widget.product.price.floor()}" : "DKK ${widget.product.price}0"
                                  , style: TextStyle(color: Colors.grey[400]),)
                              ],
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: defaultPadding,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Column(
                            children: [
                              Row(
                                children: [
                                  SvgPicture.asset("assets/images/lego-brick.svg", color: _rating >= 1 ? colorLegoYellow : colorGrey,height: 20,),
                                  SizedBox(width: defaultPadding/6,),
                                  SvgPicture.asset("assets/images/lego-brick.svg", color: _rating >= 2 ? colorLegoYellow : colorGrey,height: 20,),
                                  SizedBox(width: defaultPadding/6,),
                                  SvgPicture.asset("assets/images/lego-brick.svg", color: _rating >= 3 ? colorLegoYellow : colorGrey,height: 20,),
                                  SizedBox(width: defaultPadding/6,),
                                  SvgPicture.asset("assets/images/lego-brick.svg", color: _rating >= 4 ? colorLegoYellow : colorGrey,height: 20,),
                                  SizedBox(width: defaultPadding/6,),
                                  SvgPicture.asset("assets/images/lego-brick.svg", color: _rating >= 5 ? colorLegoYellow : colorGrey,height: 20,),
                                ],
                              ),
                              TextButton(
                                onPressed: (){
                                  Navigator.of(context).push(
                                      MaterialPageRoute(builder: (context) =>
                                          ReviewsScreen(reviews: _reviews, product: widget.product, category: widget.category))
                                  );
                                },
                                child: Text("See all reviews"),
                              )
                            ],
                          ),
                          TextButton(
                            onPressed: () async {
                              if (await canLaunch(widget.product.legoManual)) {
                                await launch(widget.product.legoManual);
                              } else {
                                throw 'Could not launch ${widget.product.legoManual}';
                              }
                            },
                            child: Text("Download manual"),
                          ),
                        ],
                      )
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
