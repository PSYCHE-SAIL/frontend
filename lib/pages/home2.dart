import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:gdscsol/demo/auth_service.dart';
import 'package:provider/provider.dart';
import '../chatroom.dart';
import '../components/button.dart';
import '../components/text.dart';

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

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final reff = FirebaseDatabase.instance.ref();

  var currentUserId = '';

  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic>? args =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>?;
    double sizeHeight = MediaQuery.of(context).size.height;
    double sizeWidth = MediaQuery.of(context).size.width;
    // Access individual parameters
    currentUserId = args?['currentuser'] ?? '';
    return LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
      bool constr = false;
      if (constraints.maxWidth > 600) constr = true;
      return Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: Text("Home"),
            backgroundColor: Colors.transparent,
            actions: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: sizeWidth / 20),
                child: circleButton(
                    constr, sizeWidth / 100, sizeWidth / 50, "assets/idea.png"),
              )
            ],
          ),
          body: Container(
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(55),
                      topRight: Radius.circular(55))),
              margin: EdgeInsets.only(top: 30),
          child : Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
      Container(
      margin:  EdgeInsets.symmetric( horizontal: sizeWidth/2.3),
          child: Divider(
          color: const Color.fromARGB(255, 201, 195, 195),
          height: 36,
          thickness: 3,
          ),),
            _buildUserList(constr, sizeWidth, sizeHeight, 'monkeybot')
            // _buildUserList(constr, sizeWidth, sizeHeight, currentUserId),
          ],),),

          bottomNavigationBar: BottomNavigationBar(
              unselectedItemColor: Color.fromRGBO(35, 154, 139, 75),
              fixedColor: Color.fromRGBO(35, 154, 139, 75),
              backgroundColor: Colors.white,
              items: [
                BottomNavigationBarItem(
                  icon: Icon(
                    Icons.message,
                    color: Color.fromRGBO(35, 154, 139, 75),
                  ),
                  label: "Message",
                ),
                BottomNavigationBarItem(
                  icon:
                      Icon(Icons.call, color: Color.fromRGBO(35, 154, 139, 75)),
                  label: "Calls",
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.settings,
                      color: Color.fromRGBO(35, 154, 139, 75)),
                  label: "Settings",
                ),
              ]));
    });
  }

  Widget _buildUserList(constr, sizeWidth, sizeHeight, currentuserId) {
    return Expanded (
        child: StreamBuilder<QuerySnapshot<Object?>>(
      stream: FirebaseFirestore.instance.collection('customers').snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return const Text("Error");
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Text("Loading...");
        }
        if (snapshot.data == null || snapshot.data!.docs.isEmpty) {
          return const Text("No users found");
        }
        return Container(
            padding: EdgeInsets.only(top: 50),
            child: ListView(
                children : snapshot.data!.docs
                    .map<Widget>((doc) =>
                    _buildUserListItem(doc, constr, sizeWidth, sizeHeight, currentUserId))
                    .toList(),
            ));
      },
    ));
  }

  Widget _buildUserListItem(
      DocumentSnapshot document, constr, sizeWidth, sizeHeight, currentUserId) {
    Map<String, dynamic> data = document.data()! as Map<String, dynamic>;

    // print(_auth.currentUser!.displayName!);

    if (currentUserId != data['id']) {
      // if (data['id'] == 'monkeybot'){
      //   return Padding(
      //     padding: EdgeInsets.all(12),
      //     child: homechatbubble(
      //         constr, sizeWidth, sizeHeight, data, context, currentUserId),
      //   );
      // }
      // else {
        return Padding(
          padding: EdgeInsets.all(12),
          child: homechatbubble(
              constr, sizeWidth, sizeHeight, data, context, currentUserId),
        );
      // }
      // return ListTile(
      //   title: Text(data['id']),
      //   onTap: () {
      //     print(data['id']);
      //     print(data['email']);
      //     print(currentUserId);
      //     Navigator.pushNamed(context, '/chatroom', arguments: {
      //       'receiveremail': data['email'],
      //       'receiverid': data['id'],
      //       'currentid': currentUserId,
      //     });
      //     // Navigator.push(
      //     //   context,
      //     //   MaterialPageRoute(builder: (context) =>
      //     //       ChatRoom(
      //     //         receiveremail: data['email'], receriverid: data['id'], currentId: currentUserId)),
      //     // );
      //   },
      // );
    }

      else {
      return Container();
    }
  }
}
