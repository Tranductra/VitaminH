import 'package:flutter/material.dart';

class BottomNavItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool isSelected;
  final Function onTap;

  const BottomNavItem({
    Key? key,
    required this.icon,
    required this.label,
    required this.isSelected,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onTap(),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            color: isSelected ? Color(0xff324A59) : Color(0xffD8D8D8),
          ),
          SizedBox(height: 4.0),
          Text(
            label,
            style: TextStyle(
              color: isSelected ? Color(0xff324A59) : Color(0xffD8D8D8),
            ),
          ),
        ],
      ),
    );
  }
}
