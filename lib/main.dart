import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:psychesail/pages/activitymaps.dart';
import 'package:psychesail/pages/call.dart';
import 'package:psychesail/pages/history.dart';
import 'package:psychesail/pages/monkeybotchatroom.dart';
import 'package:psychesail/pages/serenitychatroom.dart';
import 'package:psychesail/utils/SearchPlacesScreen.dart';
import './pages/onboarding.dart';
import './pages/login.dart';
import './pages/home.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart'; 
import './pages/signup.dart';
import './pages/chatroom.dart';
import './pages/settings.dart';
import 'firebase_options.dart';
import 'package:flutter_gemini/flutter_gemini.dart';

void main() async {
  if(Platform.isWindows || Platform.isLinux) {
   await FacebookAuth.i.webAndDesktopInitialize(
      appId: "918788496148996",
      cookie: true,
      xfbml: true,
      version: "v15.0",
    );
  }
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  Gemini.init(apiKey: 'AIzaSyBVOgf5N_kO5_BdX7lZ-DDCRv7bRzYSOOs');
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'PsycheSail',
      initialRoute: '/',
      routes: {
        '/': (context) => const onboarding(),
        '/login': (context) => const Login(),
        '/Signup': (context) => const Signup(),
        '/home':(context) => const home(),
        '/chatroom':(context) => const ChatRoom(),
        '/monkeybot':(context) => MonkeyBotChatRoom(),
        '/serenity' : (context) => const SerenityChat(),
        '/settings':(context)=> const Setting(),
        '/call_page':(context) => const CallPage(),
        '/progress' :(context) => const Progress(),
'/activity-maps':(context) => ActivityMaps(),
      },
    debugShowCheckedModeBanner: false,
    theme: ThemeData.dark(useMaterial3: true),
    );
  
  }
}
