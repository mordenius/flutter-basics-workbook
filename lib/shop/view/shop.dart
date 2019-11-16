part of shop;

class Shop extends StatelessWidget {
  static final String routeName = '/shop';

  @override
  Widget build(BuildContext context) {
    Auth auth = Provider.of<Auth>(context);
    return auth.isAuth
        ? ProductOverviewScreen()
        : FutureBuilder(
            future: auth.tryAutoLogin(),
            builder: (ctx, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return SplashScreen();
              }

              return AuthScreen();
            });
  }
}
