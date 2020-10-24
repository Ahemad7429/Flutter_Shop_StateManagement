import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:shop_change_notifier_state/helpers/custom_route.dart';
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
          create: (context) => AuthProvider(),
        ),
        ChangeNotifierProxyProvider<AuthProvider, ProductsProvider>(
          create: null,
          update: (context, auth, previousProducts) => ProductsProvider(
            auth.userId,
            auth.token,
            previousProducts == null ? [] : previousProducts.items,
          ),
        ),
        ChangeNotifierProvider(
          create: (context) => CartProvider(),
        ),
        ChangeNotifierProxyProvider<AuthProvider, OrdersProvider>(
          create: null,
          update: (context, auth, previousOrders) => OrdersProvider(
            auth.userId,
            auth.token,
            previousOrders == null ? [] : previousOrders.orders,
          ),
        ),
      ],
      child: Consumer<AuthProvider>(
        builder: (cntx, auth, _) {
          return MaterialApp(
            title: 'Flutter State Management Demo',
            theme: ThemeData(
                primarySwatch: Colors.purple,
                accentColor: Colors.deepOrange,
                fontFamily: 'Lato',
                pageTransitionsTheme: PageTransitionsTheme(builders: {
                  TargetPlatform.android: CustomPageTransitionBuilder(),
                  TargetPlatform.iOS: CustomPageTransitionBuilder(),
                })),
            //home: ProductOverviewScreen(),
            routes: {
              '/': (ctx) => auth.isAuth
                  ? ProductOverviewScreen()
                  : FutureBuilder(
                      future: auth.tryAutoLogin(),
                      builder: (context, authResultSpanshot) =>
                          authResultSpanshot.connectionState ==
                                  ConnectionState.waiting
                              ? SplashScreen()
                              : AuthScreen(),
                    ),
              NavigationPath.productDetailScreen: (ctx) =>
                  ProductDetailScreen(),
              NavigationPath.cartScreen: (ctx) => CartScreen(),
              NavigationPath.orderScreen: (ctx) => OrdersScreen(),
              NavigationPath.userProductsScreen: (ctx) => UserProductsScreen(),
              NavigationPath.editProductScreen: (ctx) => EditProductScreen(),
            },
          );
        },
      ),
    );
  }
}
