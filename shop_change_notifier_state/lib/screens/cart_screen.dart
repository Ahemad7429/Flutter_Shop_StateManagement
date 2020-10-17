import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/providers.dart';
import '../widgets/widgets.dart' as widget;

class CartScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Cart'),
      ),
      body: Column(
        children: [
          Card(
            margin: const EdgeInsets.all(15),
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Total',
                    style: TextStyle(fontSize: 20),
                  ),
                  Spacer(),
                  Chip(
                    label: Text(
                      '\$${cart.totalAmount.toStringAsFixed(2)}',
                      style: TextStyle(
                        color:
                            Theme.of(context).primaryTextTheme.headline6.color,
                      ),
                    ),
                    backgroundColor: Theme.of(context).primaryColor,
                  ),
                  FlatButton(
                    textColor: Theme.of(context).primaryColor,
                    child: Text('ORDER NOW'),
                    onPressed: () {
                      Provider.of<OrdersProvider>(context, listen: false)
                          .addItem(
                        cartProducts: cart.items.values.toList(),
                        total: cart.totalAmount,
                      );
                      cart.clearCart();
                    },
                  )
                ],
              ),
            ),
          ),
          SizedBox(height: 10),
          Expanded(
            child: ListView.builder(
              itemBuilder: (ctx, index) {
                return widget.CartItem(
                  productId: cart.items.keys.toList()[index],
                  cartItem: cart.items.values.toList()[index],
                );
              },
              itemCount: cart.items.length,
            ),
          )
        ],
      ),
    );
  }
}
