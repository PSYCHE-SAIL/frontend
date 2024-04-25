import 'package:flutter/material.dart';
import 'package:random_avatar/random_avatar.dart';
class User {
  final String name;
  final String email;
  User(this.name, this.email);
}

class UserProvider extends ChangeNotifier {
  User? _currentUser;

  User? get currentUser => _currentUser;

  void setCurrentUser(User user) {
    _currentUser = user;
    notifyListeners();
  }
}

class Progress extends StatefulWidget {
  const Progress({super.key});

  @override
  State<Progress> createState() => _ProgressState();
}

class _ProgressState extends State<Progress> {
  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic>? args =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>?;
    // Access individual parameters
    var currentUserId = args?['currentuser'] ?? "";
    double sizeHeight = MediaQuery.of(context).size.height;
    double sizeWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
            backgroundColor: Colors.black,
            centerTitle: true,
            title: Text("History"),
            actions: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: sizeWidth / 20),
                child: RandomAvatar(currentUserId, trBackground: false, height: 50,width: 50))
            ],
          ),
          body : Padding(
            padding: const EdgeInsets.only(top: 16.0),
            child: Container(
              height : sizeHeight,
              decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(50.0),
                          topRight: Radius.circular(50.0))),
              child: const Placeholder()
            ),
          )
    );
  }
}