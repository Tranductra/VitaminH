import 'dart:async';

class LoginSignUp_Bloc {
  StreamController _emailController = new StreamController();
  StreamController _tenTaiKhoanController = new StreamController();
  StreamController _soDienThoaiController = new StreamController();
  StreamController _matKhauController = new StreamController();

  Stream get emailStream => _emailController.stream;
  Stream get tenTaiKhoanStream => _tenTaiKhoanController.stream;
  Stream get soDienThoaiStream => _soDienThoaiController.stream;
  Stream get matKhauStream => _matKhauController.stream;
  bool isValidForgotPassWord(String email){
    if (email.isEmpty){
      _emailController.sink.addError('Vui lòng nhập email');
      return false;
    }
    if (!email.contains('@')){
      _emailController.sink.addError('Định dạng email không hợp lệ');
      return false;
    }
    _emailController.sink.add('');
    return true;
  }
  bool isValidLogin(String email, String matKhau){
    if (email.isEmpty){
      _emailController.sink.addError('Vui lòng nhập email');
      return false;
    }
    if (!email.contains('@')){
      _emailController.sink.addError('Định dạng email không hợp lệ');
      return false;
    }
    _emailController.sink.add('');
    if (matKhau.isEmpty){
      _matKhauController.sink.addError('Vui lòng nhập mật khẩu');
      return false;
    }
    _matKhauController.sink.add('');
    return true;
  }

  bool isValidSingUp(String email, String matKhau, String tenTaiKhoan, String soDienThoai){
    if (tenTaiKhoan.isEmpty){
      _tenTaiKhoanController.sink.addError('Vui lòng nhập tài khoản');
      return false;
    }
    _tenTaiKhoanController.sink.add('');
    if (soDienThoai.isEmpty){
      _soDienThoaiController.sink.addError('Vui lòng nhập số điện thoại');
      return false;
    }
    _soDienThoaiController.sink.add('');
    if (email.isEmpty){
      _emailController.sink.addError('Vui lòng nhập email');
      return false;
    }
    if (!email.contains('@')){
      _emailController.sink.addError('Định dạng email không hợp lệ');
      return false;
    }
    _emailController.sink.add('');
    if (matKhau.isEmpty){
      _matKhauController.sink.addError('Vui lòng nhập mật khẩu');
      return false;
    }
    _matKhauController.sink.add('');
    return true;
  }

  void dispose(){
    _emailController.close();
    _matKhauController.close();
    _tenTaiKhoanController.close();
    _soDienThoaiController.close();
  }
}