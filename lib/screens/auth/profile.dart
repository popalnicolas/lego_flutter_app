import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:lego_flutter_app/models/user_model.dart';
import 'package:lego_flutter_app/screens/auth/account/about_screen.dart';
import 'package:lego_flutter_app/screens/auth/account/liked_lego.dart';
import 'package:lego_flutter_app/screens/auth/account/personal_profile.dart';

import '../../constants.dart';

class ProfileScreen extends StatefulWidget {
  ProfileScreen({Key? key, this.user, required this.logoutUser}) : super(key: key);

  UserModel? user;
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
            icon: SvgPicture.asset("assets/images/lego-brick.svg", color: Colors.white, height: 20,),
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
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          widget.user == null ? Container() :
                              GestureDetector(
                                child: PersonalProfileBox(userAvatar: widget.user!.avatar,),
                                onTap: () {
                                  Navigator.of(context).push(MaterialPageRoute(builder: (context) => PersonalProfileScreen(user: widget.user!,))).then((value) {
                                    setState(() {
                                      widget.user = value;
                                    });
                                  });
                                },
                              ),
                          GestureDetector(
                            child: ProfileBox(title: "Liked Lego", image: "assets/images/legoheart.png"),
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(builder: (context) => LikedLegoScreen()));
                            },
                          )
                        ],
                      ),
                      SizedBox(height: defaultPadding,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          GestureDetector(
                            child: ProfileBox(title: "About Lego", image: "assets/images/lego.png"),
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(builder: (context) => AboutScreen()));
                            },
                          ),
                          GestureDetector(
                            onTap: () {
                              widget.logoutUser();
                            },
                            child: ProfileBox(title: "Logout", image: "assets/images/legodoor.png"),
                          ),
                        ],
                      ),
                      SizedBox(height: defaultPadding,),
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
                  child: widget.user == null ? Container() : CircleAvatar(
                    backgroundColor: Colors.white,
                    radius: MediaQuery.of(context).size.height*0.1,
                    backgroundImage: NetworkImage(widget.user!.avatar),
                  ),
                ),
              )
          ),
        ],
      ),
    );
  }
}

class PersonalProfileBox extends StatefulWidget {
  const PersonalProfileBox({Key? key, this.userAvatar}) : super(key: key);

  final String? userAvatar;

  @override
  _PersonalProfileBoxState createState() => _PersonalProfileBoxState();
}

class _PersonalProfileBoxState extends State<PersonalProfileBox> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width/2 - defaultPadding*1.5,
      height: MediaQuery.of(context).size.width/2 - defaultPadding*2.5,
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 5,
            blurRadius: 7,
          )
        ],
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      child: Padding(
        padding: const EdgeInsets.all(defaultPadding),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            widget.userAvatar == null ? Container()
                :
            CircleAvatar(
              backgroundColor: Colors.white,
              radius: MediaQuery.of(context).size.width*0.1,
              backgroundImage: NetworkImage(widget.userAvatar!),
            ),
            SizedBox(height: defaultPadding/3,),
            Text("Change Avatar", style: TextStyle(fontWeight: FontWeight.bold),)
          ],
        ),
      ),
    );
  }
}

class ProfileBox extends StatefulWidget {
  const ProfileBox({Key? key, required this.title, required this.image}) : super(key: key);

  final String title;
  final String image;

  @override
  _ProfileBoxState createState() => _ProfileBoxState();
}

class _ProfileBoxState extends State<ProfileBox> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width/2 - defaultPadding*1.5,
      height: MediaQuery.of(context).size.width/2 - defaultPadding*2.5,
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 5,
            blurRadius: 7,
          )
        ],
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      child: Padding(
        padding: const EdgeInsets.all(defaultPadding),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Image.asset(widget.image, width: MediaQuery.of(context).size.width*0.2,),
            SizedBox(height: defaultPadding/3,),
            Text(widget.title, style: TextStyle(fontWeight: FontWeight.bold),)
          ],
        ),
      ),
    );
  }
}

