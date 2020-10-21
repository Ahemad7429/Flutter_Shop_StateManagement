import 'dart:convert';

import 'package:flutter/material.dart';
import '../models/models.dart';
import 'package:http/http.dart' as http;

class OrdersProvider with ChangeNotifier {
  List<OrderItem> _orders = [];

  List<OrderItem> get orders {
    return [..._orders];
  }

  Future<void> fetchAndSetOrders() async {
    final url = 'https://fluttershop-b14ae.firebaseio.com/orders.json';
    final response = await http.get(url);
    List<OrderItem> loadedOrders = [];
    //print(json.decode(response.body));
    final featchedData = json.decode(response.body) as Map<String, dynamic>;
    if (featchedData == null) {
      return;
    }
    featchedData.forEach((orderId, orderData) {
      final order = OrderItem(
        id: orderId,
        amount: orderData['amount'],
        dateTime: DateTime.parse(orderData['dateTime']),
        products: (orderData['products'] as List<dynamic>)
            .map(
              (item) => CartItem(
                id: item['id'],
                title: item['title'],
                quantity: item['quantity'],
                price: item['price'],
              ),
            )
            .toList(),
      );
      loadedOrders.add(order);
    });
    _orders = loadedOrders.reversed.toList();
    notifyListeners();
  }

  Future<void> addItem({List<CartItem> cartProducts, double total}) async {
    final url = 'https://fluttershop-b14ae.firebaseio.com/orders.json';
    final timestamp = DateTime.now();
    try {
      final response = await http.post(url,
          body: json.encode({
            'amount': total,
            'dateTime': timestamp.toIso8601String(),
            'products': cartProducts
                .map((cp) => {
                      'id': cp.id,
                      'price': cp.price,
                      'quantity': cp.quantity,
                      'title': cp.title
                    })
                .toList()
          }));
      _orders.insert(
        0,
        OrderItem(
          id: json.decode(response.body)['name'],
          amount: total,
          products: cartProducts,
          dateTime: timestamp,
        ),
      );
      notifyListeners();
    } catch (error) {
      throw error;
    }
  }
}
