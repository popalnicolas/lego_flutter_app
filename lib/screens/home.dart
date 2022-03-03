import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lego_flutter_app/constants.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.search),
          onPressed: () {

          },
        ),
        actions: [
          IconButton(
            onPressed: (){

            },
            // @TODO: update icon
            icon: Icon(Icons.verified_user_outlined),
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
              )
            ),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(defaultPadding, defaultPadding*1.5, defaultPadding, defaultPadding/2),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Themes", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),),
                      TextButton(
                        onPressed: (){

                        },
                        child: Text("See All"),
                      )
                    ],
                  ),
                  //@TODO: Categories HERE

                  SizedBox(height: defaultPadding,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text("Top Rated", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),),
                    ],
                  ),
                  //@TODO: Top Rated Legos here
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
