import 'package:flutter/material.dart';
import 'package:lego_flutter_app/models/user_model.dart';

import '../../constants.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key, this.user, required this.logoutUser}) : super(key: key);

  final UserModel? user;
  final Function() logoutUser;

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          IconButton(
            onPressed: (){
              Navigator.pushNamedAndRemoveUntil(context, "/home", (route) => false);
            },
            // @TODO: update icon - use lego brick
            icon: Icon(Icons.backpack),
          )
        ],
      ),
      body: Stack(
        children: [
          Container(
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
                  padding: const EdgeInsets.fromLTRB(defaultPadding, defaultPadding*2.2, defaultPadding, defaultPadding/2),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      //@TODO: Tabs here
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
                  top: MediaQuery.of(context).size.height*0.14,
                ),
                child: Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    boxShadow: [BoxShadow(blurRadius: 10, color: Colors.black, spreadRadius: 5)],
                  ),
                  child: CircleAvatar(
                    radius: MediaQuery.of(context).size.height*0.1,
                    backgroundImage: NetworkImage("https://i.pinimg.com/736x/f8/1b/f0/f81bf032d0a33a7d4a79214c5edc4816.jpg"),
                  ),
                ),
              )
          ),
        ],
      ),
    );
  }
}
