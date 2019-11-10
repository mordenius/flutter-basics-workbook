part of delimeals;

class TabsScreen extends StatefulWidget {
  @override
  _TabsScreenState createState() => _TabsScreenState();
}

class Page {
  final Widget page;
  final String title;

  Page(this.page, this.title);
}

class _TabsScreenState extends State<TabsScreen> {
 final List<Page> _pages = [
    Page(CategoriesScreen(), 'Categories'),
    Page(FavoritesScreen(), 'Your Favorites')
  ];

  int _selectedPageIndex = 0;

  void _selectPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      initialIndex: 0,
      child: Scaffold(
          appBar: AppBar(
            backgroundColor: theme.primaryColor,
            title: Text(_pages[_selectedPageIndex].title),
            bottom: TabBar(
              tabs: <Widget>[
                const Tab(icon: Icon(Icons.category), text: "Categories"),
                const Tab(icon: Icon(Icons.favorite), text: "Favorites")
              ],
            ),
          ),
          bottomNavigationBar: BottomNavigationBar(
              onTap: _selectPage,
              backgroundColor: theme.primaryColor,
              unselectedItemColor: Colors.white70,
              selectedItemColor: Colors.white,
              currentIndex: _selectedPageIndex,
              items: [
               const BottomNavigationBarItem(
                  icon: const Icon(Icons.category),
                  title: const Text('Categories'),
                ),
               const BottomNavigationBarItem(
                  icon: const Icon(Icons.star),
                  title: const Text("Favorites"),
                )
              ]),
          body: _pages[_selectedPageIndex].page
          // body: TabBarView(
          //   children: <Widget>[
          //     CategoriesScreen(),
          //     FavoritesScreen(),
          //   ],
          // ),
          ),
    );
  }
}
