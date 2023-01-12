import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hexcolor/hexcolor.dart';


ThemeData lighttheme= ThemeData(
    scaffoldBackgroundColor: Colors.white,
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      type: BottomNavigationBarType.fixed,
      selectedItemColor: Colors.blue,
      unselectedItemColor: Colors.grey,
      elevation: 20.0,
      backgroundColor: Colors.white,
    ),
    appBarTheme: const AppBarTheme(
      iconTheme: IconThemeData(color: Colors.white),
      backgroundColor: Colors.white,
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: Colors.white,
        statusBarIconBrightness: Brightness.dark,
      ),
      elevation: 0.0,
      titleTextStyle: TextStyle(
        fontFamily: 'Jannah',
        color: Colors.black,
        fontWeight: FontWeight.bold,
        fontSize: 20,
      ),
      titleSpacing: 20,
      actionsIconTheme: IconThemeData(color: Colors.white),

    ),
    tabBarTheme: TabBarTheme(
      labelColor: Colors.white ,
      labelPadding: EdgeInsets.only(bottom: 10),
      labelStyle: TextStyle(fontSize: 18),
      indicator: UnderlineTabIndicator(
        borderSide: BorderSide(color: Colors.white)
      ),

    ),
    textTheme: TextTheme(
        bodyText1: TextStyle(
          fontFamily: 'Jannah',
          fontSize: 18,
          fontWeight: FontWeight.w600,
          color: Colors.black,
        ),
        subtitle1: TextStyle(
          fontFamily: 'Jannah',
          fontSize: 14,
          fontWeight: FontWeight.w600,
          color: Colors.black,
        ),
        caption: TextStyle(
          fontFamily: 'Jannah',
          color: Colors.grey,
        )
    )

) ;

ThemeData darktheme= ThemeData(
    scaffoldBackgroundColor: HexColor('333739'),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      type: BottomNavigationBarType.fixed,
      selectedItemColor: Colors.blue,
      unselectedItemColor: Colors.grey,
      elevation: 20.0,
      backgroundColor: HexColor('333739'),
    ),
    appBarTheme: AppBarTheme(
      backgroundColor: HexColor('333739'),
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: HexColor('333739'),
        statusBarIconBrightness: Brightness.light,
      ),
      elevation: 0.0,
      titleTextStyle: TextStyle(
        fontFamily: 'Jannah',
        color: Colors.white,
        fontWeight: FontWeight.bold,
        fontSize: 20,
      ),
      titleSpacing: 20,
      actionsIconTheme: IconThemeData(color: Colors.white),

    ),
    textTheme: TextTheme(
        bodyText1: TextStyle(
          fontFamily: 'Jannah',
          fontSize: 18,
          fontWeight: FontWeight.w600,
          color: Colors.white,
        ),
        subtitle1: TextStyle(
          fontFamily: 'Jannah',
          fontSize: 14,
          fontWeight: FontWeight.w600,
          color: Colors.white,
    ),
        caption: TextStyle(
          fontFamily: 'Jannah',
          color: Colors.black,
        )
    )
) ;