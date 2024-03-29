part of delimeals;

ThemeData theme = ThemeData(
    primarySwatch: Colors.pink,
    accentColor: Colors.amber,
    canvasColor: Color.fromARGB(1, 255, 254, 229),
    fontFamily: 'Raleway',
    textTheme: ThemeData.light().textTheme.copyWith(
          body1: TextStyle(color: Color.fromARGB(20, 51, 51, 1)),
          body2: TextStyle(color: Color.fromARGB(20, 51, 51, 1)),
          title: TextStyle(
              fontSize: 24,
              fontFamily: 'RobotoCondensed',
              fontWeight: FontWeight.bold),
        ));
