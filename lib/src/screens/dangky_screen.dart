import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_database/firebase_database.dart';
import '../blocs/loginsignup_bloc.dart';
import '../class/phoneverificationservice.dart';
import 'nhapmaxacnhan_screen.dart';
class DangKy_Screen extends StatefulWidget {
  const DangKy_Screen({super.key});
  @override
  State<DangKy_Screen> createState() => _DangKy_ScreenState();
}

class _DangKy_ScreenState extends State<DangKy_Screen> {
  bool _obscurePassword = true;
  TextEditingController _emailController = TextEditingController();
  TextEditingController _matKhauController = TextEditingController();
  TextEditingController _soDienThoaiController = TextEditingController();
  TextEditingController _tenTaiKhoanController = TextEditingController();

  // String formatPhoneNumber(String phoneNumber) {
  //   // Loại bỏ các ký tự không phải số từ chuỗi số điện thoại
  //   String cleanedPhoneNumber = phoneNumber.replaceAll(RegExp(r'\D'), '');
  //
  //   // Kiểm tra xem số điện thoại có bắt đầu bằng mã quốc gia hay không
  //   if (cleanedPhoneNumber.startsWith('+')) {
  //     return cleanedPhoneNumber; // Đã có mã quốc gia, không làm gì cả
  //   } else {
  //     // Nếu không có mã quốc gia, bạn có thể thêm một mã quốc gia mặc định
  //     String defaultCountryCode = '+84'; // Thay thế bằng mã quốc gia mặc định của bạn
  //     return '$defaultCountryCode$cleanedPhoneNumber';
  //   }
  // }

  //Bloc
  LoginSignUp_Bloc _loginSignUp_Bloc = LoginSignUp_Bloc();
  _onClickeDangKy() async{
    if (_loginSignUp_Bloc.isValidSingUp(
        _emailController.text.trim(),
        _matKhauController.text.trim(),
        _tenTaiKhoanController.text.trim(),
        _soDienThoaiController.text.trim())) {
      // Định dạng số điện thoại theo chuẩn E.164
      // String formattedPhoneNumber = formatPhoneNumber(_soDienThoaiController.text.trim());
      // print(formattedPhoneNumber);  // Kết quả: +84931269870

      // Chuyển đến trang nhập mã xác nhận
      // Navigator.push(
      //   context,
      //   MaterialPageRoute(
      //     builder: (context) => NhapMaXacNhan_Screen(
      //       phoneNumber: _soDienThoaiController.text.trim(),
      //     ),
      //   ),
      // );
      _dangKyTaiKhoan(
          _emailController.text.trim(),
          _matKhauController.text.trim(),
          _tenTaiKhoanController.text.trim(),
          _soDienThoaiController.text.trim());
    }
  }

  @override
  void dispose() {
    _loginSignUp_Bloc.dispose();
    // TODO: implement dispose
    super.dispose();
  }


