import 'package:flutter/material.dart';
import 'product.dart';

class Products with ChangeNotifier{ //with refers as mixins (inheritense lite) and 
                                  //ChangeNotifier is a simple widget which allow us to establish behind the scenes communication tunnels with the help of context object
  List<Product> _items = [
    Product(
      id: 'p1',
      title: 'Red Shirt',
      description: 'A red shirt - it is pretty red!',
      price: 29.99,
      imageUrl:
          'https://cdn.pixabay.com/photo/2016/10/02/22/17/red-t-shirt-1710578_1280.jpg',
    ),
    Product(
      id: 'p2',
      title: 'Trousers',
      description: 'A nice pair of trousers.',
      price: 59.99,
      imageUrl:
          'https://upload.wikimedia.org/wikipedia/commons/thumb/e/e8/Trousers%2C_dress_%28AM_1960.022-8%29.jpg/512px-Trousers%2C_dress_%28AM_1960.022-8%29.jpg',
    ),
    Product(
      id: 'p3',
      title: 'Yellow Scarf',
      description: 'Warm and cozy - exactly what you need for the winter.',
      price: 19.99,
      imageUrl:
          'https://live.staticflickr.com/4043/4438260868_cc79b3369d_z.jpg',
    ),
    Product(
      id: 'p4',
      title: 'A Pan',
      description: 'Prepare any meal you want.',
      price: 49.99,
      imageUrl:
          'https://upload.wikimedia.org/wikipedia/commons/thumb/1/14/Cast-Iron-Pan.jpg/1024px-Cast-Iron-Pan.jpg',
    ),
  ];

// var _showFavouritesOnly = false;

  List<Product> get favouriteItems{
    return _items.where((prodItems) => prodItems.isFavourite).toList();
  }

  List<Product> get items {
    // if(_showFavouritesOnly){
    //   return _items.where((prodItem) => prodItem.isFavourite).toList();
    // }
    return [..._items]; // will return copy of items using spread operator '...' 
                        //so that we can not directly edit the _items list and the widgets depend on _items wont change as the list would not directly change
  }

  // void showFavouritesOnly(){
  //   _showFavouritesOnly = true;
  //   notifyListeners();
  // }

  // void showAll(){
  //   _showFavouritesOnly = false;
  //   notifyListeners();
  // }

  Product findById(String id){
    return _items.firstWhere((prod) => prod.id == id);
  }

  void addProduct(Product product){
    // _items.add(value);
    final newProduct = Product(title: product.title,description: product.description,price: product.price,imageUrl: product.imageUrl,id: DateTime.now().toString());
    _items.add(newProduct);
    // _items.insert(0, newProduct); // at the start of the list
    notifyListeners();// notifies the listeners when item change
  }

  void updateProduct(String id,Product newProduct){
    final prodIndex = _items.indexWhere((prod) => prod.id == id);
    if(prodIndex >= 0){
    _items[prodIndex] = newProduct;
    notifyListeners();
    }else{
      print('....');
    }
  }

  void deleteProducts(String id){
    _items.removeWhere((prodId) => prodId.id == id);
    notifyListeners();
  }
}