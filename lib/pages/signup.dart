import 'package:flutter/material.dart';
import '../components/text.dart';
import '../components/button.dart';
import '../components/firebase_func.dart';

class Signup extends StatefulWidget {
  const Signup({super.key});

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {

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
                    child: Text("Sign up with Email",
                    style: TextStyle(
                      decoration: TextDecoration.underline,
                      decorationThickness: 10,
                      decorationColor: Color.fromRGBO(35, 154, 139, 75).withOpacity(0.4),
                      fontSize: constr ? sizeWidth/50:sizeWidth/20,
                      color: Colors.black
                    ),),
                  ),
                  if(!constr)greyText(sizeHeight/50,sizeHeight/15, "Get chatting with friends and family today\nby signing up for our chat app!"),
                  !constr ? 
                  Padding(
                    padding:  EdgeInsets.only(bottom: sizeHeight/8, left: sizeWidth/20, right:sizeWidth/20),
                    child: Column(
                      children: [
                        TextFormField(
                                obscureText: true,
                            decoration: logininput('Enter Name', "Ex- john"),
                          ),
                        TextFormField(
                                decoration: logininput('Enter your email', "Ex- john@gmail.com"),
                              ),
                               TextFormField(
                                obscureText: true,
                            decoration: logininput('Password', "Ex- John123g#"),
                          ),
                          TextFormField(
                                obscureText: true,
                            decoration: logininput('Confirm Password',""),
                          ),
                      ],
                    ),
                  )
                    : Padding(
                    padding:  EdgeInsets.symmetric(horizontal: sizeWidth/20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                      Column(
                        children: [
                          Container(
                            constraints: BoxConstraints(
                              maxWidth: sizeWidth/3,
                            ),
                            child: TextFormField(
                                   style: TextStyle(
                                    color:Colors.black
                                   ),
                                    decoration: logininput('Enter Name', "Ex- john"),
                                  ),
                          ),
                                 Container(
                                  constraints: BoxConstraints(
                              maxWidth: sizeWidth/3,
                            ),
                                   child: TextFormField(
                                    obscureText: true,
                                                               decoration: logininput('Enter your email', "Ex- john@gmail.com"),
                                                             ),
                                 ),
                        ],
                      ),
                      
                      Column(
                        children: [
                          Container(
                            constraints: BoxConstraints(
                              maxWidth: sizeWidth/3,
                            ),
                            child: TextFormField(
                                   style: TextStyle(
                                    color:Colors.black
                                   ),
                                    decoration: logininput('Password', "Ex- John123g#"),
                                  ),
                          ),
                                 Container(
                                  constraints: BoxConstraints(
                              maxWidth: sizeWidth/3,
                            ),
                                   child: TextFormField(
                                    obscureText: true,
                                                               decoration: logininput('Confirm Password',""),
                                                             ),
                                 ),
                        ],
                      ),
                    ]),
                  ),
                      
                   constr ? Padding(
                                             padding: EdgeInsets.only(left: sizeWidth/20, right:sizeWidth/20),
                                             child: Container(
                                               constraints: BoxConstraints(
                                                 maxWidth: sizeWidth/2,
                                               ),
                                               child: bottomButton(constr,sizeWidth/50,sizeHeight/50,"Create an account",Color.fromRGBO(35, 154, 139, 75),Colors.white)),
                                           )
                   : Padding(
                      padding: EdgeInsets.only(left: sizeWidth/20, right:sizeWidth/20),
                      child: bottomButton(constr,sizeWidth/50,sizeHeight/50,"Create an account",Color.fromRGBO(35, 154, 139, 75),Colors.white),
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