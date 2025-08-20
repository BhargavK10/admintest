import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/cart_provider.dart';

class CartPage extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Cart'),
      ),
      body: cart.cartItems.isEmpty ? Center(
        child: Text('no items in cart'),
      ):ListView.builder(
        itemCount: cart.cartItems.length,
        itemBuilder: (_, index){
          final item = cart.cartItems[index];
          return ListTile(
            leading: Image.network(item.images[0]),
            title: Text(item.name),
            subtitle: Text(item.price.toString()),
            trailing: IconButton(
              onPressed: (){
                cart.removeFromCart(item);
              },
              icon: Icon(Icons.delete)
            ),
          );
        }
      )
    );
  }
}