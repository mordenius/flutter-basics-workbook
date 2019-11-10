part of delimeals;

class MealScreen extends StatelessWidget {
  static const routeName = '/deli-meals/meal';

  Widget _buildSectionTitle(String title) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      child: Text(
        title,
        style: theme.textTheme.title,
        textAlign: TextAlign.left,
      ),
    );
  }

  Widget _buildSectionList(Widget child) {
    return Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(10),
        ),
        height: 150,
        width: double.infinity,
        margin: EdgeInsets.symmetric(horizontal: 20),
        padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
        child: child);
  }

  @override
  Widget build(BuildContext context) {
    final Meal meal = ModalRoute.of(context).settings.arguments as Meal;

    return Scaffold(
      appBar: AppBar(
        title: Text("Recipe"),
        backgroundColor: theme.primaryColor,
      ),
      body: SingleChildScrollView(
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
            _buildSectionTitle("Ingredients"),
            _buildSectionList(
              ListView.builder(
                itemCount: meal.ingredients.length,
                itemBuilder: (BuildContext context, int index) {
                  // return Text(index.toString());
                  return Text(meal.ingredients[index]);
                },
              ),
            ),
            _buildSectionTitle("Steps"),
            _buildSectionList(
              ListView.builder(
                itemCount: meal.steps.length,
                itemBuilder: (BuildContext context, int index) {
                  return ListTile(
                    leading: CircleAvatar(
                      child: Text(
                        '# ${(index + 1)}',
                        style: TextStyle(color: Colors.black),
                      ),
                      backgroundColor: theme.accentColor,
                    ),
                    title: Text(meal.steps[index]),
                  );
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(
          Icons.star_border,
          color: Colors.black,
        ),
        backgroundColor: theme.accentColor,
        onPressed: () {
          Navigator.of(context).pop(meal);
        },
      ),
    );
  }
}
