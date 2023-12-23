import 'package:flutter/material.dart';

class UserData extends ChangeNotifier {
  String? email;
  String? hoTen;
  String? soDienThoai;
  String? uid;

  void setUid(String _uid) {
    uid = _uid;
    notifyListeners();
  }

  void updateUserData({String? hoTen, String? soDienThoai, String? email}) {
    this.hoTen = hoTen;
    this.soDienThoai = soDienThoai;
    this.email = email;
    notifyListeners();
  }


  void setEmail(String _email) {
    email = _email;
    notifyListeners();
  }
  void setSoDienThoai(String _soDienThoai) {
    soDienThoai = _soDienThoai;
    notifyListeners();
  }
  void setHoTen(String _hoTen) {
    hoTen = _hoTen;
    notifyListeners();
  }
}