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
           resizeToAvoidBottomInset: false,
           body: Container(
            
            alignment: Alignment.center,
             decoration: BoxDecoration(
              color: Colors.white
             ),
             child: Padding(
               padding: EdgeInsets.symmetric(horizontal : sizeWidth/25),
               child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Padding(
                    padding:  EdgeInsets.only(top: sizeHeight/15),
                    child: Text("Log In",
                    style: TextStyle(
                      decoration: TextDecoration.underline,
                      decorationThickness: 10,
                      decorationColor: Color.fromRGBO(35, 154, 139, 75).withOpacity(0.4),
                      fontSize: constr ? sizeWidth/50:sizeWidth/20,
                      color: Colors.black
                    ),),
                  ),
                  if(!constr)greyText(sizeHeight/50,sizeHeight/15, "Welcome back! Sign in using your social\naccount or email to continue us"),
                  !constr ? Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal : sizeWidth/6),
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
                          
                      ),
                      Padding(
                        padding: EdgeInsets.only( top : sizeWidth/20),
                        child: divider(constr,sizeWidth/30,sizeWidth/20,Colors.grey),
                      ),
                  Padding(
                    padding:  EdgeInsets.only(bottom: sizeHeight/8, left: sizeWidth/20, right:sizeWidth/20),
                    child: Column(
                      children: [
                        TextFormField(
                                decoration: logininput('Enter your email', "Ex- john@gmail.com"),
                              ),
                               TextFormField(
                                obscureText: true,
                            decoration: logininput('Password', "Ex- John123g#"),
                          ),
                      ],
                    ),
                  ),
                    ],
                  ): Padding(
                    padding:  EdgeInsets.symmetric(horizontal: sizeWidth/20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: InkWell(
                                                          onTap: () async =>  {print(await signInWithFacebook())},
                                                          child: circleButton(constr,sizeWidth/200,sizeWidth/100,"assets/facebook.png"),
                                                        ),
                          ),
                                                      Padding(
                                                        padding: const EdgeInsets.all(8.0),
                                                        child: InkWell(
                                                          onTap: () async =>  {print(await signInWithGoogle())},
                                                          child: circleButton(constr,sizeWidth/200,sizeWidth/100,"assets/google.png"),
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding: const EdgeInsets.all(8.0),
                                                        child: InkWell(
                                                          onTap: () async => {},
                                                          child: circleButton(constr,sizeWidth/200,sizeWidth/100,"assets/black_apple.png"),
                                                        ),
                                                      ),
                        ],
                      ),
                      dividervertical(constr,sizeHeight/7,sizeHeight/20,Colors.black),
                      Column(
                        children: [
                          Container(
                            constraints: BoxConstraints(
                              maxWidth: sizeWidth/2,
                            ),
                            child: TextFormField(
                                   style: TextStyle(
                                    color:Colors.black
                                   ),
                                    decoration: logininput('Enter your email', "Ex- john@gmail.com"),
                                  ),
                          ),
                                 Container(
                                  constraints: BoxConstraints(
                              maxWidth: sizeWidth/2,
                            ),
                                   child: TextFormField(
                                    obscureText: true,
                                                               decoration: logininput('Password', "Ex- John123g#"),
                                                             ),
                                 ),
                        ],
                      ),
                    ]),
                  ),
                      
                   constr ? Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children :[
Padding(
                          padding: EdgeInsets.only(left: sizeWidth/20, right:sizeWidth/20),
                          child: Container(
                            constraints: BoxConstraints(
                              maxWidth: sizeWidth/2,
                            ),
                            child: bottomButton(constr,sizeWidth/50,sizeHeight/50,"Log in",Color.fromRGBO(35, 154, 139, 75),Colors.white)),
                        ),
                        Padding(
                      padding: EdgeInsets.only(left: sizeWidth/20, right:sizeWidth/20),
                      child: bottomButton(constr,sizeWidth/50,sizeHeight/50,"Forgot Password?",Colors.transparent,Color.fromRGBO(35, 154, 139, 75)),
                    )
                    ]
                   )
                   : Column(
                     children: [
                       Padding(
                          padding: EdgeInsets.only(left: sizeWidth/20, right:sizeWidth/20),
                          child: bottomButton(constr,sizeWidth/50,sizeHeight/50,"Log in",Color.fromRGBO(35, 154, 139, 75),Colors.white),
                        ),
                        Padding(
                      padding: EdgeInsets.only(left: sizeWidth/20, right:sizeWidth/20),
                      child: bottomButton(constr,sizeWidth/50,sizeHeight/50,"Forgot Password?",Colors.transparent,Color.fromRGBO(35, 154, 139, 75)),
                    )
                     ],
                   ),
                    
                ],
               ),
             ),
           ),
        );
      }
    );
  }
}