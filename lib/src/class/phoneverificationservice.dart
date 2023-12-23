import 'package:firebase_auth/firebase_auth.dart';

class PhoneVerificationService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> verifyPhoneNumber(String phoneNumber) async {
    try {
      await _auth.verifyPhoneNumber(
        phoneNumber: phoneNumber,
        verificationCompleted: (PhoneAuthCredential credential) async {
          await _auth.signInWithCredential(credential);
        },
        verificationFailed: (FirebaseAuthException e) {
          print('Lỗi xác nhận số điện thoại: $e');
          // Xử lý lỗi tại đây
        },
        codeSent: (String verificationId, int? resendToken) {
          print('Mã xác nhận đã được gửi đến số điện thoại: $verificationId');
        },
        codeAutoRetrievalTimeout: (String verificationId) {
          print('Hết thời gian xác nhận tự động cho mã: $verificationId');
        },
        timeout: Duration(minutes: 2),
      );
    } catch (e) {
      print('Lỗi xác nhận số điện thoại: $e');
      // Xử lý lỗi tại đây
    }
  }

  Future<void> signInWithPhoneNumberAndCode(String smsCode, String phoneNumber) async {
    try {
      PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: 'YOUR_VERIFICATION_ID', // Thay thế bằng verification ID từ quá trình xác nhận số điện thoại
        smsCode: smsCode,
      );

      await _auth.signInWithCredential(credential);

      User? currentUser = _auth.currentUser;
      if (currentUser != null) {
        await currentUser.updatePhoneNumber(credential);
        await currentUser.reload();
        currentUser = _auth.currentUser;

        print('Số điện thoại sau cập nhật: ${currentUser?.phoneNumber}');
      }
    } catch (e) {
      print('Lỗi đăng nhập với mã xác nhận: $e');
      // Xử lý lỗi tại đây
    }
  }
}
