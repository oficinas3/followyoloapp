import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:provider/provider.dart';

//screens
import './screens/user_home_screen.dart';
import './screens/login_screen.dart';
import './screens/qrcodereader_screen.dart';
import './screens/signup_screen.dart';
import './screens/splash_screen.dart';

//providers
import './providers/auth.dart';
import './providers/user.dart';
import './providers/rent.dart';
import 'screens/rentrobot.dart';
import './providers/robots.dart';

FlutterLocalNotificationsPlugin localNotifications;
void main() {
  WidgetsFlutterBinding
      .ensureInitialized(); //precisa pra funcinar as notificacoes
  var androidInitialize = new AndroidInitializationSettings('codex_logo');
  var iOSInitialize = new IOSInitializationSettings();
  var initializationSettings = new InitializationSettings(
      android: androidInitialize, iOS: iOSInitialize);
  localNotifications = new FlutterLocalNotificationsPlugin();
  localNotifications.initialize(initializationSettings);

  runApp(MyApp());
}

Future showNofitication(String robotid) async {
  var androidDetails = new AndroidNotificationDetails(
      'channelId', 'Local Notification', 'teste teste teste',
      importance: Importance.high);
  var iosDetails = new IOSNotificationDetails();
  var generalNotificationDetail =
      new NotificationDetails(android: androidDetails, iOS: iosDetails);
  await localNotifications.show(
      0,
      "Rent Started!",
      "Robot: " +
          robotid +
          " at " +
          DateFormat('kk:mm:ss (dd/MM/yyyy)').format(DateTime.now()),
      generalNotificationDetail);
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
        ChangeNotifierProvider(
          create: (ctx) => RentedRobot(),
        ),
        ChangeNotifierProvider(
          create: (ctx) => Rent(),
        )
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
