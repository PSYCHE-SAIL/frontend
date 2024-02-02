import 'package:flutter/material.dart';
import '../components/text.dart';
import '../components/button.dart';
import '../components/firebase_func.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {

  @override
  Widget build(BuildContext context) {
      double sizeHeight = MediaQuery.of(context).size.height;
    double sizeWidth = MediaQuery.of(context).size.width;
    return LayoutBuilder(
            builder: (BuildContext context, BoxConstraints constraints) {
              bool constr = false; 
              if(constraints.maxWidth > 600) constr = true;
        return Scaffold(
          extendBodyBehindAppBar: true,
           appBar: AppBar(
            backgroundColor: Colors.transparent,
            leading: IconButton(
            icon: Icon(Icons.keyboard_backspace, color: Colors.black,),
            onPressed: () => Navigator.of(context).pop(),
          ), 
           ),
           body: Container(
            
            alignment: Alignment.center,
             decoration: BoxDecoration(
              color: Colors.white
             ),
             child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black)
                  ),
                  
                  child: Text("Log In",
                  style: TextStyle(
                    fontSize: sizeWidth/15,
                    color: Colors.black
                  ),),
                ),
                greyText(sizeHeight/50,sizeHeight/15, "Welcome back! Sign in using your\nsocial account or email to continue us"),
                Container(
                          
                          
                          alignment: Alignment.center,
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal : sizeWidth/10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                 InkWell(
                              onTap: () async =>  {print(await signInWithFacebook())},
                              child: circleButton(constr,sizeWidth/200,sizeWidth/100,"assets/facebook.png"),
                            ),
                            InkWell(
                              onTap: () async =>  {print(await signInWithGoogle())},
                              child: circleButton(constr,sizeWidth/200,sizeWidth/100,"assets/google.png"),
                            ),
                            InkWell(
                              onTap: () async => {},
                              child: circleButton(constr,sizeWidth/200,sizeWidth/100,"assets/black_apple.png"),
                            ),
                                
                              ],),
                              
                          )
                        ),
                        Container(decoration: BoxDecoration(
                    border: Border.all(color: Colors.black)
                  ),child: divider(constr,sizeWidth/30,sizeWidth/20,Colors.grey)),
                        Container (decoration: BoxDecoration(
                    border: Border.all(color: Colors.black)
                  ),child:bottomButton(constr,sizeWidth/50,sizeHeight/50,"Log in",Color.fromRGBO(35, 154, 139, 75),Colors.white),),
Container (decoration: BoxDecoration(
                    border: Border.all(color: Colors.black)
                  ),child:bottomButton(constr,sizeWidth/50,sizeHeight/50,"Forgot Password?",Colors.transparent,Color.fromRGBO(35, 154, 139, 75)),)

              ],
             ),
           ),
        );
      }
    );
  }
}