import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/cartprovider.dart';

class GioHang_Screen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var cartItems = context.watch<CartProvider>().cartItems;

    return Scaffold(
      appBar: AppBar(
        title: Text('Giỏ hàng'),
      ),
      body: ListView.builder(
        itemCount: cartItems.length,
        itemBuilder: (context, index) {
          var cartItem = cartItems[index];

          return ListTile(
            title: Text(cartItem.ten),
            subtitle: Text('Số lượng: ${cartItem.soLuong}'),
            trailing: IconButton(
              icon: Icon(Icons.delete),
              onPressed: () {
                context.read<CartProvider>().removeFromCart(cartItem);
              },
            ),
          );
        },
      ),
      bottomNavigationBar: BottomAppBar(
        child: ElevatedButton(
          onPressed: () {
            // Thực hiện thanh toán
            context.read<CartProvider>().clearCart();
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Đã thanh toán thành công'),
              ),
            );
          },
          child: Text('Thanh toán'),
        ),
      ),
    );
  }
}
