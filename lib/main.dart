import 'dart:io';
import 'package:flutter/material.dart';
import 'package:gdscsol/chatroom.dart';
import 'package:gdscsol/demo/auth_service.dart';
import 'package:gdscsol/demo/register.dart';
import 'package:gdscsol/pages/home2.dart';
import 'package:gdscsol/pages/settings.dart';
import 'package:provider/provider.dart';
import './pages/onboarding.dart';
import './pages/login.dart';
import './pages/home.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import './pages/signup.dart';
import 'firebase_options.dart';
import 'monkeybotchatroom.dart';

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
    return
    ChangeNotifierProvider(create: (_) => AuthService(),
      child: MaterialApp(

      title: 'PsycheSail',
      initialRoute: '/settings',
      routes: {
        '/': (context) => const onboarding(),
        '/login': (context) => const Login(),
        '/Signup': (context) => const Register(),
        '/home':(context) => const home(),
        '/home2':(context) => const HomePage(),
        '/chatroom':(context) => const ChatRoom(),
        '/monkeybot':(context) => const MonkeyBotChatRoom(),
        '/settings':(context) => const Settings(),
      },
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(useMaterial3: true),
    ));
  }
}