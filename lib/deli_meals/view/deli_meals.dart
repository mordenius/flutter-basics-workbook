part of delimeals;

class DeliMeals extends StatefulWidget {
  @override
  _DeliMealsState createState() => _DeliMealsState();
}

class _DeliMealsState extends State<DeliMeals> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: CategoriesScreen(),
    );
  }
}
