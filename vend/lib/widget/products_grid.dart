

import 'package:flutter/material.dart';
import 'package:vend/providers/products.dart';
import '../widget/product_item.dart';
import 'package:provider/provider.dart';

class ProductsGrid extends StatelessWidget {
  final bool showFavs;
  ProductsGrid(this.showFavs);
 
  @override
  Widget build(BuildContext context) {
    final productData = Provider.of<Products>(context);
    final products = showFavs ? productData.favoriteItems : productData.items;
    return GridView.builder(
      padding: const EdgeInsets.all(10.0),
      itemCount: products.length,
      itemBuilder:(ctx, i) => ChangeNotifierProvider.value(
        value: products[i],
        child: ProductItem(
          //products[i].id,
          //products[i].tittle,
          //products[i].imageUrl,
          ),
      ),
      gridDelegate:SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2, 
        childAspectRatio: 3 / 2, 
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        ),
    );
  }
}