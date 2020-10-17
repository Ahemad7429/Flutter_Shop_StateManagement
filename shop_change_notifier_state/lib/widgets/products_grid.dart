import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_change_notifier_state/widgets/widgets.dart';
import '../providers/providers.dart';

class ProductsGrid extends StatelessWidget {
  final bool isFavoriteOnly;

  const ProductsGrid({
    Key key,
    @required this.isFavoriteOnly,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final productsData = Provider.of<ProductsProvider>(context);
    final products =
        isFavoriteOnly ? productsData.favoriteItemsOnly : productsData.items;

    return GridView.builder(
      padding: const EdgeInsets.all(10),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 1.5,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
      itemBuilder: (ctx, index) {
        return ChangeNotifierProvider.value(
          value: products[index],
          child: ProductItem(),
        );
      },
      itemCount: products.length,
    );
  }
}
