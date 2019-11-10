part of delimeals;

class FilterScreen extends StatefulWidget {
  static final String routeName = '/deli-meals/filter';

  @override
  _FilterScreenState createState() => _FilterScreenState();
}

class _FilterScreenState extends State<FilterScreen> {
  Widget _buildSwitchTile(Filters filter) {
    Filter data = filterState.getFilter(filter);

    return SwitchListTile(
      title: Text(data.title),
      value: data.isEnable,
      subtitle: Text(data.subtitle),
      onChanged: (bool value) {
        setState(() {
          if (value) {
            data.enable();
          } else {
            data.disable();
          }
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: MainDrawer(),
      appBar: AppBar(
        title: Text('Filter!'),
        backgroundColor: theme.primaryColor,
      ),
      body: Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(20),
            child: Text(
              'Adjust your meal selection.',
              style: theme.textTheme.title,
            ),
          ),
          Expanded(
            child: ListView(
              children: <Widget>[
                _buildSwitchTile(Filters.isGlutenFree),
                _buildSwitchTile(Filters.isLactoseFree),
                _buildSwitchTile(Filters.isVegan),
                _buildSwitchTile(Filters.isVegetarian),
              ],
            ),
          )
        ],
      ),
    );
  }
}
