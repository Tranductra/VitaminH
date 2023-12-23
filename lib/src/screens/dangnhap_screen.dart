import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:vitaminh/src/blocs/loginsignup_bloc.dart';
import 'package:vitaminh/src/screens/dangky_screen.dart';
import 'package:vitaminh/src/screens/quenmatkhau_screen.dart';

import '../class/userdata.dart';

class DangNhap_Screen extends StatefulWidget {
  const DangNhap_Screen({super.key});
  @override
  State<DangNhap_Screen> createState() => _DangNhap_ScreenState();
}

class _DangNhap_ScreenState extends State<DangNhap_Screen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  TextEditingController _emailController = TextEditingController();
  TextEditingController _matKhauController = TextEditingController();
  bool _obscurePassword = true;

  // Bloc
  LoginSignUp_Bloc _loginSignUp_Bloc = LoginSignUp_Bloc();
  _onClickeDangNhap() {
    if (_loginSignUp_Bloc.isValidLogin(
        _emailController.text.trim(), _matKhauController.text.trim())) {
      _dangNhap();
    }
  }

  @override
  void dispose() {
    _loginSignUp_Bloc.dispose();
    // TODO: implement dispose
    super.dispose();
  }

  Future<void> _dangNhap() async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _matKhauController.text.trim(),
      );
      // Sử dụng Firestore thay vì FirebaseDatabase
      DocumentSnapshot snapshot = await FirebaseFirestore.instance
          .collection('users')
          .doc(userCredential.user?.uid)
          .get();

      if (snapshot.exists) {
        Provider.of<UserData>(context, listen: false).setUid(userCredential.user?.uid ?? '');
        Provider.of<UserData>(context, listen: false).setEmail(userCredential.user?.email ?? '');
        Provider.of<UserData>(context, listen: false).setHoTen(snapshot['hoTen'] ?? '');
        Provider.of<UserData>(context, listen: false).setSoDienThoai(snapshot['soDienThoai'] ?? '');
      }


      // Đăng nhập thành công, chuyển hướng qua màn hình Home hoặc thực hiện hành động cần thiết
      Navigator.pushReplacementNamed(context, '/screens/trangchu');
    } on FirebaseAuthException catch (e) {
      // Đăng nhập không thành công, hiển thị thông báo lỗi
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Đăng nhập thất bại'),
            content: Text('Tên tài khoản hoặc mật khẩu không chính xác'),
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
    return WillPopScope(
      onWillPop: () async{
        Navigator.of(context).popUntil((route) => route.isFirst);
        return true;
      },
      child: Scaffold(
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
                      'Đăng nhập',
                      style: GoogleFonts.poppins(
                        fontSize: 24,
                        color: Colors.black,
                        fontWeight: FontWeight.w500
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 24,
                  ),
                  Container(
                    child: Text(
                      'Chào mừng trở lại',
                      style: GoogleFonts.poppins(fontSize: 14, color: Color(0xffAAAAAA)),
                    ),
                  ),
                  SizedBox(
                    height: 46,
                  ),
                  Container(
                      child:StreamBuilder(
                        stream: _loginSignUp_Bloc.emailStream,
                        builder: (context, snapshot) => TextField(
                          controller: _emailController,
                          decoration: InputDecoration(
                            prefixIcon: Icon(Icons.mail_outline, size: 25,),
                              errorText: snapshot.hasError ? snapshot.error.toString() : null,
                              labelText: 'Email',
                              labelStyle: GoogleFonts.poppins(
                                  fontSize: 12, color: Color(0xffC1C7D0))),
                        ),
                      )
                  ),
                  SizedBox(height: 10),
                  Container(
                      child:StreamBuilder(
                        stream: _loginSignUp_Bloc.matKhauStream,
                        builder: (context, snapshot) => TextField(
                          controller: _matKhauController,
                          obscureText: _obscurePassword,
                          decoration: InputDecoration(
                              errorText: snapshot.hasError ? snapshot.error.toString() : null,
                              prefixIcon: Icon(Icons.lock_outline_sharp, size: 25,),
                              suffixIcon: IconButton(
                                icon: Icon(_obscurePassword ? Icons.visibility : Icons.visibility_off,),
                                onPressed: () {
                                  setState(() {
                                    _obscurePassword = !_obscurePassword;
                                  });
                                },
                              ),
                              labelText: 'Mật khẩu',
                              labelStyle: GoogleFonts.poppins(
                                  fontSize: 12, color: Color(0xffC1C7D0))),
                        ),
                      )
                  ),
                  SizedBox(height: 27),
                  Container(
                    alignment: Alignment.center,
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => QuenMatKhau_Screen(),));
                      },
                      child: Text('Quên mật khẩu?', style: GoogleFonts.poppins(
                        color: Colors.black,
                        fontSize: 14,
                        decoration: TextDecoration.underline
                      ),),
                    ),
                  ),
                  SizedBox(height: 130,),
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
                          _onClickeDangNhap();
                        },
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Color(0xff324A59)),
                      ),
                    ),
                  ),
                  SizedBox(height: 65,),
                  Container(
                    child: RichText(
                      text: TextSpan(text: 'Thành viên mới? ', style: GoogleFonts.poppins(
                        color: Color(0xffAAAAAA),
                        fontSize: 14
                      ),
                        children: [
                          TextSpan(
                            text: 'Đăng ký',
                            style: TextStyle(
                              color: Colors.black, // Màu cho "Đăng ký."
                              fontSize: 14,
                            ),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                Navigator.push(context, MaterialPageRoute(builder: (context) => DangKy_Screen(),));
                              },
                          ),
                        ]
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
