import 'package:flutter/material.dart';
import 'package:flutter_app/screens/qrcodereader_screen.dart';
import 'package:provider/provider.dart';

//screens
import './screens/user_home_screen.dart';
import './screens/login_screen.dart';
import './screens/signup_screen.dart';
import './screens/splash_screen.dart';

//providers
import './providers/auth.dart';
import './providers/user.dart';
import './providers/robots.dart';

void main() {
  runApp(MyApp());
}

//dizendo que está  de acordo com o material design da google
//alt + shift + F : autoidentacao
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(
          value: Auth(),
        ),
        ChangeNotifierProxyProvider<Auth, User>(
          create: (_) => User(),
          update: (ctx, auth, previousUser) {
            //previousUser.userName = auth.userName;
            previousUser.userEmail = auth.userEmail;
            previousUser.userPassword = auth.userPassword;
            return previousUser;
          },
        ),
        ChangeNotifierProvider(
          create: (ctx) => Robots(),
        ),
      ],
      child: Consumer<Auth>(
        builder: (ctx, auth, _) => MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'FollowYolo',
          theme: ThemeData(
            primaryColor: Colors.blueGrey[900],
            accentColor: Colors.blueGrey[600],
          ),
          home: auth.isAuth
              ? UserHomeScreen()
              : FutureBuilder(
                  future: auth.tryAutoLogin(),
                  builder: (ctx, authResultSnapShot) =>
                      authResultSnapShot.connectionState ==
                              ConnectionState.waiting
                          ? SplashScreen()
                          : LoginScreen(),
                ),
          routes: {
            SignUpScreen.routeNate: (ctx) => SignUpScreen(),
            QRCodeReaderScreen.routeNate: (ctx) => QRCodeReaderScreen(),
          },
        ),
      ),
    );
  }
}
 
//pra comentar um bloco no mac os é cmd + c
//   propriedade mais importante é o home
//   runApp(
//     ChangeNotifierProvider(
//       create: (ctx) => Clients(),
//       child: MaterialApp(
//         routes: {
//           '/': (context) => LoginScreen(),
//           '/home': (context) => HomeScreen(),
//           '/signup': (context) => SignUpScreen(),
//         },

//         debugShowCheckedModeBanner: false, //importante!
//         initialRoute: '/',
//         //home: LoginScreen(),
//         //Grandle
//       ),
//     ),
//   );
// }
