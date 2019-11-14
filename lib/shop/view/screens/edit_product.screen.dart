part of shop;

class EditProductScreen extends StatefulWidget {
  static final String routeName = '/shop/user-products/edit';

  @override
  _EditProductScreenState createState() => _EditProductScreenState();
}

class _EditProductScreenState extends State<EditProductScreen> {
  final _priceFocusNode = FocusNode();
  final _descriptionFocusNode = FocusNode();
  final _imageFocusNode = FocusNode();
  final _imageUrlController = TextEditingController();
  final _form = GlobalKey<FormState>();

  var _isInit = true;

  var _initValues = {
    'id': null,
    'title': '',
    'description': '',
    'price': '',
    'imageUrl': ''
  };

  @override
  void initState() {
    _imageFocusNode.addListener(_updateImageUrl);
    super.initState();
  }

  @override
  void didChangeDependencies() {
    if (_isInit) {
      Product _product = ModalRoute.of(context).settings.arguments;
      if (_product != null) {
        _initValues = {
          'title': _product.title,
          'description': _product.description,
          'price': _product.price.toString(),
          'imageUrl': '',
          'id': _product.id
        };

        _imageUrlController.text = _product.imageUrl;
      }
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _imageFocusNode.removeListener(_updateImageUrl);
    _priceFocusNode.dispose();
    _descriptionFocusNode.dispose();
    _imageFocusNode.dispose();
    _imageUrlController.dispose();
    super.dispose();
  }

  String _imageUrlValidate(final String value) {
    if (value.isEmpty) {
      return 'Please enter a image URL.';
    }

    if (!value.startsWith('http')) {
      return 'Please enter a valid URL.';
    }

    for (final String ext in ['.png', '.jpg', '.jpeg']) {
      if (value.endsWith(ext)) return null;
    }

    return 'Please choose only png, jpg or jpeg.';

    // Regex example
    // var urlPattern = r"(https?|ftp)://([-A-Z0-9.]+)(/[-A-Z0-9+&@#/%=~_|!:,.;]*)?(\?[A-Z0-9+&@#/%=~_|!:‌​,.;]*)?";
    // var result = new RegExp(urlPattern, caseSensitive: false).firstMatch(value);
  }

  bool _imageInputNotFocusedOrHasInvalidValue() {
    return _imageUrlValidate(_imageUrlController.text) == null ||
        _imageFocusNode.hasFocus;
  }

  void _updateImageUrl() {
    if (_imageInputNotFocusedOrHasInvalidValue()) {
      return;
    }

    _initValues['imageUrl'] = _imageUrlController.text;

    setState(() {});
  }

  void _saveForm() {
    final bool isValid = _form.currentState.validate();

    if (!isValid) {
      return;
    }

    _form.currentState.save();

    Products products = Provider.of<Products>(context);

    Product product = Product(
      id: DateTime.now().toString(),
      title: _initValues['title'],
      description: _initValues['description'],
      price: double.parse(_initValues['price']),
      imageUrl: _imageUrlController.text,
      isFavorite: false,
    );

    if (_initValues['id'] != null) {
      products.updateProductById(_initValues['id'], product);
    } else {
      products.addProduct(product);
    }

    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Product'),
        actions: <Widget>[
          IconButton(icon: Icon(Icons.save), onPressed: _saveForm),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _form,
          child: ListView(
            children: <Widget>[
              TextFormField(
                initialValue: _initValues['title'],
                decoration: InputDecoration(labelText: 'Title'),
                textInputAction: TextInputAction.next,
                onFieldSubmitted: (String value) {
                  _initValues['title'] = value;
                  FocusScope.of(context).requestFocus(_priceFocusNode);
                },
                validator: (final String value) {
                  if (value.isEmpty) {
                    return 'Please enter a title.';
                  }

                  return null;
                },
              ),
              TextFormField(
                initialValue: _initValues['price'],
                decoration: InputDecoration(labelText: 'Price'),
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.numberWithOptions(decimal: true),
                focusNode: _priceFocusNode,
                onFieldSubmitted: (String value) {
                  _initValues['price'] = value;
                  FocusScope.of(context).requestFocus(_descriptionFocusNode);
                },
                validator: (final String value) {
                  if (value.isEmpty) {
                    return 'Please enter a price.';
                  }

                  if (double.tryParse(value) == null) {
                    return 'Please enter a valid number.';
                  }

                  if (double.parse(value) <= 0) {
                    return 'Please enter a number greater than zero.';
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
                onFieldSubmitted: (String value) {
                  _initValues['description'] = value;
                  FocusScope.of(context).requestFocus(_imageFocusNode);
                },
                validator: (final String value) {
                  if (value.isEmpty) {
                    return 'Please enter a description.';
                  }

                  if (value.length < 10) {
                    return 'Should be at least 10 characters long.';
                  }

                  return null;
                },
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  Container(
                    height: 100,
                    width: 100,
                    margin: EdgeInsets.only(
                      top: 8,
                      right: 10,
                    ),
                    decoration: BoxDecoration(
                      border: Border.all(
                        width: 1,
                        color: Colors.grey,
                      ),
                    ),
                    child: _imageUrlController.text.isEmpty
                        ? Text('Enter a URL')
                        : FittedBox(
                            child: Image.network(
                              _imageUrlController.text,
                              fit: BoxFit.cover,
                            ),
                          ),
                  ),
                  Expanded(
                    child: TextFormField(
                      decoration: InputDecoration(labelText: 'Image URL'),
                      keyboardType: TextInputType.url,
                      textInputAction: TextInputAction.done,
                      controller: _imageUrlController,
                      focusNode: _imageFocusNode,
                      onFieldSubmitted: (_) {
                        _saveForm();
                      },
                      validator: _imageUrlValidate,
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
