part of delimeals;

class FilterScreen extends StatelessWidget {
  static final String routeName = '/deli-meals/filter';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: MainDrawer(),
      appBar: AppBar(
        title: Text('Filter!'),
        backgroundColor: theme.primaryColor,
      ),
    );
  }
}
