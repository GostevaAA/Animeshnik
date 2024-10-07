import 'package:animeshnik/presentation/profile/profile_screen.dart';
import 'package:animeshnik/presentation/search/search_screen.dart';
import 'package:animeshnik/presentation/title_updates/title_updates_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

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
        destinations: <Widget>[
          NavigationDestination(
              icon: SvgPicture.asset(
                'assets/icons/A.svg',
                height: 24,
                width: 24,
                colorFilter:
                    ColorFilter.mode(theme.primaryColor, BlendMode.srcIn),
              ),
              label: 'Главная'),
          NavigationDestination(
              icon: SvgPicture.asset(
                'assets/icons/Search.svg',
                height: 24,
                width: 24,
                colorFilter:
                    ColorFilter.mode(theme.primaryColor, BlendMode.srcIn),
              ),
              label: 'Поиск'),
          NavigationDestination(
              icon: SvgPicture.asset(
                'assets/icons/Profile.svg',
                height: 24,
                width: 24,
                colorFilter:
                    ColorFilter.mode(theme.primaryColor, BlendMode.srcIn),
              ),
              label: 'Профиль'),
        ],
      ),
    );
  }
}
