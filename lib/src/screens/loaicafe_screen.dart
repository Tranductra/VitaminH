import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:vitaminh/src/screens/chitietcafe_screen.dart';
import 'package:vitaminh/src/widgets/cafewidget.dart';

import '../class/loaicafe.dart';
import '../class/loaidouong.dart';
import '../widgets/menudouong.dart';

class LoaiCafe_Screen extends StatelessWidget {
  final LoaiDoUong loaiDoUong;
  final CollectionReference loaiCafeCollection =
  FirebaseFirestore.instance.collection('do_uong');

  LoaiCafe_Screen({Key? key, required this.loaiDoUong}) : super(key: key);

  Future<void> addLoaiCafeToFirestore(LoaiCafe loaiCafe) async {
    try {
      await loaiCafeCollection.doc(loaiCafe.id).set(loaiCafe.toMap());
      print('Loại cafe đã được thêm vào Firestore');
    } catch (e) {
      print('Lỗi khi thêm loại cafe vào Firestore: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(loaiDoUong.ten),
      ),
      body: FutureBuilder<QuerySnapshot>(
        future: loaiCafeCollection
            .where('loai', isEqualTo: loaiDoUong.id)
            .get(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          }

          if (snapshot.hasError) {
            return Text('Đã xảy ra lỗi: ${snapshot.error}');
          }

          List<LoaiCafe> danhSachCafe = snapshot.data!.docs
              .where((doc) => doc.exists) // Lọc bỏ các tài liệu null
              .map((doc) {
            Map<String, dynamic>? data = doc.data() as Map<String, dynamic>?;

            // Kiểm tra xem mỗi trường có tồn tại không trước khi truy cập
            String id = data?['id'] ?? '';
            String ten = data?['ten'] ?? '';
            String gia = data?['gia'] ?? '';
            String anh = data?['anh'] ?? '';

            return LoaiCafe(id, ten, gia, anh);
          }).toList();

          danhSachCafe.forEach((loaiCafe) {
            addLoaiCafeToFirestore(loaiCafe);
          });

          return Container(
            padding: EdgeInsets.all(16.0),
            child: ListView.builder(
              itemCount: danhSachCafe.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            ChiTietCafe_Screen(danhSachCafe[index]),
                      ),
                    );
                  },
                  child: CafeWidget(danhSachCafe[index]),
                );
              },
            ),
          );
        },
      ),
    );
  }

}
