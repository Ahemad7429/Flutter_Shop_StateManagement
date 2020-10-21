import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../config/config.dart';
import '../widgets/widgets.dart';
import '../providers/providers.dart';

class UserProductsScreen extends StatelessWidget {
  Future<void> _refreshUserProducts(context) async {
    await Provider.of<ProductsProvider>(context, listen: false)
        .fetchAndSetProducts();
  }

  @override
  Widget build(BuildContext context) {
    final productData = Provider.of<ProductsProvider>(context);
    return Scaffold(
      drawer: AppDrawer(),
      appBar: AppBar(
        title: const Text('Your products'),
        actions: [
          IconButton(
              icon: const Icon(Icons.add),
              onPressed: () {
                Navigator.of(context)
                    .pushNamed(NavigationPath.editProductScreen);
              })
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () => _refreshUserProducts(context),
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: ListView.builder(
            itemCount: productData.items.length,
            itemBuilder: (ctx, index) {
              return Column(
                children: [
                  UserProductItem(
                    productId: productData.items[index].id,
                    title: productData.items[index].title,
                    imageUrl: productData.items[index].imageUrl,
                  ),
                  Divider(),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
