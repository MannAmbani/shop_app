import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/provider/products.dart';
import '../provider/product.dart';
import './product_item.dart';

class ProductsGrid extends StatelessWidget {
  // const ProductsGrid({
  //   Key key,
  //   @required this.loadedProducts,
  // }) : super(key: key);

  // final List<Product> loadedProducts;

  final bool showFavs;
  ProductsGrid(this.showFavs);

  @override
  Widget build(BuildContext context) {
    final productsData = Provider.of<Products>(context);
    final products = showFavs? productsData.favouriteItems : productsData.items;

    return GridView.builder(
        padding: const EdgeInsets.all(10.0),
        itemCount: products.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 3 / 2,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10),
        itemBuilder: (ctx, i) => ChangeNotifierProvider.value(//second way to provide without context
              value:  products[i],
              child: ProductItem(
                  // products[i].id, products[i].title, products[i].imageUrl
                  ),
            ));
  }
}
