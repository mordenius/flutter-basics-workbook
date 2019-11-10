part of delimeals;

enum Filters { isGlutenFree, isLactoseFree, isVegan, isVegetarian }

class Filter {
  final String title;
  final String subtitle;
  bool _state;

  Filter(this.title, this.subtitle) {
    _state = false;
  }

  bool get isEnable {
    return _state;
  }

  void enable() {
    _state = true;
  }

  void disable() {
    _state = false;
  }
}

class FilterState {
  Filter _isGlutenFree;
  Filter _isLactoseFree;

  Filter _isVegan;
  Filter _isVegetarian;

  FilterState() {
    _isGlutenFree = Filter('Gluten-free', 'Only include gluten-free meals.');
    _isLactoseFree = Filter('Lactose-free', 'Only include lactose-free meals.');
    _isVegan = Filter('Vegan', 'Only include vegan meals.');
    _isVegetarian = Filter('Vegetarian', 'Only include vegetarian meals.');
  }

  Filter getFilter(Filters filter) {
    switch (filter) {
      case Filters.isGlutenFree:
        return _isGlutenFree;
      case Filters.isLactoseFree:
        return _isLactoseFree;
      case Filters.isVegan:
        return _isVegan;
      case Filters.isVegetarian:
        return _isVegetarian;
      default:
        return null;
    }
  }
}

FilterState filterState = FilterState();
