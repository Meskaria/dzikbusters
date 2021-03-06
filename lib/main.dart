import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'screens/report_a_boar.dart';
import 'screens/auth_screen.dart';
import 'screens/to_do_after_screen.dart';
import 'screens/dashboard.dart';
import 'screens/splash_screen.dart';
import 'screens/preview_map_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Future<FirebaseApp> _initialization = Firebase.initializeApp();
    return FutureBuilder(
        // Initialize FlutterFire:
        future: _initialization,
        builder: (context, appSnapshot) {
          return  MaterialApp(
                  title: 'Report a boar',
                  theme: ThemeData(
                    primarySwatch: Colors.green,
                    backgroundColor: Colors.green,
                    accentColor: Colors.orange,
                    accentColorBrightness: Brightness.dark,
                    buttonTheme: ButtonTheme.of(context).copyWith(
                      buttonColor: Colors.pink,
                      textTheme: ButtonTextTheme.primary,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                    colorScheme: ColorScheme.light(
                      primary: Colors.orange,
                      secondary: Colors.green,
                    )
                  ),
                  home: appSnapshot.connectionState != ConnectionState.done
                      ? SplashScreen()
                      : StreamBuilder(
                          stream: FirebaseAuth.instance.authStateChanges(),
                          builder: (ctx, userSnapshot) {
                            if (userSnapshot.connectionState ==
                                ConnectionState.waiting) {
                              return SplashScreen();
                            }
                            if (userSnapshot.hasData) {
                              return Dashboard();
                            }
                            return AuthScreen();
                          }),
                  routes: {
                    ReportABoar.routeName: (ctx) => ReportABoar(),
                    PreviewMapScreen.routeName: (ctx) => PreviewMapScreen(),
                    ToDoAfter.routeName: (ctx) => ToDoAfter(),
                    Dashboard.routeName: (ctx) => Dashboard(),
                  });
        });
  }
}

