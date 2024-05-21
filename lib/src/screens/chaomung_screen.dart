import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:vitaminh/src/class/admin.dart';
import 'package:vitaminh/src/screens/dangnhap_screen.dart';

import '../class/loaicafe.dart';
import '../class/loaidouong.dart';

class ChaoMung_Screen extends StatefulWidget {
  const ChaoMung_Screen({super.key});
  @override
  State<ChaoMung_Screen> createState() => _ChaoMung_ScreenState();
}


class _ChaoMung_ScreenState extends State<ChaoMung_Screen> {
  final CollectionReference loaiCafeCollection =
  FirebaseFirestore.instance.collection('do_uong');



  Future<void> addListOfLoaiCafeToFirestore(List<LoaiCafe> listOfLoaiCafe) async {
    try {
      // Lặp qua danh sách và thêm từng đối tượng LoaiCafe vào Firestore
      for (var loaiCafe in listOfLoaiCafe) {
        await loaiCafeCollection.doc(loaiCafe.id).set(loaiCafe.toMap());
        print('Loại cafe đã được thêm vào Firestore');
      }
      print('Danh sách loại cafe đã được thêm vào Firestore');
    } catch (e) {
      print('Lỗi khi thêm danh sách loại cafe vào Firestore: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: 98,
              ),
              Image.asset('assets/images/logo/logo_color.png', width: 375, height: 287, fit: BoxFit.fill,),
              SizedBox(
                height: 60,
              ),
              Container(
                width: 239,
                height: 81,
                child: Text(
                  'Mang lại hạnh phúc đến cho bạn',
                  style: GoogleFonts.poppins(
                    fontSize: 25,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              Container(
                // alignment: Alignment.center,
                width: 256,
                child: Text(
                  'Tiếp tục để trải nghiệm',
                  style: GoogleFonts.poppins(fontSize: 18, color: Color(0xffAAAAAA)),
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(
                height: 121,
              ),
              Container(
                alignment: Alignment.bottomRight,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(0, 0, 50, 0),
                  child: Container(
                    height: 64,
                    width: 64,
                    decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(50)),
                    child: ElevatedButton(
                      child: Icon(
                        Icons.arrow_right_alt,
                        color: Colors.white,
                        size: 25,
                      ),
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => DangNhap_Screen(),));
                      },
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xff324A59)),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
