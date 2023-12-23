import 'package:flutter/material.dart';
import 'package:vitaminh/src/screens/loaicafe_screen.dart';

import '../class/loaicafe.dart';

class CafeWidget extends StatelessWidget {
  LoaiCafe _loaiCafe;

  CafeWidget(this._loaiCafe, {super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 5, 0, 5),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(10, 15, 10, 15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Image.asset(_loaiCafe.anh,width: 50,),
              Container(
                width: 150,
                child: Flexible(
                  child: Text(
                    _loaiCafe.ten,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      overflow: TextOverflow.ellipsis, // Để cắt bớt khi quá dài
                    ),
                  ),
                ),
              ),
              Text(_loaiCafe.gia, style: TextStyle(fontSize: 13))
            ],
          ),
        ),
      ),
    );
  }
}
