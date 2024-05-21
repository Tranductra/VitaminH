import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:vitaminh/src/screens/loaicafe_screen.dart';
import 'package:vitaminh/src/widgets/menuitem.dart';

import '../class/loaidouong.dart';


class MenuDoUong extends StatefulWidget {
  const MenuDoUong({super.key});

  @override
  State<MenuDoUong> createState() => _MenuDoUongState();
}

class _MenuDoUongState extends State<MenuDoUong> {
  // // Dữ liệu mẫu cho 6 loại đồ uống
  // List<Map<String, dynamic>> loaiDoUongData = [
  //   {"id": "1", "ten": "Americano", "anh": "assets/images/logo/logo_amerricano.png"},
  //   {"id": "2", "ten": "Cappuccino", "anh": "assets/images/logo/logo_cappuccino.png"},
  //   {"id": "3", "ten": "Latte", "anh": "assets/images/logo/logo_latte.png"},
  //   {"id": "4", "ten": "Flat White", "anh": "assets/images/logo/logo_flatwhite.png"},
  //   {"id": "5", "ten": "Raf", "anh": "assets/images/logo/logo_raf.png"},
  //   {"id": "6", "ten": "Espreso", "anh": "assets/images/logo/logo_espreso.png"},
  // ];

// Thêm dữ liệu vào bảng loai_do_uong
//   Future<void> themDuLieuLoaiDoUong() async {
//     CollectionReference loaiDoUongCollection = FirebaseFirestore.instance.collection('loai_do_uong');
//
//     for (Map<String, dynamic> data in loaiDoUongData) {
//       await loaiDoUongCollection.doc(data['id']).set(data);
//     }
//   }

  // Tạo danh sách trống để chứa dữ liệu từ Firestore
  List<LoaiDoUong> _loaiDoUong = [];
  @override
  void initState() {
    super.initState();


    // Gọi hàm để lấy dữ liệu từ Firestore khi StatefulWidget được tạo
    _getLoaiDoUongData();

  }
  Future<void> _getLoaiDoUongData() async {
    try {
      WidgetsFlutterBinding.ensureInitialized();
      await Firebase.initializeApp();
      //
      // // Thêm dữ liệu loại đồ uống
      // await themDuLieuLoaiDoUong();
      // Thêm dữ liệu đồ uống
      // await themDuLieuDoUong();
      // Lấy tham chiếu đến bảng loai_do_uong từ Firestore
      CollectionReference loaiDoUongCollection =
      FirebaseFirestore.instance.collection('loai_do_uong');

      // Lấy dữ liệu từ Firestore
      QuerySnapshot querySnapshot = await loaiDoUongCollection.get();

      // Chuyển đổi dữ liệu thành đối tượng LoaiDoUong và đặt vào danh sách
      List<LoaiDoUong> loaiDoUongList = querySnapshot.docs.map((doc) {
        Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
        return LoaiDoUong(data['id'], data['ten'], data['anh']);
      }).toList();

      // Cập nhật trạng thái để rebuild widget với dữ liệu mới
      setState(() {
        _loaiDoUong = loaiDoUongList;
      });
    } catch (error) {
      // Xử lý lỗi nếu có
      print('Lỗi khi lấy dữ liệu từ Firestore: $error');
    }
  }


  // do_uong
  // Dữ liệu mẫu cho đồ uống (sử dụng cho một loại đồ uống, bạn có thể mở rộng cho các loại khác)
  List<Map<String, dynamic>> doUongData = [
    {"ten": "Cappuccino đá", "gia": "15000", "anh": "assets/images/logo/logo_cappuccino.png", "loai": "2"},
    {"ten": "Cappuccino nóng", "gia": "15000", "anh": "assets/images/logo/logo_cappuccino.png", "loai": "2"},
    {"ten": "Americano nóng", "gia": "25000", "anh": "assets/images/logo/logo_amerricano.png", "loai": "1"},
    {"ten": "Americano đá", "gia": "25000", "anh": "assets/images/logo/logo_amerricano.png", "loai": "1"},
    {"ten": "Americano pha sữa", "gia": "35000", "anh": "assets/images/logo/logo_amerricano.png", "loai": "1"},
    {"ten": "Latte nóng", "gia": "35000", "anh": "assets/images/logo/logo_latte.png", "loai": "3"},
    // Thêm các đồ uống khác cho loại khác
  ];

// Thêm dữ liệu vào bảng do_uong
//   Future<void> themDuLieuDoUong() async {
//     CollectionReference doUongCollection = FirebaseFirestore.instance.collection('do_uong');
//
//     for (Map<String, dynamic> data in doUongData) {
//       await doUongCollection.add(data);
//     }
//   }


  @override
  Widget build(BuildContext context) {

    return Container(
      height: 500,
      child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 10,
            mainAxisSpacing: 15,
            mainAxisExtent: 150
          ),
          itemCount: _loaiDoUong.length,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                // Chuyển đến trang mới khi người dùng chọn một mục
                // Bạn có thể sử dụng Navigator.push để chuyển đến trang mới
                Navigator.push(context, MaterialPageRoute(builder: (context) => LoaiCafe_Screen(loaiDoUong: _loaiDoUong[index])));
              },
              child: MenuItem(
                id: _loaiDoUong[index].id,
                ten: _loaiDoUong[index].ten,
                anh: _loaiDoUong[index].anh,
              ),
            );
          }),
    );
  }
}
