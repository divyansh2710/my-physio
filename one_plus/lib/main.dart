import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:my_physio/Providers/Services.dart';
import 'package:my_physio/Providers/appointments.dart';
import 'package:my_physio/Providers/centres.dart';
import 'package:my_physio/Providers/doctors.dart';
import 'package:my_physio/auth.dart';
import 'package:my_physio/auth_screen.dart';
import 'package:my_physio/constants/Appointments.dart';
import 'package:my_physio/homePage.dart';
import 'package:my_physio/splash_screen.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';

import 'Providers/city.dart';

void main() async{
   WidgetsFlutterBinding.ensureInitialized();
   await Firebase.initializeApp();
   AwesomeNotifications().initialize(
       null,
       [
         NotificationChannel(
             channelKey: 'key1',
             channelName: 'My-physio',
             playSound: true,
             enableVibration: true
         )
       ]
   );
   FirebaseMessaging.onBackgroundMessage(_firebasePushhandler);
   FirebaseMessaging.instance.getToken();
   FirebaseMessaging.onMessage.listen((RemoteMessage message){
     AwesomeNotifications().createNotificationFromJsonData(message.data);
     print(message.data);
   }) ;
   FirebaseMessaging.onMessageOpenedApp.listen((message) {
     print('Message clicked!');
   });

  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  // This widget is the root of your application.
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

  }
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
        ChangeNotifierProvider.value(
          value: CityProvider(),
        ),
        ChangeNotifierProvider.value(
          value: AppointmentsProvider(),
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
Future<void> _firebasePushhandler(RemoteMessage message) async{
  await AwesomeNotifications().createNotificationFromJsonData(message.data);
  print(message.data);
}

void Notify(message) async{
  await AwesomeNotifications().createNotification(content: NotificationContent(
    id:1,
    channelKey: 'key1',
  ));
  print(message.toString());
}

