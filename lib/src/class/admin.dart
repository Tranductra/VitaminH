// Tạo đối tượng Admin
import 'package:cloud_firestore/cloud_firestore.dart';

class Admin {
  final String email;
  final String password;

  Admin({required this.email, required this.password});

  // Chuyển đối tượng thành Map để lưu vào Firestore
  Map<String, dynamic> toMap() {
    return {'email': email, 'password': password};
  }
}

// Thêm tài khoản admin vào Firestore
Future<void> addAdminToFirestore(Admin admin) async {
  try {
    CollectionReference adminCollection =
    FirebaseFirestore.instance.collection('admin');

    // Thêm đối tượng Admin vào Firestore
    await adminCollection.doc(admin.email).set(admin.toMap());

    print('Tài khoản admin đã được thêm vào Firestore');
  } catch (e) {
    print('Lỗi khi thêm tài khoản admin vào Firestore: $e');
  }
}


// Gọi hàm để thêm tài khoản admin vào Firestore
