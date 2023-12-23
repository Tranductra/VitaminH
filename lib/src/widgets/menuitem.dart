import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MenuItem extends StatelessWidget {

  final String id;
  final String ten;
  final String anh;
  const MenuItem({required this.id, required this.ten, required this.anh});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: Colors.white
      ),
      child: Column(
        children: [
          SizedBox(height: 20,),
          Image.asset(anh, width: 115, height: 80,),
          SizedBox(height: 10,),
          Text(ten, style: GoogleFonts.poppins(fontSize: 14, color: Colors.black, fontWeight: FontWeight.w500),)
        ],
      ),

    );
  }
}
