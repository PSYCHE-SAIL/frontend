import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import '../components/firebase_func.dart';

class onboarding extends StatefulWidget {
  const onboarding({super.key});

  @override
  State<onboarding> createState() => _onboardingState();
}

class _onboardingState extends State<onboarding>  with SingleTickerProviderStateMixin{


  
  @override
  Widget build(BuildContext context) {
    double sizeHeight = MediaQuery.of(context).size.height;
    double sizeWidth = MediaQuery.of(context).size.width;
    return  LayoutBuilder(
            builder: (BuildContext context, BoxConstraints constraints) {
              bool constr = false; 
              if(constraints.maxWidth > 600) constr = true;
        return Scaffold(
          extendBodyBehindAppBar: true,
           appBar: AppBar(
            backgroundColor: Colors.transparent,
            title: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if(constraints.maxWidth < 600) 
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0,right: 0),
                    child: CircleAvatar(radius : 30,
                    child: Image.asset("assets/psychesail.png",fit: BoxFit.cover,),
                    // backgroundImage: ExactAssetImage("assets/psychsail_600.png")
                    backgroundColor: Color(0xFFFFFF),
                  )),
                  if(constraints.maxWidth < 600) 
                  Padding(
                    padding: const EdgeInsets.only(right: 16.0,left: 0),
                    child: Text("PsycheSail"),
                  )
                ],
              ),
            ),
          ),
          body: Padding(
            padding:  EdgeInsets.only(top : sizeHeight/20),
            child: Container(
            
            decoration: BoxDecoration(image: DecorationImage(image: AssetImage("assets/background_onboarding.png"),fit: BoxFit.cover)), 
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Padding(
                    padding: EdgeInsets.only(left:  32.0, right: 32.0, top: sizeHeight/50),
                    child: Container(
                      
                      
                      // alignment: Alignment.center,
                      child: Center(
                        child: Text(constr ? 'Success Beyond Stress, Wellness Within':'Success Beyond Stress,\nWellness Within',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: constr ? sizeWidth/30: sizeHeight/17,
                          fontWeight: FontWeight.w400,
                          fontFamily: 'AkayaKanadaka'
                        ),
                        overflow: TextOverflow.fade,),
                      ),
                    ),
                  ),
                  if(constraints.maxWidth < 600 )
                  Padding(
                    padding:  EdgeInsets.symmetric(horizontal: 32.0),
                    child: Container(
                      constraints: BoxConstraints(
                        minHeight: sizeHeight/15,
                      ),
                      alignment: Alignment.center,
                      child: Center(
                        child: Text("Chill Maps, Therapy Chats - Because\nSuccess Shouldn't Stress You Out!",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: sizeHeight/50,
                          fontFamily: 'ABeeZee',
                          color: Colors.white.withOpacity(0.6),
                          fontStyle: FontStyle.italic
                        
                        ),
                        overflow: TextOverflow.fade,),
                      ),
                    ),
                  ),
                  Padding(
                    padding:  EdgeInsets.symmetric(horizontal: sizeWidth/10),
                    child: Container(
                      
                      
                      alignment: Alignment.center,
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal : sizeWidth/10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                              InkWell(
                                onTap: () async =>  {print(await signInWithFacebook())},
                              child: Container(child: Padding(
                                padding:  EdgeInsets.all(constr ? sizeWidth/200 : sizeWidth/100),
                                child: Image.asset("assets/facebook.png",fit: BoxFit.cover,),
                              ),decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                                        color: Colors.transparent,
                                                      
                                                         border: Border.all(
                              color: Colors.white,
                              width: 0.25,
                                                        ),
                              ),),
                            ),
                            InkWell(
                              onTap: () async =>  {print(await signInWithGoogle())},
                              child: Container(child: Padding(
                                padding: EdgeInsets.all(constr ? sizeWidth/200 : sizeWidth/100),
                                child: Image.asset("assets/google.png",fit: BoxFit.cover,),
                              ),decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                                        color: Colors.transparent,
                                                      
                                                         border: Border.all(
                              color: Colors.white,
                              width: 0.25,
                                                        ),
                              ),),
                            ),Container(child: Padding(
                              padding: EdgeInsets.all(constr ? sizeWidth/200 : sizeWidth/100),
                              child: Image.asset("assets/apple.png",fit: BoxFit.cover,),
                            ),decoration: BoxDecoration(
                              shape: BoxShape.circle,
                          color: Colors.transparent,
                        
                           border: Border.all(
                            color: Colors.white,
                            width: 0.25,
                          ),
                            ),)
                          ],),
                          
                      )
                    ),
                    
                  ),
                  Row(children: [
                      Expanded(
                        child: new Container(
                            margin:  EdgeInsets.symmetric( horizontal: constr ? sizeWidth/30:sizeWidth/20),
                            child: Divider(
                              color: Colors.white,
                              height: 36,
                              thickness: 0.25,
                            )),
                      ),
                      Text("OR", textAlign: TextAlign.center,
            style: TextStyle(
            color: Color(0xFFD6E4DF),
            fontSize: 14,
            fontStyle: FontStyle.italic,
            fontFamily: 'ABeeZee',
            fontWeight: FontWeight.w400,
            
            )),
                      Expanded(
                        child: new Container(
                            margin: EdgeInsets.symmetric( horizontal: constr ? sizeWidth/30:sizeWidth/20),
                            child: Divider(
                              color: Colors.white,
                              height: 36,
                              thickness: 0.25,
                            )),
                      ),
                    ]),
                    Padding(
                    padding: EdgeInsets.symmetric( horizontal: constr ? sizeWidth/5:sizeWidth/10),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(20))
                      ),
                      
                      alignment: Alignment.center,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text("Sign up with mail",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: constr ? sizeWidth/50 : sizeHeight/50,
                           fontStyle: FontStyle.italic,
                           fontFamily: 'ABeeZee', 
                          color: Colors.black
                        ),
                        overflow: TextOverflow.fade,),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric( horizontal: constr ? sizeWidth/5:sizeWidth/10),
                    child: InkWell(
                      onTap: () => {
                        Navigator.pushNamed(context, '/login')
                      },
                      child: Container(
                            decoration: BoxDecoration(
                      color: Colors.transparent
                            ),
                            
                            alignment: Alignment.center,
                            child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text("Existing account? Log in",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: constr ? sizeWidth/50 : sizeHeight/50,
                         fontStyle: FontStyle.italic,
                         fontFamily: 'ABeeZee', 
                      ),
                      overflow: TextOverflow.fade,),
                            ),
                          ),
                    ),
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