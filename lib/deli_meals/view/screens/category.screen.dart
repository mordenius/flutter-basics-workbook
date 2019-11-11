part of delimeals;

class CategoryScreen extends StatefulWidget {
  static const routeName = '/deli-meals/category';

  @override
  _CategoryScreenState createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  String categoryTitle;
  List<Meal> desplayedMeals;
  bool _isInitDataLoad = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_isInitDataLoad) return;
    final routeArgs =
        ModalRoute.of(context).settings.arguments as Map<String, String>;
    categoryTitle = routeArgs['title'];
    final categoryId = routeArgs['id'];

    desplayedMeals = _getMealsFromCategory(categoryId);
    _isInitDataLoad = true;
  }

  void _removeMeal(Meal meal) {
    setState(() {
      desplayedMeals.remove(meal);
    });
  }

  List<Meal> _getMealsFromCategory(String categoryId) {
    return DUMMY_MEALS.where((Meal meal) {
      if (filterState.getFilter(Filters.isGlutenFree).isEnable &&
          !meal.isGlutenFree) {
        return false;
      }

      if (filterState.getFilter(Filters.isLactoseFree).isEnable &&
          !meal.isLactoseFree) {
        return false;
      }

      if (filterState.getFilter(Filters.isVegan).isEnable && !meal.isVegan) {
        return false;
      }

      if (filterState.getFilter(Filters.isVegetarian).isEnable &&
          !meal.isVegetarian) {
        return false;
      }

      return meal.categories.contains(categoryId);
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("$categoryTitle Recipes"),
        backgroundColor: theme.primaryColor,
      ),
      body: ListView.builder(
        itemBuilder: (BuildContext context, int index) =>
            MealItem(desplayedMeals[index], _removeMeal),
        itemCount: desplayedMeals.length,
      ),
    );
  }
}
