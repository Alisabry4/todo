import 'package:flutter/material.dart';
import 'package:to_do_application/core/utiles/app_styles.dart';
import 'package:to_do_application/core/utiles/colors_managers.dart';

class AppTheme {
  static  ThemeData light = ThemeData(
    useMaterial3: false,
    primaryColor: Colors.blue,
    colorScheme: ColorScheme.fromSeed(seedColor: ColorsManagers.blue,
    primary: ColorsManagers.blue,
    onPrimary: ColorsManagers.white
    ),
    appBarTheme: AppBarTheme(
      elevation: 0,
      backgroundColor: ColorsManagers.blue,
      titleTextStyle: AppLightStyles.appBarTextStyle
    ),
    
    scaffoldBackgroundColor: ColorsManagers.ScaffoldBg,
    bottomAppBarTheme: BottomAppBarTheme(
      color: ColorsManagers.white,
      shape: CircularNotchedRectangle(),
    ),
    
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      
      backgroundColor: ColorsManagers.blue,

      shape: StadiumBorder(side: BorderSide(color: ColorsManagers.white,width: 4)), //او .
      iconSize: 33,

      //shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50),side: BorderSide(color: ColorsManagers.white,width: 4)),
    ),
     bottomSheetTheme: BottomSheetThemeData(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(12),
          topRight: Radius.circular(12),
        
      )),
                backgroundColor:ColorsManagers.white,
                elevation: 18
                //backgroundColor:Colors.blueGrey

     ),
    //iconTheme: IconThemeData(color: ColorsManagers.white,size: 100),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: Colors.transparent,
       elevation: 0,
      //backgroundColor: ColorsManagers.white,
      type: BottomNavigationBarType.fixed,
      selectedItemColor: ColorsManagers.blue,
      unselectedItemColor: ColorsManagers.grey

    )
  );
}