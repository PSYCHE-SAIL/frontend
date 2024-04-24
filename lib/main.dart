import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:psychesail/pages/call.dart';
import 'package:psychesail/pages/monkeybotchatroom.dart';
import './pages/onboarding.dart';
import './pages/login.dart';
import './pages/home.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart'; 
import './pages/signup.dart';
import './pages/chatroom.dart';
import './pages/settings.dart';
import 'firebase_options.dart';

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
        '/monkeybot':(context) => const MonkeyBotChatRoom(),
        '/settings':(context)=> const Setting(),
        '/call_page':(context) => const CallPage(),
      },
    debugShowCheckedModeBanner: false,
    theme: ThemeData.dark(useMaterial3: true),
    );
  
  }
}
