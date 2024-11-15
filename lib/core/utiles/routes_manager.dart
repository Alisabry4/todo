import 'package:flutter/material.dart';
import 'package:to_do_application/screens/auth/login/login.dart';
import 'package:to_do_application/screens/auth/register/register.dart';
import 'package:to_do_application/screens/home/home_screen.dart';
import 'package:to_do_application/screens/splash/splash_screen.dart';

class RoutesManager {
  static const String splash = '/splash';
  static const String home = '/home';
    static const String register = '/register';
        static const String login = '/login';



  // ignore: body_might_complete_normally_nullable
  static Route? router (RouteSettings settings){
    switch(settings.name){
      case home :
      return MaterialPageRoute(builder: (context) => HomeScreen(),);
       case splash :
      return MaterialPageRoute(builder: (context) => SplashScreen(),);
             case register :
      return MaterialPageRoute(builder: (context) => RegisterScrren(),);
                   case login :
      return MaterialPageRoute(builder: (context) => Login(),);


    }
  }
}