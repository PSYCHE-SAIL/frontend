import 'package:flutter/material.dart';
import 'package:psychesail/components/video.dart';
import 'package:psychesail/pages/join_room.dart';
import 'package:psychesail/pages/room_screen.dart';

import '../components/crud.dart';

class VideoSDKQuickStart extends StatefulWidget {
  const VideoSDKQuickStart({Key? key}) : super(key: key);

  @override
  State<VideoSDKQuickStart> createState() => _VideoSDKQuickStartState();
}

class _VideoSDKQuickStartState extends State<VideoSDKQuickStart> {
  String roomId = "";
  bool isRoomActive = false;

  @override
  Widget build(BuildContext context) {
    double sizeHeight = MediaQuery.of(context).size.height;
    double sizeWidth = MediaQuery.of(context).size.width;
    var currentUserId = '';
    final Map<String, dynamic>? args =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>?;
    // Access individual parameters

    currentUserId = args?['currentid'] ?? "";
    return Scaffold(
      appBar: AppBar(
        title: const Text("VideoSDK QuickStart"),
      ),
      body: FutureBuilder<dynamic>(
                            future: calling(currentUserId),
        builder: (context,snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
                                  return Text(
                                    'Loading....',
                                    style: TextStyle(color: Colors.white),
                                  );
            default:
            if (snapshot.hasError) {
                                    return Text('Error: ${snapshot.error}');
                                  } else {
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child:  RoomScreen(
                    roomId: snapshot.data,
                    token: token,
                    leaveRoom: () {
                      setState(() => isRoomActive = false);
                    },
                  )
                
          );
          }
        }
        }
      ),
    );
  }
}

calling(currentUserId) async {
  dynamic roomId = await createRoom();
   addCall("Joe",currentUserId,roomId);
  return roomId;
 

}