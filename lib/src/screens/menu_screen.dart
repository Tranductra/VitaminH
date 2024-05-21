import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:vitaminh/src/screens/giohang_screen.dart';
import 'package:vitaminh/src/screens/thongtincanhan_screen.dart';
import 'package:vitaminh/src/widgets/bottomnav.dart';
import 'package:vitaminh/src/widgets/menudouong.dart';

import '../class/userdata.dart';

class Menu_Screen extends StatefulWidget {
  const Menu_Screen({super.key});

  State<Menu_Screen> createState() => _Menu_ScreenState();
}

  @override
class _Menu_ScreenState extends State<Menu_Screen> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 120,
        title: Padding(
          padding: const EdgeInsets.fromLTRB(0, 63, 0, 0),
          child: RichText(
            // textAlign: TextAlign.center,
            text: TextSpan(
                text: 'Xin chào \n',
                style: GoogleFonts.poppins(
                  color: Color(0xffD8D8D8),
                  fontSize: 14,
                ),
                children: [
                  TextSpan(
                      text: Provider.of<UserData>(context).hoTen ?? 'User',
                      style: GoogleFonts.poppins(
                          color: Colors.black,
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                          textBaseline: TextBaseline.ideographic))
                ]),
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(top: 63),
            child: IconButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => GioHang_Screen(),));

                },
                icon: Icon(
                  Icons.shopping_cart_outlined,
                  size: 30,
                )),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 63, 20, 0),
            child: IconButton(
                onPressed: (
                    ) {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => ThongTinCaNhan_Screen(),));
                }, icon: Icon(Icons.person_outline, size: 30)),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 20),
        child: Container(
          height: double.infinity,
          width: double.infinity,
          decoration: BoxDecoration(
              color: Color(0xff324A59),
              borderRadius: BorderRadius.vertical(top: Radius.circular(30))
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 26),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 30,),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(5, 0, 0, 0),
                    child: Text(
                      'Lựa chọn coffe của bạn', style: GoogleFonts.poppins(
                        fontSize: 16, color: Colors.white),),
                  ),
                  SizedBox(height: 50,),
                  MenuDoUong()
                  // Đặt gird view item ở đoạn này
                ],
              ),
            ),
          ),
        ),
      ),
      bottomNavigationBar: BottomNav()
    );
  }
}