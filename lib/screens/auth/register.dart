import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:lego_flutter_app/services/webservices/auth_service.dart';

import '../../constants.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key, required this.register}) : super(key: key);

  final Function() register;

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {

  final _authService = AuthService();

  final _formKey = GlobalKey<FormState>();

  bool _error = false;
  String _userEmail = "", _password = "", _password2 = "", _errorMessage = "";

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
                  child: Form(
                    key: _formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        TextFormField(
                          validator: MultiValidator(
                              [
                                RequiredValidator(errorText: "Email address is required"),
                                EmailValidator(errorText: "Email is in wrong format")
                              ]
                          ),
                          obscureText: false,
                          onChanged: (userEmail) {
                            setState(() {
                              _userEmail = userEmail;
                            });
                          },
                          decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: "Email Address"
                          ),
                        ),
                        SizedBox(height: defaultPadding,),
                        TextFormField(
                          validator: MultiValidator(
                              [
                                RequiredValidator(errorText: "Password field is required"),
                                MinLengthValidator(5, errorText: "Password must have at least 5 characters")
                              ]
                          ),
                          obscureText: true,
                          onChanged: (password) {
                            setState(() {
                              _password = password;
                            });
                          },
                          decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: "Password"
                          ),
                        ),
                        SizedBox(height: defaultPadding,),
                        TextFormField(
                          validator: (val) => MatchValidator(errorText: "Passwords do not match").validateMatch(_password, _password2),
                          obscureText: true,
                          onChanged: (password2) {
                            setState(() {
                              _password2 = password2;
                            });
                          },
                          decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: "Repeat Password"
                          ),
                        ),
                        Row(
                          children: [
                            Text("Already have account?"),
                            TextButton(
                              onPressed: () {
                                widget.register();
                              },
                              child: Text("Click here to login!"),
                            )
                          ],
                        ),
                        SizedBox(height: defaultPadding/2,),
                        _error ? Text(_errorMessage, style: TextStyle(color: Colors.red),) : Container(),
                        _error ? SizedBox(height: defaultPadding/2,) : Container(),
                        Container(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: () async{
                              if(_formKey.currentState!.validate()){
                                bool result = await _authService.registerUser(_userEmail, _password);
                                if(result){
                                  //@ TODO: send snackbar
                                  widget.register();
                                }
                                else{
                                  setState(() {
                                    _errorMessage = "This account already exists";
                                    _error = true;
                                  });
                                }
                              }
                            },
                            child: Text("Register"),
                            style: ElevatedButton.styleFrom(primary: Colors.red),
                          ),
                        )
                      ],
                    ),
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
                child: Text("Register", style: TextStyle(color: Colors.white, fontSize: 40, fontWeight: FontWeight.bold),),
              )
          ),
        ],
      ),
    );
  }
}
