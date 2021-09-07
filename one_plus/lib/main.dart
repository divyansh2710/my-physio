import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:my_physio/Providers/Services.dart';
import 'package:my_physio/Providers/centres.dart';
import 'package:my_physio/Providers/doctors.dart';
import 'package:my_physio/auth.dart';
import 'package:my_physio/auth_screen.dart';
import 'package:my_physio/constants/Appointments.dart';
import 'package:my_physio/homePage.dart';
import 'package:my_physio/splash_screen.dart';
import 'package:provider/provider.dart';

import 'package:firebase_core/firebase_core.dart';
void main() {
   WidgetsFlutterBinding.ensureInitialized();
   Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(
          value: Auth(),
        ),
        ChangeNotifierProvider.value(
          value: CentreProvider(),
        ),
        ChangeNotifierProvider.value(
          value: DoctorProvider(),
        ),
        ChangeNotifierProvider.value(
          value: ServicesProvider(),
        ),
        ChangeNotifierProxyProvider<Auth, Appointments>(
          update: (ctx, auth, previousProducts) => Appointments(
                auth.token,
                auth.userId
              ),
              create: (ctx)=> Appointments('',''),
        )
      ],
      child: Consumer<Auth>(
        builder: (ctx, auth, _) => MaterialApp(
              title: 'MyPhysio',
              theme: ThemeData(
                primarySwatch: Colors.blue,
                accentColor: Colors.amber
              ),
              home: auth.isAuth
                  ? HomePage()
                  : FutureBuilder(
                      future: auth.tryAutoLogin(),
                      builder: (ctx, authResultSnapshot) =>
                          authResultSnapshot.connectionState ==
                                  ConnectionState.waiting
                              ? SplashScreen()
                              : AuthScreen(),
                    ),
            ),
      ),
    );
  }
}
