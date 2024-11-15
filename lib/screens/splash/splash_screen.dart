
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:to_do_application/core/utiles/assets_manager.dart';
import 'package:to_do_application/core/utiles/colors_managers.dart';
import 'package:to_do_application/core/utiles/routes_manager.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 3),(){
             Navigator.pushReplacementNamed(context, RoutesManager.home);



    });
  }
  @override
  Widget build(BuildContext context) {
    // طريقه  
    // Future.delayed(Duration(seconds: 3),()
    // {
    //   Navigator.pushReplacementNamed(context, RoutesManager.homeRoute);

    // }
    // );
    return Container(
      color: ColorsManagers.ScaffoldBg,
      child: Column(
        children: [
          Expanded(child: Image.asset(AssetsManager.logo,height: 211,width:189 ,)),
          Image.asset(AssetsManager.logoname),
        ],
      ),
    );
  }
}