import 'package:flutter/material.dart';
import 'package:vitaminh/src/screens/admin_screen.dart';
import 'package:vitaminh/src/screens/chaomung_screen.dart';
import 'package:vitaminh/src/screens/chitietcafe_screen.dart';
import 'package:vitaminh/src/screens/dangky_screen.dart';
import 'package:vitaminh/src/screens/dangnhap_screen.dart';
import 'package:vitaminh/src/screens/loaicafe_screen.dart';
import 'package:vitaminh/src/screens/menu_screen.dart';
import 'package:vitaminh/src/screens/quenmatkhau_screen.dart';
import 'package:vitaminh/src/screens/thongtincanhan_screen.dart';


class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        '/screens/dangnhap': (context) => DangNhap_Screen(),
        '/screens/trangchu': (context) => Menu_Screen(),
        '/screens/admin': (context) => Admin_Screen(),
      },
      debugShowCheckedModeBanner: false,
      home: ChaoMung_Screen(),
    );
  }
}
