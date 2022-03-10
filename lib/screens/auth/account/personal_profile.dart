import 'package:flutter/material.dart';
import 'package:lego_flutter_app/models/avatar_model.dart';
import 'package:lego_flutter_app/models/user_model.dart';
import 'package:lego_flutter_app/services/local_storage/localstorage_user_service.dart';
import 'package:lego_flutter_app/services/webservices/auth_service.dart';
import 'package:lego_flutter_app/services/webservices/avatar_service.dart';

import '../../../constants.dart';

class PersonalProfileScreen extends StatefulWidget {
  const PersonalProfileScreen({Key? key, required this.user}) : super(key: key);

  final UserModel user;

  @override
  _PersonalProfileScreenState createState() => _PersonalProfileScreenState();
}

class _PersonalProfileScreenState extends State<PersonalProfileScreen> {

  final _avatarService = AvatarService();
  final _authService = AuthService();
  final _userLocalStorageService = UserLocalStorageService();

  List<AvatarModel> _avatars = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _avatarService.getAvatars().then((value) {
      setState(() {
        _avatars = value;
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
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop(widget.user);
          },
          icon: Icon(Icons.arrow_back_ios),
        ),
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage("assets/images/lego-heads.jpg"),
                fit: BoxFit.cover,
                colorFilter: ColorFilter.mode(Colors.black.withOpacity(0.5), BlendMode.darken)
            )
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
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(defaultPadding, defaultPadding*1.5, defaultPadding, defaultPadding/2),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Choose new avatar: ", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),),
                  SizedBox(height: defaultPadding,),
                  _avatars.isEmpty ? Container() :
                  SizedBox(
                    height: MediaQuery.of(context).size.height*0.59,
                    child: GridView.builder(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
                      itemCount: _avatars.length,
                      padding: EdgeInsets.zero,
                      itemBuilder: (BuildContext context, int index) {
                        return Padding(
                          padding: const EdgeInsets.all(defaultPadding/3),
                          child: GestureDetector(
                            onTap: () async {
                              await _authService.changeAvatar(widget.user.access_token, _avatars[index].avatarId);

                              UserModel newUser = UserModel(
                                  userId: widget.user.userId,
                                  userEmail: widget.user.userEmail,
                                  access_token: widget.user.access_token,
                                  avatar: _avatars[index].avatarImage
                              );

                              _userLocalStorageService.saveUser(newUser);

                              Navigator.of(context).pop(newUser);
                            },
                            child: Container(
                              color: Colors.white,
                              width: MediaQuery.of(context).size.width*0.5,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  CircleAvatar(
                                    backgroundColor: Colors.white,
                                    radius: MediaQuery.of(context).size.height*0.06,
                                    backgroundImage: NetworkImage(_avatars[index].avatarImage),
                                  ),
                                  SizedBox(height: defaultPadding/2,),
                                  Text(_avatars[index].avatarName, style: TextStyle(fontWeight: FontWeight.bold),)
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
