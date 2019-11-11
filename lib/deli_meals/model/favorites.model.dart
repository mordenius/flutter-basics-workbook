part of delimeals;

class Favorites {
  final List<Meal> _favorites = [];

  void add(Meal meal) {
    _favorites.add(meal);
  }

  void remove(Meal meal) {
    _favorites.remove(meal);
  }

  void reset() {
    _favorites.clear();
  }

  List<Meal> get meals {
    return _favorites;
  }
}

Favorites favorites = Favorites();
