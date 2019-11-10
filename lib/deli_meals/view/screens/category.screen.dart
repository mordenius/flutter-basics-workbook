part of delimeals;

class CategoryScreen extends StatelessWidget {
  static const routeName = '/deli-meals/category';
  // final String categoryId;
  // final String categoryTitle;

  // CategoryScreen(this.categoryId, this.categoryTitle);

  List<Meal> _getMealsFromCategory(String categoryId) {
    return DUMMY_MEALS.where((Meal meal) {
      return meal.categories.contains(categoryId);
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    final routeArgs =
        ModalRoute.of(context).settings.arguments as Map<String, String>;
    final categoryTitle = routeArgs['title'];
    final categoryId = routeArgs['id'];

    final categoryMeals = _getMealsFromCategory(categoryId);

    return Scaffold(
      appBar: AppBar(
        title: Text("$categoryTitle Recipes"),
        backgroundColor: theme.primaryColor,
      ),
      body: ListView.builder(
        itemBuilder: (BuildContext context, int index) =>
            MealItem(categoryMeals[index]),
        itemCount: categoryMeals.length,
      ),
    );
  }
}
