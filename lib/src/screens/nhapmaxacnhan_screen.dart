import 'package:flutter/material.dart';
import 'package:vitaminh/src/class/phoneverificationservice.dart';

class NhapMaXacNhan_Screen extends StatefulWidget {
  final String phoneNumber;

  const NhapMaXacNhan_Screen({Key? key, required this.phoneNumber}) : super(key: key);

  @override
  _NhapMaXacNhan_ScreenState createState() => _NhapMaXacNhan_ScreenState();
}

class _NhapMaXacNhan_ScreenState extends State<NhapMaXacNhan_Screen> {
  final TextEditingController _codeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Nhập mã xác nhận'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Nhập mã xác nhận đã được gửi đến số điện thoại: ${widget.phoneNumber}'),
            SizedBox(height: 16.0),
            TextField(
              controller: _codeController,
              decoration: InputDecoration(labelText: 'Mã xác nhận'),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () async {
                // Gọi hàm để xác nhận mã và thông báo đăng ký thành công
                String code = _codeController.text.trim();
                await PhoneVerificationService().signInWithPhoneNumberAndCode(
                  code,
                  widget.phoneNumber,
                );

                // Hiển thị thông báo đăng ký thành công
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: Text('Đăng ký thành công'),
                      content: Text('Bạn đã trở thành thành viên của ứng dụng.'),
                      actions: <Widget>[
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                            // Quay lại trang đăng nhập
                            Navigator.pop(context);
                          },
                          child: Text('OK'),
                        ),
                      ],
                    );
                  },
                );
              },
              child: Text('Xác nhận'),
            ),
          ],
        ),
      ),
    );
  }
}
