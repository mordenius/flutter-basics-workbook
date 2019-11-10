part of delimeals;

class MealScreen extends StatelessWidget {
  static const routeName = '/deli-meals/meal';

  @override
  Widget build(BuildContext context) {
    final Meal meal = ModalRoute.of(context).settings.arguments as Meal;
    return Scaffold(
      appBar: AppBar(
        title: Text("Recipe"),
        backgroundColor: theme.primaryColor,
      ),
      body: Container(
        child: Column(
          children: [
            Image.network(
              meal.imageUrl,
              height: 250,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
            Container(
              width: double.infinity,
              color: theme.primaryColor,
              padding: EdgeInsets.symmetric(vertical: 12, horizontal: 20),
              child: Text(
                meal.title,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
                softWrap: true,
                overflow: TextOverflow.fade,
                textAlign: TextAlign.right,
              ),
            ),
          ],
        ),
      ),
      // body: ListView.builder(
      //   itemBuilder: (BuildContext context, int index) =>
      //       MealItem(categoryMeals[index]),
      //   itemCount: categoryMeals.length,
      // ),
    );
  }
}
