import 'package:flutter/material.dart';
import 'package:intuitive_design/intuitive.dart';
import 'package:movie_db/modules/home/screens/home_screen.dart';

void main() => runApp(const _App());

class _App extends StatelessWidget {
  const _App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MovieDB',
      home: IntuitiveSplash(
        logoTitle: 'Baharudin Yusup',
        icon: const Icon(Icons.code_rounded),
        function: () async {
          await Future.delayed(const Duration(seconds: 2));
          return const HomeScreen();
        },
        footerTitle: 'Sebuah aplikasi yang ditujukan untuk',
        footerIcon: Image.network(
          'https://www.dicoding.com/blog/wp-content/uploads/2014/12/dicoding-header-logo-1.png',
          height: 15,
          fit: BoxFit.fitHeight,
        ),
      ),
      theme: ThemeData(
        fontFamily: 'Urbanist',
        floatingActionButtonTheme: const FloatingActionButtonThemeData(
          backgroundColor: Color(0xff141414),
        ),
        appBarTheme: const AppBarTheme(backgroundColor: Colors.black),
        scaffoldBackgroundColor: Colors.black,
        navigationBarTheme: NavigationBarThemeData(
          backgroundColor: const Color(0xff141414),
          indicatorColor: Colors.black54,
          labelTextStyle:
              MaterialStateProperty.all<TextStyle>(const TextStyle(color: Colors.white)),
          iconTheme: MaterialStateProperty.all<IconThemeData>(
            const IconThemeData(color: Colors.white),
          ),
        ),
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}
