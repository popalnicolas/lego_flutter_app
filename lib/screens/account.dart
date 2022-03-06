import 'package:flutter/material.dart';
import 'package:lego_flutter_app/models/user_model.dart';
import 'package:lego_flutter_app/screens/auth/profile.dart';
import 'package:lego_flutter_app/services/local_storage/localstorage_user_service.dart';

import 'auth/login.dart';
import 'auth/register.dart';

class AccountScreen extends StatefulWidget {
  const AccountScreen({Key? key}) : super(key: key);

  @override
  _AccountScreenState createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {

  final _storage = UserLocalStorageService();

  bool userLoggedIn = false;
  bool register = false;
  UserModel? user;

  void registerPage()
  {
    setState(() {
      register = !register;
    });
  }

  void loginUser(UserModel? user)
  {
    setState(() {
      this.user = user;
      userLoggedIn = true;
    });
  }

  void logoutUser()
  {
    setState(() {
      userLoggedIn = false;
      user = null;
      _storage.removeUser();
    });
  }

  @override
  void initState() {
    super.initState();

    _storage.isLoggedIn().then((value) {
      setState(() {
        userLoggedIn = value;
      });
      if(value) {
        _storage.getUser().then((value) {
          setState(() {
            user = value;
          });
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    if(userLoggedIn){
      return ProfileScreen(user: user, logoutUser: logoutUser,);
    }else{
      if(register){
        return RegisterScreen(register: registerPage);
      }else{
        return LoginScreen(loginUser: loginUser, register: registerPage,);
      }
    }
  }
}
