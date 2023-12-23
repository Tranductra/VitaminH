import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:vitaminh/src/screens/loaicafe_screen.dart';

import '../class/loaicafe.dart';

class ChiTietCafe_Screen extends StatefulWidget {
  final LoaiCafe loaiCafe;

  ChiTietCafe_Screen(this.loaiCafe, {Key? key}) : super(key: key);

  @override
  _ChiTietCafe_ScreenState createState() => _ChiTietCafe_ScreenState();
}

class _ChiTietCafe_ScreenState extends State<ChiTietCafe_Screen> {
  int soLuong = 1;

  @override
  Widget build(BuildContext context) {
    double tongTien = soLuong * double.parse(widget.loaiCafe.gia);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Thông tin',
          style: GoogleFonts.poppins(color: Colors.black, fontSize: 20),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Container(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.asset(widget.loaiCafe.anh, width: double.infinity),
                SizedBox(height: 30),
                Center(
                  child: Text(
                    widget.loaiCafe.ten,
                    style: GoogleFonts.poppins(
                        fontSize: 20, fontWeight: FontWeight.w600),
                  ),
                ),
                SizedBox(height: 20),
                Container(
                  height: 60,
                  decoration: BoxDecoration(
                    color: Colors.grey,
                    borderRadius: BorderRadius.circular(50)
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      IconButton(
                        icon: Icon(Icons.remove),
                        onPressed: () {
                          if (soLuong > 1) {
                            setState(() {
                              soLuong--;
                            });
                          }
                        },
                      ),
                      Text(
                        '$soLuong',
                        style: GoogleFonts.poppins(fontSize: 18),
                      ),
                      IconButton(
                        icon: Icon(Icons.add),
                        onPressed: () {
                          setState(() {
                            soLuong++;
                          });
                        },
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 210),
                Container(
                  child: Text(
                    'Tổng tiền:               ${tongTien.toStringAsFixed(2)} VND',
                    style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.w500),
                  ),
                ),
                SizedBox(height: 50),
            Center(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.black,
                    backgroundColor: Color(0xffD8D8D8)
                ),
                onPressed: () {

                },
                child: Text('Đặt hàng', style: GoogleFonts.poppins(fontWeight: FontWeight.w600),),
              ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
