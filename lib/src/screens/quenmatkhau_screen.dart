import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../blocs/loginsignup_bloc.dart';

class QuenMatKhau_Screen extends StatefulWidget {
  const QuenMatKhau_Screen({super.key});
  @override
  State<QuenMatKhau_Screen> createState() => _QuenMatKhau_ScreenState();
}

class _QuenMatKhau_ScreenState extends State<QuenMatKhau_Screen> {
  TextEditingController _emailController = new TextEditingController();

  FirebaseAuth _auth = FirebaseAuth.instance;

  // Bloc
  LoginSignUp_Bloc _loginSignUp_Bloc = LoginSignUp_Bloc();
  _onClickeQuenMatKhau() {
    if (_loginSignUp_Bloc.isValidForgotPassWord(_emailController.text.trim())) {
      _quenMatKhau(_emailController.text.trim());
    }
  }

  @override
  void dispose() {
    _loginSignUp_Bloc.dispose();
    // TODO: implement dispose
    super.dispose();
  }

  Future<void> _quenMatKhau(String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Đã gửi liên kết!'),
            content: Text('Vui lòng kiểm tra lại email của bạn.'),
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
    } on FirebaseAuthException catch (e) {
      // Đăng nhập không thành công, hiển thị thông báo lỗi
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Có lỗi xảy ra'),
            content: Text(
                'Vui lòng thử lại sau do hệ thống đang gặp lỗi. Xin cảm ơn'),
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
                    'Quên mật khẩu',
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
                    'Vui lòng nhập email của bạn',
                    style: GoogleFonts.poppins(
                        fontSize: 14, color: Color(0xffAAAAAA)),
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                Container(
                    child: StreamBuilder(
                        stream: _loginSignUp_Bloc.emailStream,
                        builder: (context, snapshot) => TextField(
                              controller: _emailController,
                              decoration: InputDecoration(
                                  prefixIcon: Icon(
                                    Icons.mail_outline,
                                    size: 25,
                                  ),
                                  errorText: snapshot.hasError
                                      ? snapshot.error.toString()
                                      : null,
                                  labelText: 'Địa chỉ email',
                                  labelStyle: GoogleFonts.poppins(
                                      fontSize: 12, color: Color(0xffC1C7D0))),
                            ))),
                SizedBox(height: 140),
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
                        _onClickeQuenMatKhau();
                      },
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xff324A59)),
                    ),
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
