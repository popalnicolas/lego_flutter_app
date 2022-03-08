import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lego_flutter_app/hex_color.dart';
import 'package:lego_flutter_app/models/category_model.dart';
import 'package:lego_flutter_app/models/product_model.dart';
import 'package:lego_flutter_app/screens/product.dart';
import 'package:lego_flutter_app/services/webservices/product_service.dart';

import '../constants.dart';

class CategoryScreen extends StatefulWidget {
  const CategoryScreen({Key? key, required this.category}) : super(key: key);

  final CategoryModel category;

  @override
  _CategoryScreenState createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {

  final _productService = ProductService();

  List<ProductModel>? _products;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _productService.getAllLegosByCategory(widget.category.categoryId).then((value) {
      setState(() {
        _products = value;
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
                    color: colorGrey,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(50)
                    )
                ),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(defaultPadding, defaultPadding*2.2, defaultPadding, defaultPadding/2),
                  child: _products == null ? Container() : ListView.builder(
                    shrinkWrap: true,
                    padding: EdgeInsets.zero,
                    itemCount: _products!.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Padding(
                        padding: const EdgeInsets.only(bottom: defaultPadding),
                        child: GestureDetector(
                          onTap: () {
                            Navigator.of(context).push(
                                MaterialPageRoute(builder: (context) =>
                                    ProductScreen(category: widget.category, product: _products![index],))
                            );
                          },
                          child: Container(
                            width: double.infinity,
                            height: MediaQuery.of(context).size.height*0.3,
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
                                      "#${_products![index].legoId}",
                                      style: TextStyle(color: Colors.grey[400]),
                                    ),
                                  ),
                                  Image.network(
                                    _products![index].legoImage, height: MediaQuery.of(context).size.height*0.15,
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
                                          Text(_products![index].legoName,),
                                          Text(widget.category.categoryName, style: TextStyle(color: Colors.grey[400], fontSize: 12))
                                        ],
                                      ),
                                      Text(
                                          _products![index].price%1 == 0 ? "DKK ${_products![index].price.floor()}" : "DKK ${_products![index].price}0",
                                          style: TextStyle(color: Colors.grey[400], fontSize: 12))
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    }
                  )
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
              child: Text(widget.category.categoryName, style: TextStyle(color: Colors.white, fontSize: 40, fontWeight: FontWeight.bold),),
            )
          ),
        ],
      ),
    );
  }
}
