import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:to_do_application/config/theme/app_theme.dart';
import 'package:to_do_application/core/utiles/routes_manager.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
            designSize: const Size(412, 870),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) => MaterialApp(
        debugShowCheckedModeBanner: false,
        onGenerateRoute:RoutesManager.router,
        initialRoute: RoutesManager.login,
        themeMode:ThemeMode.light ,
        theme: AppTheme.light,
      ),
    );
  }
}