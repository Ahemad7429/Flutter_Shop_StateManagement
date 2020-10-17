import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../config/config.dart';
import '../providers/providers.dart';
import '../widgets/widgets.dart';

enum FilterOptions { favorites, all }

class ProductOverviewScreen extends StatefulWidget {
  @override
  _ProductOverviewScreenState createState() => _ProductOverviewScreenState();
}

class _ProductOverviewScreenState extends State<ProductOverviewScreen> {
  bool _isFavoritesOnly = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: AppDrawer(),
      appBar: AppBar(
        title: Text('MyShop'),
        actions: [
          PopupMenuButton(
            icon: Icon(Icons.more_vert),
            onSelected: (value) {
              setState(() {
                if (value == FilterOptions.all) {
                  _isFavoritesOnly = false;
                } else if (value == FilterOptions.favorites) {
                  _isFavoritesOnly = true;
                }
              });
            },
            itemBuilder: (ctx) => [
              PopupMenuItem(
                child: Text('Only Favorites'),
                value: FilterOptions.favorites,
              ),
              PopupMenuItem(
                child: Text('Show All'),
                value: FilterOptions.all,
              ),
            ],
          ),
          Consumer<CartProvider>(
            builder: (_, cartObj, ch) {
              return Badge(
                value: cartObj.itemsCount.toString(),
                child: ch,
              );
            },
            child: IconButton(
              icon: Icon(Icons.shopping_cart),
              onPressed: () {
                Navigator.of(context).pushNamed(NavigationPath.cartScreen);
              },
            ),
          )
        ],
      ),
      body: ProductsGrid(
        isFavoriteOnly: _isFavoritesOnly,
      ),
    );
  }
}
