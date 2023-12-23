import 'package:flutter/material.dart';

import 'bottomnavitem.dart';

class BottomNav extends StatefulWidget {
  const BottomNav({super.key});

  @override
  State<BottomNav> createState() => _BottomNavState();
}

class _BottomNavState extends State<BottomNav> {
  bool _isSelectedTrangChu = true;
  bool _isSelectedQuaTang = false;
  bool _isSelectedHoaDon = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: EdgeInsets.all(10.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            BottomNavItem(icon: Icons.storefront_outlined, label: 'Trang chủ', isSelected: _isSelectedTrangChu, onTap: (){
              setState(() {
                _isSelectedQuaTang = false;
                _isSelectedTrangChu = true;
                _isSelectedHoaDon = false;
              });
            } ),
            BottomNavItem(
                icon: Icons.card_giftcard_rounded,
                label: 'Quà tặng', isSelected: _isSelectedQuaTang,
                onTap: (){
              setState(() {
                _isSelectedQuaTang = true;
                _isSelectedTrangChu = false;
                _isSelectedHoaDon = false;
              });
            } ),
            BottomNavItem(
                icon: Icons.shopping_bag_outlined,
                label: 'Hóa đơn', isSelected: _isSelectedHoaDon,
                onTap: (){
              setState(() {
                _isSelectedQuaTang = false;
                _isSelectedTrangChu = false;
                _isSelectedHoaDon = true;
              });
            } ),
          ],
        ),
      ),
    );
  }
}
