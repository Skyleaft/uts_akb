import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:uts_akb/pages/detailmhs.dart';
import 'package:uts_akb/pages/home.dart';
import 'package:uts_akb/pages/login.dart';
import 'package:uts_akb/utils/constants.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: Size(375, 812),
      builder: () => MaterialApp(
        debugShowCheckedModeBanner: false,
        title: "UTS AKB - Milzan Malik",
        theme: ThemeData(
          scaffoldBackgroundColor: Constants.scaffoldBackgroundColor,
          visualDensity: VisualDensity.adaptivePlatformDensity,
          textTheme: GoogleFonts.poppinsTextTheme(),
        ),
        initialRoute: "/Home",
        onGenerateRoute: _onGenerateRoute,
      ),
    );
  }
}

Route<dynamic> _onGenerateRoute(RouteSettings settings) {
  switch (settings.name) {
    case "/":
      return MaterialPageRoute(builder: (BuildContext context) {
        return Login();
      });
    case "/Home":
      return MaterialPageRoute(builder: (BuildContext context) {
        return Home();
      });
    case "/Detailmhs":
      return MaterialPageRoute(builder: (BuildContext context) {
        return Detailmhs();
      });
    default:
      return MaterialPageRoute(builder: (BuildContext context) {
        return Login();
      });
  }
}
