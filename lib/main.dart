import 'package:flutter/material.dart';
import 'package:flutter_app/providers/clients.dart';
import 'package:provider/provider.dart';

import 'screens/home.dart';
import 'screens/login.dart';
import 'screens/signup.dart';

void main() {
  //runApp(MyApp());

  //dizendo que está  de acordo com o material design da google
  //alt + shift + F : autoidentacao

  //propriedade mais importante é o home
  runApp(
    ChangeNotifierProvider(
      create: (ctx) => Clients(),
      child: MaterialApp(
        routes: {
          '/': (context) => LoginScreen(),
          '/home': (context) => HomeScreen(),
          '/signup': (context) => SignUpScreen(),
        },

        debugShowCheckedModeBanner: false, //importante!
        initialRoute: '/',
        //home: LoginScreen(),
        //Grandle
      ),
    ),
  );
}
