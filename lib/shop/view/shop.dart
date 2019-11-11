part of shop;

class Shop extends StatelessWidget {
  static final String routeName = '/shop';

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      builder: (BuildContext context) => Products(),
      child: ProductOverviewScreen(),
    );
  }
}
