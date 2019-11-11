part of delimeals;

class FavoritesScreen extends StatefulWidget {
  @override
  _FavoritesScreenState createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> {
  void _removeFromFavorites(int index) {
    setState(() {
      favorites.remove(favorites.meals[index]);
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        width: double.infinity,
        height: 400,
        child: ListView.builder(
          itemCount: favorites.meals.length,
          itemBuilder: (BuildContext context, int index) => Column(
            children: <Widget>[
              MealItem(
                favorites.meals[index],
                () {},
              ),
              FlatButton(
                child: Icon(Icons.delete),
                onPressed: () {
                  _removeFromFavorites(index);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
