import 'package:flutter/material.dart';
import 'package:random_avatar/random_avatar.dart';
import '../components/button.dart';
import '../components/text.dart';
class Setting extends StatefulWidget {
  const Setting({super.key});

  @override
  State<Setting> createState() => _SettingState();
}

class _SettingState extends State<Setting> {
  @override
  Widget build(BuildContext context) {
    double sizeHeight = MediaQuery.of(context).size.height;
    double sizeWidth = MediaQuery.of(context).size.width;
    var currentUserId = '';
    final Map<String, dynamic>? args =
    ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>?;
    // Access individual parameters
    currentUserId = args?['currentid'] ?? "";
    return LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          bool constr = false;
          if (constraints.maxWidth > 600) constr = true;

          return Scaffold(
              appBar: AppBar(
                centerTitle: true,
                title: Text("Settings"),

              ),
              body: Padding(
                padding: const EdgeInsets.only(top: 16.0),
                child: Container(
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
                        Padding(
                          padding: EdgeInsets.all(16.0),
                          child: Row(
                            // mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [

                              Container(
                                width: sizeWidth/4,
                                child: RandomAvatar(currentUserId, trBackground: false, height: 50,width: 50)
                              ),
                              SizedBox(


                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(currentUserId,
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: constr ? sizeWidth / 40 : sizeWidth / 20,
                                        fontStyle: FontStyle.italic,
                                        fontFamily: 'ABeeZee',

                                      ),),
                                    Text("Never give up",
                                      style: TextStyle(
                                        color: Colors.grey,
                                        fontSize: constr ? sizeWidth / 40 : sizeWidth / 20,
                                        fontStyle: FontStyle.italic,
                                        fontFamily: 'ABeeZee',
                                      ),
                                    )
                                  ],
                                ),
                              )
                            ],),
                        ),
                        Divider(
                          color: Colors.grey,
                          height: 36,
                          thickness: 0.50,
                        ),
                       SingleChildScrollView(
                         child: Padding(
                           padding: const EdgeInsets.all(8.0),
                           child: Column(
                             mainAxisAlignment: MainAxisAlignment.spaceAround,
                             children: [
                               settingsContainer(constr,25.00,sizeWidth,Icons.key_outlined,"Accounts","Privacy,security"),
                               settingsContainer(constr,25.00,sizeWidth,Icons.chat,"Chat","Chat history,theme"),
                               settingsContainer(constr,25.00,sizeWidth,Icons.notifications,"Notifications","Messages and others"),
                               settingsContainer(constr,25.00,sizeWidth,Icons.help,"Help","Help center,contact us"),
                             ],
                           ),


                         )
                       ),
                      ],
                    )),
              ),
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
}
format(Duration d) => d.toString().split('.').first.padLeft(8, "0");