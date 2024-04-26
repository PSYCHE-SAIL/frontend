import 'dart:math';

import 'package:flutter/material.dart';
import 'package:psychesail/components/text.dart';
import 'package:psychesail/model/emoji.dart';
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
    final List<bool> isSelected = [true,false];
    Emoji stressEmoji = Emoji();
  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic>? args =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>?;
    // Access individual parameters
    var currentUserId = args?['currentuser'] ?? "";
    var data = args?['historycollection'] ?? "";
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
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.symmetric( horizontal: sizeWidth * sizeHeight * 0.00005),
                  decoration: BoxDecoration(
                              border: Border.all(color: Colors.white),
                              borderRadius: BorderRadius.all(Radius.circular(20.0))
                            ),
                  child: ToggleButtons(
                    constraints: BoxConstraints(
                      minWidth: sizeWidth * 0.4
                    ),
                    color: Colors.white,
                     selectedColor: Color.fromRGBO(35, 154, 139, 75),
                     fillColor: Colors.green.shade900.withOpacity(0.3),
                    borderColor: Colors.transparent,
                         selectedBorderColor: Colors.black,
                          borderWidth: 3,
                          borderRadius: BorderRadius.circular(20.0),
                          onPressed: (int index) {
                             setState(() {
                               isSelected[index] = true;
                               isSelected[(index - 1).abs()] = false;
                             });
                          }, isSelected: isSelected,
                          children: [
                          Padding(
                            padding:  EdgeInsets.all(sizeWidth * sizeHeight * 0.00002),
                            child: Text("History"),
                          ),
                          Padding(
                            padding:  EdgeInsets.all(sizeWidth * sizeHeight * 0.00002),
                            child: Text("Progress"),
                          ),
                        ]),
                ),
                SizedBox(height : sizeHeight * 0.03),
                Container(
                  height : sizeHeight * 0.7588,
                  decoration: BoxDecoration(
                          color: Colors.white,
                  ),
                  child: Padding(
                    padding: EdgeInsets.symmetric( vertical: 30.0, horizontal: sizeWidth * 0.02),
                    child: buildBody(sizeWidth,sizeHeight,data)
                  ),
                ),
              ],
            ),
          )
    );
    
  }
  
  buildBody(sizeWidth,sizeHeight,data) {
   
      if(isSelected[0]) return ListView.separated(
                                                      reverse: false,
                                                                                                  scrollDirection: Axis.vertical,
                                                                                                  shrinkWrap: true,
                                                                                                  itemCount: data.length,
                                                                                                  itemBuilder: (context,index) {
                                                                                                    return historyContainer(sizeWidth, sizeHeight, false, data[index][0],data[index][1],stressEmoji.stressEmoji((index+1).toString()));
                                                                                                  },
                                                                                                  separatorBuilder : ((context, index) => SizedBox(
                                                                                                    height : min(sizeHeight * 0.05, 30),
                                                                                                  )
                                                                                                ),
                                                                                                
                                                  );
          else return Placeholder();
    
  }
}