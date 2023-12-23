class LoaiCafe {
  final String id;
  final String ten;
  final String gia;
  final String anh;

  LoaiCafe(this.id, this.ten, this.gia, this.anh);
  // Hàm chuyển đổi dữ liệu thành Map để lưu trữ trên Firestore
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'ten': ten,
      'gia': gia,
      'anh': anh,
    };
  }

  // Hàm tạo từ Map để đọc dữ liệu từ Firestore
  factory LoaiCafe.fromMap(Map<String, dynamic> map) {
    return LoaiCafe(
      map['id'],
      map['ten'],
      map['gia'],
      map['anh'],
    );
  }
}
