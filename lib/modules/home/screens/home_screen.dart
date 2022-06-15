import 'package:flutter/material.dart';
import 'package:movie_db/modules/home/screens/about_me_screen.dart';
import 'package:movie_db/modules/home/screens/discovery_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int activeIndex = 0;
  List<Widget> screens = const [
    DiscoveryScreen(),
    AboutMeScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text('MovieDB (Require Internet Connection )'),
      ),
      bottomNavigationBar: _navigationBar,
      body: screens[activeIndex],
    );
  }

  NavigationBar get _navigationBar {
    return NavigationBar(
      selectedIndex: activeIndex,
      onDestinationSelected: (id) {
        if (mounted) {
          setState(() => activeIndex = id);
        }
      },
      destinations: <NavigationDestination>[
        NavigationDestination(
          icon: Icon(activeIndex == 0 ? Icons.home_rounded : Icons.home_outlined),
          label: 'Discover',
        ),
        NavigationDestination(
          icon: Icon(activeIndex == 1 ? Icons.person_rounded : Icons.person_outline_rounded),
          label: 'About Me',
        ),
      ],
    );
  }
}
