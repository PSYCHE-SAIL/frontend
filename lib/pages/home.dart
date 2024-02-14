import 'package:flutter/material.dart';
import '../components/button.dart';
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
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
         bool constr = false; 
         if(constraints.maxWidth > 600) constr = true;
        return Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: Text("Home"),
          actions:  [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: sizeWidth/20),
                  child: circleButton(constr,sizeWidth/100,sizeWidth/50,"assets/idea.png"),
                )
              ],
          ),
          body: Padding(
            padding: const EdgeInsets.only( top: 16.0),
            child: Container(
              constraints: BoxConstraints(
                minHeight: sizeHeight/50,
                minWidth: sizeWidth/50
              ),
              decoration: BoxDecoration(
                color: Colors.white,
                    borderRadius: BorderRadius.only(
                topLeft: Radius.circular(50.0),
                topRight: Radius.circular(50.0))
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                            margin:  EdgeInsets.symmetric( horizontal: sizeWidth/2.3),
                            child: Divider(
                              color: const Color.fromARGB(255, 201, 195, 195),
                              height: 36,
                              thickness: 3,
                            ),),
                      Container(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal : 8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Column(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                               children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Container(
                                  decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5)
                                   ),
                                    child: circleButton(constr,sizeWidth/200,sizeWidth/300,"assets/idea.png"),
                                  ),
                                ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5)
                                ),
                                child: circleButton(constr,sizeWidth/200,sizeWidth/300,"assets/group_dp.png"),
                                ),
                              ),
                               ],
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text("MonkeyBot",
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: constr ? sizeWidth/40:sizeWidth/20,
                                      fontStyle: FontStyle.italic,
                                      fontFamily: 'ABeeZee',
                                    ),
                                    ),
                                    Text("How are you today?",
                                    style: TextStyle(
                                      color: Colors.grey,
                                     
                                    ),
                                    ),
                                  ],
                                  ),
                                ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text("Team Align",
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: constr ? sizeWidth/40:sizeWidth/20,
                                      fontStyle: FontStyle.italic,
                                      fontFamily: 'ABeeZee',
                                    ),
                                    ),
                                    Text("Don't miss to attend the meeting.",
                                    style: TextStyle(
                                        color: Colors.grey,
                                        
                                    ),
                                    ),
                                  ],
                                ),
                              ),
                                
                                ],
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: [
                                Padding(
                                  padding: const EdgeInsets.all(4.0),
                                  child: Column(
                                    children: [
                                      Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                                  children: [
                                    Text("2 min",style: TextStyle(
                                        color: Colors.grey,
                                        fontStyle: FontStyle.italic,
                                      fontFamily: 'ABeeZee',
                                    ),),
                                    CircleAvatar(maxRadius: constr ? sizeWidth/65: sizeWidth/40 ,backgroundColor: Colors.red,
                                    child: Text("3",
                                      style: TextStyle(
                                        fontSize: sizeWidth/50,
                                        
                                      ),
                                    )),
                                  ],
                                ),
                                    ],
                                 ),
                                ),
                              Padding(
                                padding: const EdgeInsets.all(4.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                   mainAxisAlignment: MainAxisAlignment.spaceAround,
                                  children: [
                                    Text("2 min",style: TextStyle(
                                        color: Colors.grey,
                                        fontStyle: FontStyle.italic,
                                      fontFamily: 'ABeeZee',
                                    ),),
                                    CircleAvatar(maxRadius: constr ? sizeWidth/65: sizeWidth/40,backgroundColor: Colors.red,
                                    child: Text("3",
                                      style: TextStyle(
                                        fontSize: sizeWidth/50
                                      ),
                                    )),
                                  ],
                                ),
                              ),
                              ],),
                              
                          ],),
                        ),
                      ),
                      
                      ],
                    )
                 ),
          ),
          bottomNavigationBar: BottomNavigationBar(
            unselectedItemColor: Color.fromRGBO(35, 154, 139, 75),
            fixedColor: Color.fromRGBO(35, 154, 139, 75),
            backgroundColor: Colors.white,
            items: [
            BottomNavigationBarItem(
        icon: Icon(Icons.message,color: Color.fromRGBO(35, 154, 139, 75),),
        label: "Message",
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.call,color: Color.fromRGBO(35, 154, 139, 75)),
        label: "Calls",
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.settings,color: Color.fromRGBO(35, 154, 139, 75)),
        label: "Settings",
      ),
          ])
        );
      }
    );
  }
}