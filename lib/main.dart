import 'package:challenge/consts/constants.dart';
import 'package:challenge/screens/home_screen.dart';
import 'package:challenge/screens/home_screen_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
  ));

  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (_) => HomeScreenProvider()),
  ], child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData(iconTheme: IconThemeData(color: white)),
        debugShowCheckedModeBanner: false,
        home: HomeScreen());
  }

  PreferredSizeWidget getAppBar() {
    return AppBar(
      elevation: 0,
      backgroundColor: blue,
      leading: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child:
            IconButton(onPressed: () {}, icon: FaIcon(FontAwesomeIcons.bars)),
      ),
      actions: [
        Center(
            child: Text(
          '1',
          style: TextStyle(fontSize: 20),
        )),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: IconButton(
              onPressed: () {}, icon: FaIcon(FontAwesomeIcons.heart)),
        ),
      ],
    );
  }
}
