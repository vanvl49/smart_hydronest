import 'package:flutter/material.dart';
import 'package:smart_hydronest/splash_screen.dart';
import 'home_screen.dart';
import 'pengaturan.dart';
import 'profil.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Smart HydroNest',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.green, fontFamily: 'Roboto'),
      home: HomeScreen(),
      // initialRoute: '/',
      // routes: {
      //   '/': (context) => HomeScreen(),
      //   '/profil': (context) => Profil(),
      //   '/pengaturan': (context) => Pengaturan(),
      // },
    );
  }
}
