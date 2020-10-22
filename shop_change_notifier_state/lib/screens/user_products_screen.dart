import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../config/config.dart';
import '../widgets/widgets.dart';
import '../providers/providers.dart';

class UserProductsScreen extends StatelessWidget {
  Future<void> _refreshUserProducts(context) async {
    await Provider.of<ProductsProvider>(context, listen: false)
        .fetchAndSetProducts(true);
  }

  @override
  Widget build(BuildContext context) {
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
      body: FutureBuilder(
        future: _refreshUserProducts(context),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          if (snapshot.error != null) {
            return Center(
              child: Text(snapshot.error),
            );
          }

          return RefreshIndicator(
            onRefresh: () => _refreshUserProducts(context),
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: Consumer<ProductsProvider>(
                builder: (_, productData, ch) => ListView.builder(
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
        },
      ),
    );
  }
}
