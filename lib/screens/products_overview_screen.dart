import 'package:flutter/material.dart';
import 'package:shop_app/provider/cart.dart';
import '../widgets/product_grid.dart';
import 'package:provider/provider.dart';
import '../widgets/badge.dart';
import './cart_screen.dart';
import '../widgets/app_drawer.dart';

enum FilterOpions { Favourites, All }

class ProductsOverviewScreen extends StatefulWidget {
  @override
  State<ProductsOverviewScreen> createState() => _ProductsOverviewScreenState();
}

class _ProductsOverviewScreenState extends State<ProductsOverviewScreen> {
  var _showFavouritesOnly = false;

  @override
  Widget build(BuildContext context) {
    // final productContainer = Provider.of<Products>(context,listen: false);
    return Scaffold(
      appBar: AppBar(
        title: Text('MyShop'),
        actions: [
          PopupMenuButton(
            onSelected: (FilterOpions selectedValue) {
              setState(() {
                if (selectedValue == FilterOpions.Favourites) {
                  // productContainer.showFavouritesOnly();
                  _showFavouritesOnly = true;
                } else {
                  // productContainer.showAll();
                  _showFavouritesOnly = false;
                }
              });
            },
            icon: Icon(Icons.more_vert),
            itemBuilder: (_) => [
              PopupMenuItem(
                child: Text("Only Favourites"),
                value: FilterOpions.Favourites,
              ),
              PopupMenuItem(
                child: Text("Show all"),
                value: FilterOpions.All,
              ),
            ],
          ),
          Consumer<Cart>(
            builder: (_, cart, ch) => Badges(
              child: ch,
              value: 
                   cart.itemCount.toString(),
              
            ),
            child: IconButton(
              onPressed: () {
                Navigator.of(context).pushNamed(CartScreen.routeName);
              },
              icon: Icon(Icons.shopping_cart),
            ),
          ),
        ],
      ),
      drawer: AppDrawer(),
      body: ProductsGrid(_showFavouritesOnly), //loadedProducts: loadedProducts
    );
  }
}
