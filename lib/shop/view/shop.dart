part of shop;

class Shop extends StatelessWidget {
  static final String routeName = '/shop';

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: Products()),
        ChangeNotifierProvider.value(value: Cart()),
      ],
      child: ProductOverviewScreen(),
    );
  }
}
