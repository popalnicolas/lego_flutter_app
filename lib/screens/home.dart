import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:lego_flutter_app/constants.dart';
import 'package:lego_flutter_app/models/category_model.dart';
import 'package:lego_flutter_app/models/product_model.dart';
import 'package:lego_flutter_app/screens/category.dart';
import 'package:lego_flutter_app/screens/product.dart';
import 'package:lego_flutter_app/services/webservices/category_service.dart';
import 'package:lego_flutter_app/services/webservices/product_service.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  final _categoryService = CategoryService();
  final _productService = ProductService();

  List<CategoryModel>? _categories;
  List<ProductModel> _products = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _categoryService.getAllCategories().then((value) {
      setState(() {
        _categories = value;
      });
    });

    _productService.getNewestLego().then((value) {
      setState(() {
        _products = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          IconButton(
            onPressed: (){
              Navigator.pushNamedAndRemoveUntil(context, "/account", (route) => false);
            },
            // @TODO: update icon - use lego head
            icon: SvgPicture.asset("assets/images/lego-head.svg", color: Colors.white, height: 30,),
          )
        ],
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/bg.jpg"),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(Colors.black.withOpacity(0.5), BlendMode.darken)
          )
        ),
        child: Padding(
          padding: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.3),
          child: Container(
            width: double.infinity,
            height: double.infinity,
            decoration: BoxDecoration(
              color: colorGrey,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(50)
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(defaultPadding, defaultPadding*1.5, defaultPadding, defaultPadding/2),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Themes", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),),
                  SizedBox(height: defaultPadding/2,),
                  _categories == null ? Container() :
                  SizedBox(
                    height: MediaQuery.of(context).size.height*0.2,
                    child: ListView.builder(
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      itemCount: _categories!.length,
                      itemBuilder: (BuildContext context, int index) {
                        return GestureDetector(
                          onTap: () {
                            Navigator.of(context).push(
                                MaterialPageRoute(builder: (context) =>
                                    CategoryScreen(category: _categories![index]))
                            );
                          },
                          child: Padding(
                            padding: const EdgeInsets.only(right: 10),
                            child: Container(
                              height: 100,
                              width: 200,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.all(
                                    Radius.circular(5),
                                ),
                                image: DecorationImage(
                                  image: NetworkImage(_categories![index].categoryImage),
                                  fit: BoxFit.cover,
                                  colorFilter: ColorFilter.mode(Colors.black.withOpacity(0.5), BlendMode.darken),
                                ),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.only(top: defaultPadding/2),
                                child: Align(
                                  alignment: Alignment.topCenter,
                                  child: Text(
                                    _categories![index].categoryName,
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  SizedBox(height: defaultPadding,),
                  Text("Newest", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),),
                  SizedBox(height: defaultPadding/2,),
                  SizedBox(
                    height: MediaQuery.of(context).size.height*0.3,
                    child: ListView.builder(
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      itemCount: _products.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Padding(
                          padding: const EdgeInsets.only(right: defaultPadding),
                          child: GestureDetector(
                            onTap: () {
                              Navigator.of(context).push(
                                  MaterialPageRoute(builder: (context) =>
                                      ProductScreen(category: _products[index].category!, product: _products[index],))
                              );
                            },
                            child: Container(
                              width: MediaQuery.of(context).size.width*0.6,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.all(
                                      Radius.circular(10)
                                  )
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(defaultPadding),
                                child: Column(
                                  children: [
                                    Align(
                                      alignment: Alignment.topLeft,
                                      child: Text(
                                        "#${_products[index].legoId}",
                                        style: TextStyle(color: Colors.grey[400]),
                                      ),
                                    ),
                                    Image.network(
                                      _products[index].legoImage, height: MediaQuery.of(context).size.height*0.15,
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
                                      },
                                    ),
                                    SizedBox(height: defaultPadding,),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(_products[index].legoName,),
                                            Text(_products[index].category!.categoryName, style: TextStyle(color: Colors.grey[400], fontSize: 12))
                                          ],
                                        ),
                                        Text(
                                            _products[index].price%1 == 0 ? "DKK ${_products[index].price.floor()}" : "DKK ${_products[index].price}0",
                                            style: TextStyle(color: Colors.grey[400], fontSize: 12))
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
