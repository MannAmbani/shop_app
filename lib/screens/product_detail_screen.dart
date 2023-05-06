import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../provider/product_provider.dart';

class ProductDetailScreen extends StatelessWidget {
  // final String title;

  // ProductDetailScreen(this.title);
  static const routeName = '/product-detail';

  @override
  Widget build(BuildContext context) {
    final productId = ModalRoute.of(context).settings.arguments as String;
    final loadedItem = Provider.of<Products>(context).findById(productId);
    return Scaffold(
      appBar: AppBar(
        title: Text(loadedItem.title),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 300,
              width: double.infinity,
              child: Image.network(
                loadedItem.imageUrl,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(height: 10,),
            Text('₹ ${loadedItem.price}',style: TextStyle(color:Colors.grey,fontSize: 20,),),
            SizedBox(height: 10,),
            Container(width: double.infinity,padding: EdgeInsets.symmetric(horizontal: 10),child: Text(loadedItem.description,textAlign: TextAlign.center,softWrap: true,))
          ],
        ),
      ),
    );
  }
}
