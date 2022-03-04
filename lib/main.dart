import 'package:flutter/material.dart';
import 'package:lego_flutter_app/screens/auth/profile.dart';
import 'package:lego_flutter_app/screens/category.dart';
import 'package:lego_flutter_app/screens/home.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Lego App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomeScreen(),
      onGenerateRoute: (settings) {
        switch(settings.name){
          case "/category":
            return PageRouteBuilder(
                settings: settings,
                pageBuilder: (_, __, ___) => CategoryScreen(),
                transitionsBuilder: (_, a, __, c) => FadeTransition(opacity: a, child: c)
            );
          case "/home":
            return PageRouteBuilder(
                settings: settings,
                pageBuilder: (_, __, ___) => HomeScreen(),
                transitionsBuilder: (_, a, __, c) => FadeTransition(opacity: a, child: c)
            );
        }
      },
    );
  }
}