  Future<void> _dangKyTaiKhoan(String email, String matKhau, String tenTaiKhoan,
      String soDienThoai) async {
    try {
      // Đăng ký tài khoản với Firebase Authentication
      UserCredential userCredential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: matKhau,
      );
      await FirebaseFirestore.instance.collection('users').doc(userCredential.user!.uid).set({
        'hoTen': tenTaiKhoan,
        'soDienThoai': soDienThoai,
      });

      // Hiển thị thông báo đăng ký thành công
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Đăng ký thành công'),
            content: Text('Bạn đã trở thành thành viên Vitamin H'),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  Navigator.pop(context);
                },
                child: Text("OK"),
              ),
            ],
          );
        },
      );
    } catch (e) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Đăng ký thất bại!'),
            content: Text('Đã xảy ra lỗi. Vui lòng liên hệ CSKH'),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text("OK"),
              ),
            ],
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Container(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 41),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 50,
                ),
                Container(
                  child: Text(
                    'Đăng ký',
                    style: GoogleFonts.poppins(
                        fontSize: 24,
                        color: Colors.black,
                        fontWeight: FontWeight.w500),
                  ),
                ),
                SizedBox(
                  height: 24,
                ),
                Container(
                  child: Text(
                    'Tạo thành viên ngay bây giờ',
                    style: GoogleFonts.poppins(
                        fontSize: 14, color: Color(0xffAAAAAA)),
                  ),
                ),
                SizedBox(
                  height: 46,
                ),
                Container(
                    child: StreamBuilder(
                        stream: _loginSignUp_Bloc.tenTaiKhoanStream,
                        builder: (context, snapshot) => TextField(
                              controller: _tenTaiKhoanController,
                              decoration: InputDecoration(
                                  errorText: snapshot.hasError
                                      ? snapshot.error.toString()
                                      : null,
                                  prefixIcon: Icon(
                                    Icons.supervised_user_circle_outlined,
                                    size: 25,
                                  ),
                                  labelText: 'Tên tài khoản',
                                  labelStyle: GoogleFonts.poppins(
                                      fontSize: 12, color: Color(0xffC1C7D0))),
                            ))),
                SizedBox(height: 10),
                Container(
                    child: StreamBuilder(
                        stream: _loginSignUp_Bloc.soDienThoaiStream,
                        builder: (context, snapshot) => TextField(
                          keyboardType: TextInputType.phone,
                              controller: _soDienThoaiController,
                              decoration: InputDecoration(
                                  errorText: snapshot.hasError
                                      ? snapshot.error.toString()
                                      : null,
                                  prefixIcon: Icon(
                                    Icons.phone_android,
                                    size: 25,
                                  ),
                                  labelText: 'Số điện thoại',
                                  labelStyle: GoogleFonts.poppins(
                                      fontSize: 12, color: Color(0xffC1C7D0))),
                            ))),
                SizedBox(
                  height: 10,
                ),
                Container(
                    child: StreamBuilder(
                        stream: _loginSignUp_Bloc.emailStream,
                        builder: (context, snapshot) => TextField(
                              controller: _emailController,
                              decoration: InputDecoration(
                                  errorText: snapshot.hasError
                                      ? snapshot.error.toString()
                                      : null,
                                  prefixIcon: Icon(
                                    Icons.mail_outline,
                                    size: 25,
                                  ),
                                  labelText: 'Địa chỉ Email',
                                  labelStyle: GoogleFonts.poppins(
                                      fontSize: 12, color: Color(0xffC1C7D0))),
                            ))),
                SizedBox(height: 10),
                Container(
                    child: StreamBuilder(
                        stream: _loginSignUp_Bloc.matKhauStream,
                        builder: (context, snapshot) => TextField(
                              controller: _matKhauController,
                              obscureText: _obscurePassword,
                              decoration: InputDecoration(
                                  errorText: snapshot.hasError
                                      ? snapshot.error.toString()
                                      : null,
                                  prefixIcon: Icon(
                                    Icons.lock_outline_sharp,
                                    size: 25,
                                  ),
                                  suffixIcon: IconButton(
                                      onPressed: () {
                                        setState(() {
                                          _obscurePassword = !_obscurePassword;
                                        });
                                      },
                                      icon: Icon(
                                        _obscurePassword
                                            ? Icons.visibility
                                            : Icons.visibility_off,
                                      )),
                                  labelText: 'Mật khẩu',
                                  labelStyle: GoogleFonts.poppins(
                                      fontSize: 12, color: Color(0xffC1C7D0))),
                            ))),
                SizedBox(height: 10),
                Container(
                    child: Text(
                        'Bằng cách đăng ký, bạn đồng ý với Điều khoản sử dụng của chúng tôi',
                        style: GoogleFonts.poppins(
                            fontSize: 12, color: Color(0xff324A59)))),
                SizedBox(
                  height: 30,
                ),
                Container(
                  alignment: Alignment.bottomRight,
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
                        _onClickeDangKy();
                      },
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xff324A59)),
                    ),
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                Container(
                  child: RichText(
                    text: TextSpan(
                        text: 'Đã là thành viên? ',
                        style: GoogleFonts.poppins(
                            color: Color(0xffAAAAAA), fontSize: 14),
                        children: [
                          TextSpan(
                            text: 'Đăng nhập',
                            style: TextStyle(
                              color: Colors.black, // Màu cho "Đăng ký."
                              fontSize: 14,
                            ),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                Navigator.pop(context);
                              },
                          ),
                        ]),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
