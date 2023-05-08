import 'package:flutter/material.dart';
import '../provider/product.dart';
import '../provider/products.dart';
import 'package:provider/provider.dart';

class EditProductScreen extends StatefulWidget {
  static const routeName = '/edit-product';

  @override
  State<EditProductScreen> createState() => _EditProductScreenState();
}

class _EditProductScreenState extends State<EditProductScreen> {
  final _priceFocusNode = FocusNode();
  final _descriptionFocusNode = FocusNode();

  final _imageUrlController =
      TextEditingController(); //to take the url from the text form field
  final _imageUrlFocusNode = FocusNode();

  final _form = GlobalKey<
      FormState>(); // to get direct access to form widget // also global key is used when you need to access widget outside the build
  var _editProduct = Product(
    id: null,
    title: '',
    description: '',
    imageUrl: '',
    price: 0,
  );

  var _initValues = {
    //add the products initially
    'title': '',
    'description': '',
    'price': '',
    'imageUrl': '',
  };

  @override
  void initState() {
    // TODO: implement initState
    _imageUrlFocusNode.addListener(_updateImageUrl);
    super.initState();
  }

  @override
  void dispose() {
    _imageUrlFocusNode.removeListener(_updateImageUrl);
    _priceFocusNode.dispose();
    _descriptionFocusNode.dispose();
    _imageUrlController.dispose();
    _imageUrlFocusNode.dispose();
    super.dispose();
  }

  var _isInit = true;

  @override
  void didChangeDependencies() {
    //runs before build is executed.
    if (_isInit) {
      final productId = ModalRoute.of(context).settings.arguments as String;
      if (productId != null) {
        _editProduct =
            Provider.of<Products>(context, listen: false).findById(productId);
        _initValues = {
          //add the products initially
          'title': _editProduct.title,
          'description': _editProduct.description,
          'price': _editProduct.price.toString(),
          'imageUrl': '',
        };
        _imageUrlController.text = _editProduct.imageUrl;
      }
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  void _updateImageUrl() {
    if (!_imageUrlFocusNode.hasFocus) {
      if ((!_imageUrlController.text.startsWith('http') &&
              !_imageUrlController.text.startsWith('https')) ||
          (!_imageUrlController.text.endsWith('.png') &&
              !_imageUrlController.text.endsWith('.jpg') &&
              !_imageUrlController.text.endsWith('.jpeg'))) {
        return;
      }

      setState(() {});
    }
  }

  void _saveForm() {
    final isValid = _form.currentState.validate();
    if (!isValid) {
      return;
    }
    _form.currentState
        .save(); //will trigger method on every text which allows you to take the value entered in text field and do what ever you want to do with it
    print(_editProduct.title);
    if(_editProduct.id != null){
      Provider.of<Products>(context,listen: false).updateProduct(_editProduct.id, _editProduct);
    }else{
    Provider.of<Products>(context, listen: false).addProduct(_editProduct);
    }
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Product'),
        actions: [IconButton(onPressed: _saveForm, icon: Icon(Icons.save))],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
            key: _form,
            child: ListView(
              children: [
                TextFormField(initialValue: _initValues['title'],
                  decoration: InputDecoration(labelText: 'Title'),
                  textInputAction: TextInputAction.next,
                  onFieldSubmitted: (_) {
                    FocusScope.of(context).requestFocus(_priceFocusNode);
                  },
                  onSaved: (value) {
                    _editProduct = Product(
                        id: _editProduct.id,
                        isFavourite: _editProduct.isFavourite,
                        title: value,
                        description: _editProduct.description,
                        imageUrl: _editProduct.imageUrl,
                        price: _editProduct.price);
                  },
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Please provide a value';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  initialValue: _initValues['price'],
                  decoration: InputDecoration(labelText: 'Price'),
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.number,
                  focusNode: _priceFocusNode,
                  onFieldSubmitted: (_) {
                    FocusScope.of(context).requestFocus(_descriptionFocusNode);
                  },
                  onSaved: (value) {
                    _editProduct = Product(
                       id: _editProduct.id,
                        isFavourite: _editProduct.isFavourite,
                        title: _editProduct.title,
                        description: _editProduct.description,
                        imageUrl: _editProduct.imageUrl,
                        price: double.parse(value));
                  },
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Please enter a price.';
                    }
                    if (double.tryParse(value) == null) {
                      return 'Please enter a Valid number.';
                    }
                    if (double.parse(value) <= 0) {
                      return 'Please enter a number greater than  zero';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  initialValue: _initValues['description'],
                  decoration: InputDecoration(labelText: 'Description'),
                  maxLines: 3,
                  keyboardType: TextInputType.multiline,
                  focusNode: _descriptionFocusNode,
                  onSaved: (value) {
                    _editProduct = Product(
                       id: _editProduct.id,
                        isFavourite: _editProduct.isFavourite,
                        title: _editProduct.title,
                        description: value,
                        imageUrl: _editProduct.imageUrl,
                        price: _editProduct.price);
                  },
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Please enter a description';
                    }
                    if (value.length < 10) {
                      return 'Should be atlease 10 character long';
                    }
                    return null;
                  },
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Container(
                      width: 100,
                      height: 100,
                      margin: EdgeInsets.only(top: 8, right: 10),
                      decoration: BoxDecoration(
                          border: Border.all(width: 1, color: Colors.grey)),
                      child: _imageUrlController.text.isEmpty
                          ? Text('Enter a URL')
                          : FittedBox(
                              child: Image.network(_imageUrlController.text),
                              fit: BoxFit.cover,
                            ),
                    ),
                    Expanded(
                      child: TextFormField(
                        // initialValue: _initValues['imageUrl'], // we can not initialise value when using controller    
                        decoration: InputDecoration(labelText: 'Image URL'),
                        keyboardType: TextInputType.url,
                        textInputAction: TextInputAction.done,
                        controller: _imageUrlController,
                        focusNode: _imageUrlFocusNode,
                        onFieldSubmitted: (_) {
                          _saveForm();
                        },
                        onSaved: (value) {
                          _editProduct = Product(
                            id: _editProduct.id,
                        isFavourite: _editProduct.isFavourite,
                              title: _editProduct.title,
                              description: _editProduct.description,
                              imageUrl: value,
                              price: _editProduct.price);
                        },
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Please enter an image URL';
                          }
                          if (!value.startsWith('http') &&
                              !value.startsWith('https')) {
                            return 'Please enter a valid URL';
                          }
                          if (!value.endsWith('.png') &&
                              !value.endsWith('.jpg') &&
                              !value.endsWith('.jpeg')) {
                            return 'Please enter a valid image URL';
                          }
                          return null;
                        },
                      ),
                    )
                  ],
                )
              ],
            )),
      ),
    );
  }
}
