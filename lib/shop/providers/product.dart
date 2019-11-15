part of shop;

class Product with ChangeNotifier {
  final String id;
  final String title;
  final String description;
  final double price;
  final String imageUrl;

  bool isFavorite;

  Product({
    @required this.id,
    @required this.title,
    @required this.description,
    @required this.price,
    @required this.imageUrl,
    this.isFavorite = false,
  });

  Future<void> appendToFavorite() async {
    return _changeFavorite(true);
  }

  Future<void> removeFromFavorite() async {
    return _changeFavorite(false);
  }

  Future<void> _changeFavorite(bool newState) async {
    try {
      await _patch(newState);
      isFavorite = newState;
    } catch (error) {} finally {
      notifyListeners();
    }
  }

  Future<void> _patch(bool newState) async {
    final url =
        "https://flutter-basics-workbook.firebaseio.com/products/${id}.json";

    final String encodedProduct = json.encode({'isFavorite': newState});

    Response response = await patch(url, body: encodedProduct);

    if (response.statusCode >= 400) {
      throw HttpException('Product not deleted');
    }
  }
}
