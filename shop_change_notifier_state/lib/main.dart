import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:shop_change_notifier_state/screens/orders_screen.dart';

import './providers/providers.dart';
import './config/config.dart';
import './screens/screens.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => ProductsProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => CartProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => OrdersProvider(),
        ),
      ],
      child: MaterialApp(
        title: 'Flutter State Management Demo',
        theme: ThemeData(
            primarySwatch: Colors.purple,
            accentColor: Colors.deepOrange,
            fontFamily: 'Lato'),
        //home: ProductOverviewScreen(),
        routes: {
          '/': (ctx) => ProductOverviewScreen(),
          NavigationPath.productDetailScreen: (ctx) => ProductDetailScreen(),
          NavigationPath.cartScreen: (ctx) => CartScreen(),
          NavigationPath.orderScreen: (ctx) => OrdersScreen(),
        },
      ),
    );
  }
}
