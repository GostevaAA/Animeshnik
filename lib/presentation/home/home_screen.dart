import 'package:animeshnik/presentation/profile/profile_screen.dart';
import 'package:animeshnik/presentation/search/search_screen.dart';
import 'package:animeshnik/presentation/title_updates/title_updates_screen.dart';
import 'package:animeshnik/ui/widgets/svg_item_themed.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<StatefulWidget> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final PageController _pageController = PageController();

  int _selectedIndex = 0;
  final List<Widget> _pages = <Widget>[
    const TitleUpdatesScreen(),
    const SearchScreen(),
    const ProfileScreen(),
  ];

  void _onItemTapped(int index) {
    if (_selectedIndex != index) {
      _pageController.jumpToPage(index);
      setState(() {
        _selectedIndex = index;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      body: PageView(
        controller: _pageController,
        onPageChanged: _onItemTapped,
        children: _pages,
      ),
      bottomNavigationBar: NavigationBar(
        onDestinationSelected: _onItemTapped,
        selectedIndex: _selectedIndex,
        labelBehavior: NavigationDestinationLabelBehavior.onlyShowSelected,
        destinations: <Widget>[
          NavigationDestination(
              icon: SvgIconThemed('assets/icons/A.svg'), label: 'Главная'),
          NavigationDestination(icon: Icon(Icons.search), label: 'Поиск'),
          NavigationDestination(icon: Icon(Icons.person), label: 'Профиль'),
        ],
      ),
    );
  }
}
