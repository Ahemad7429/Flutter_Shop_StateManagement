import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_change_notifier_state/helpers/custom_route.dart';
import 'package:shop_change_notifier_state/providers/providers.dart';
import 'package:shop_change_notifier_state/screens/orders_screen.dart';
import '../config/config.dart';

class AppDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          AppBar(
            title: Text(
              'Hello, AhemadAbbas',
            ),
            iconTheme: new IconThemeData(color: Theme.of(context).accentColor),
            automaticallyImplyLeading: false,
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.shop),
            title: Text('Shop'),
            onTap: () {
              Navigator.of(context).pushReplacementNamed('/');
            },
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.payment),
            title: Text('Orders'),
            onTap: () {
              // Navigator.of(context).pushReplacement(
              //     CustomRoute(builder: (ctx) => OrdersScreen()));
              Navigator.of(context)
                  .pushReplacementNamed(NavigationPath.orderScreen);
            },
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.edit),
            title: Text('User Products'),
            onTap: () {
              Navigator.of(context)
                  .pushReplacementNamed(NavigationPath.userProductsScreen);
            },
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.exit_to_app),
            title: Text('Logout'),
            onTap: () {
              Navigator.of(context).pop();
              Navigator.of(context).pushReplacementNamed('/');
              Provider.of<AuthProvider>(context, listen: false).logout();
            },
          )
        ],
      ),
    );
  }
}
