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

  Future<void> appendToFavorite(String authToken, String userId) async {
    return _changeFavorite(true, authToken, userId);
  }

  Future<void> removeFromFavorite(String authToken, String userId) async {
    return _changeFavorite(false, authToken, userId);
  }

  Future<void> _changeFavorite(bool newState, String authToken, String userId) async {
    try {
      await _patch(newState, authToken, userId);
      isFavorite = newState;
    } catch (error) {} finally {
      notifyListeners();
    }
  }

  Future<void> _patch(bool newState, String authToken, String userId) async {
    final url =
        "https://flutter-basics-workbook.firebaseio.com/userFavorites/${userId}/${id}.json?auth=${authToken}";

    final String encodedProduct = json.encode({'isFavorite': newState});

    Response response = await put(url, body: encodedProduct);

    if (response.statusCode >= 400) {
      throw HttpException('Product not deleted');
    }
  }
}
