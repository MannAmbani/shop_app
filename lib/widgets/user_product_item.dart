import 'package:flutter/material.dart';
import '../screens/edit_product_screen.dart';
import 'package:provider/provider.dart';
import '../provider/products.dart';

class UserProductItem extends StatelessWidget {
  final String id;
  final String title;
  final String imageUrl;

  UserProductItem(this.id,this.title, this.imageUrl);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(title),
      leading: CircleAvatar(
        backgroundImage: NetworkImage(imageUrl), //AssetImage() can also be used but cant use Image.network or only image.  also here network image will fetch the image from url and pass it to Network image
      ),
      trailing: Container(width: 100,
        child: Row(children: [
          IconButton(onPressed: () {
            Navigator.of(context).pushNamed(EditProductScreen.routeName,arguments: id);
          }, icon: Icon(Icons.edit),color: Theme.of(context).primaryColor,),
          IconButton(onPressed: () {
            Provider.of<Products>(context,listen: false).deleteProducts(id);
          }, icon: Icon(Icons.delete),color: Theme.of(context).errorColor,),
        ],),
      ),
    );
  }
}
