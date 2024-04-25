import 'package:flutter/material.dart';
import 'package:psychesail/components/crud.dart';
import 'package:psychesail/components/text.dart';
import 'package:psychesail/components/vertical_scroll.dart';
import 'package:random_avatar/random_avatar.dart';
import '../components/button.dart';
import 'package:intl/intl.dart';


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
class home extends StatefulWidget {
  const home({super.key});

  @override
  State<home> createState() => _homeState();
}

class _homeState extends State<home> {
  @override
  Widget build(BuildContext context) {
    
    double sizeHeight = MediaQuery.of(context).size.height;
    double sizeWidth = MediaQuery.of(context).size.width;
    var currentUserId = '';
    final Map<String, dynamic>? args =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>?;
    // Access individual parameters
    currentUserId = args?['currentuser'] ?? "";
    return LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
      bool constr = false;
      if (constraints.maxWidth > 600) constr = true;
      
      return Scaffold(
        backgroundColor : Colors.black,
          appBar: AppBar(
            backgroundColor: Colors.black,
            centerTitle: true,
            title: Text("Home"),
            actions: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: sizeWidth / 20),
                child: RandomAvatar(currentUserId, trBackground: false, height: 50,width: 50))
            ],
          ),
          body: Padding(
            padding: const EdgeInsets.only(top: 16.0),
            child: Container(
              height: sizeHeight,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(50.0),
                        topRight: Radius.circular(50.0))),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: sizeWidth / 2.3),
                      child: Divider(
                        color: const Color.fromARGB(255, 201, 195, 195),
                        height: 36,
                        thickness: 3,
                      ),
                    ),
                    Container(
                      height: sizeHeight * 0.73,
                      child: SingleChildScrollView(
                        child: FutureBuilder<dynamic>(
                            future: getUsers(currentUserId), // async work
                            builder: (BuildContext context,
                                AsyncSnapshot<dynamic> snapshot) {
                              switch (snapshot.connectionState) {
                                case ConnectionState.waiting:
                                  return Text('Loading....',style: TextStyle(color: Colors.black),);
                                default:
                                  if (snapshot.hasError) {
                                    return Text('Error: ${snapshot.error}');
                                  } else {
                                    return Padding(
                                      padding: const EdgeInsets.all(16.0),
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                                        children: [
                                          ListView.builder(
                                              scrollDirection: Axis.vertical,
                                              shrinkWrap: true,
                                              itemCount: snapshot.data[0].length,
                                              itemBuilder:
                                                  (BuildContext context, int index) {
                                                   final DateTime now = DateTime.now();
                                                                       final formattedDate = dateFormatter.format(now);
                                                     final formattedTime = timeFormatter.format(now);
                                                    
                                                     DateTime checkTime = DateFormat("hh:mm:ss").parse(formattedTime);
                                                    final diffTime = checkTime.difference(DateFormat("hh:mm:ss").parse(snapshot.data[0].values.elementAt(index)['time']));
                                                return Padding(
                                                  padding: const EdgeInsets.symmetric(vertical : 8.0),
                                                  child: InkWell(
                                                    onTap: () => {
                                                      if(snapshot.data[0].keys.elementAt(index) == 'Serenity') {Navigator.pushNamed(context, '/monkeybot', arguments: {'receiverid' : snapshot.data[0].keys.elementAt(index),'currentid': currentUserId,'lastmessage': snapshot.data[0].values.elementAt(index)['message']} ) }
                                                      else {Navigator.pushNamed(context, '/chatroom', arguments: {'receiverid' : snapshot.data[0].keys.elementAt(index),'currentid': currentUserId,'receiveremail': 'gaand_maarao'} ) }
                                                    },
                                                    child: Container(
                                                       
                                                      child: Padding(
                                                        padding: const EdgeInsets.symmetric(
                                                            horizontal: 8.0),
                                                        child: Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment.spaceEvenly,
                                                          children: [
                                                            Container(
                                                              width: sizeWidth/5,
                                                              decoration: BoxDecoration(
                                                                  borderRadius:
                                                                      BorderRadius.circular(
                                                                          5)),
                                                              child:!(snapshot.data[0].keys.elementAt(index) == "Groupchat" )?  RandomAvatar(snapshot.data[0].keys.elementAt(index), trBackground: false, height: 50,width: 50) : circleButton(
                                                              constr, sizeWidth / 100, sizeWidth / 50, "assets/group_dp.png"),
                                                            ),
                                                            Container(
                                                              width: sizeWidth/2.5,
                                                              child: Column(
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment.center,
                                                                children: [
                                                                  Text(
                                                                    snapshot.data[0].keys.elementAt(index),
                                                                    style: TextStyle(
                                                                      color: Colors.black,
                                                                      fontSize: constr
                                                                          ? sizeWidth / 40
                                                                          : sizeWidth / 20,
                                                                      fontStyle:
                                                                          FontStyle.italic,
                                                                      fontFamily: 'ABeeZee',
                                                                    ),
                                                                  ),
                                                                  Text(
                                                                    snapshot.data[0].values.elementAt(index)['message'].length < 20 ? snapshot.data[0].values.elementAt(index)['message']:snapshot.data[0].values.elementAt(index)['message'].substring(0,20),
                                                                    style: TextStyle(
                                                                      color: Colors.grey,
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                            Container(
                                                              width: sizeWidth/4,
                                                              child: Column(
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment.center,
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .spaceAround,
                                                                children: [
                                                                  Text(
                                                                    formattedDate == snapshot.data[0].values.elementAt(index)['date'] ? diffTime.inHours == 00 ? diffTime.inMinutes == 00 ? "${diffTime.inSeconds.toString()} sec" : "${diffTime.inMinutes.toString()} mins":"${diffTime.inHours.toString()} hours": snapshot.data[0].values.elementAt(index)['date'],
                                                                    style: TextStyle(
                                                                      color: Colors.grey,
                                                                      fontStyle:
                                                                          FontStyle.italic,
                                                                      fontFamily: 'ABeeZee',
                                                                    ),
                                                                  ),
                                                                  CircleAvatar(
                                                                      maxRadius: constr
                                                                          ? sizeWidth / 65
                                                                          : sizeWidth / 40,
                                                                      backgroundColor:
                                                                          Colors.transparent,
                                                                      child: Text(
                                                                        "",
                                                                        style: TextStyle(
                                                                            fontSize:
                                                                                sizeWidth /
                                                                                    50),
                                                                      )),
                                                                ],
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                );
                                              }),
                                              SizedBox(height: sizeHeight * 0.03,),
                                              historyscroll(sizeWidth,sizeHeight,constr,"History",snapshot.data[3],context,currentUserId),
                                              SizedBox(height: sizeHeight * 0.03,),
                                              communityscroll(sizeWidth,sizeHeight,constr,"Community Discussions",snapshot.data[1]),
                                              SizedBox(height: sizeHeight * 0.03,),
                                              activityscroll(sizeWidth,sizeHeight,constr,"Stress Busting Activities",snapshot.data[2])                                            
                                        ],
                                      ),
                                    );
                                  }
                              }
                            }),
                      ),
                    ),
                  ],
                )),
          ),
          bottomNavigationBar: BottomNavigationBar(
            onTap: (int index){
if(index == 2) { Navigator.pushNamed(context, '/settings',arguments: {'currentid':currentUserId});} 
            },
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
}
 format(Duration d) => d.toString().split('.').first.padLeft(8, "0");
