import 'package:flutter/material.dart';

class RoomControls extends StatelessWidget {
  final void Function() onToggleMicButtonPressed;
  final void Function() onToggleCameraButtonPressed;
  final void Function() onLeaveButtonPressed;
  late bool micEnabled;
  late bool camEnabled;

  RoomControls({
    Key? key,
    required this.onToggleMicButtonPressed,
    required this.onToggleCameraButtonPressed,
    required this.onLeaveButtonPressed,
    required this.micEnabled,
    required this.camEnabled
  }) : super(key: key);
 

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
       

        
        IconButton(
  onPressed: onToggleCameraButtonPressed,
  icon: Icon(
    camEnabled ? Icons.videocam : Icons.videocam_off,
    color: camEnabled ? Color.fromRGBO(35, 154, 139, 75) : Colors.red,
  ),
  iconSize: 40,
  tooltip: camEnabled ? 'Turn Off Camera' : 'Turn On Camera',
),
IconButton(
      onPressed:  onToggleMicButtonPressed,
      icon: Icon(
        micEnabled ? Icons.mic : Icons.mic_off,
        color: micEnabled ? Color.fromRGBO(35, 154, 139, 75) : Colors.red,
      ),
      iconSize: 40, // Adjust the icon size as needed
      tooltip: micEnabled ? 'Mute Mic' : 'Unmute Mic',
    ),
 MaterialButton(
  onPressed: onLeaveButtonPressed,
  color: Colors.red, // Set the button color to red
  shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(20.0), // Set the button border radius
  ),
  child: Icon(
    Icons.call_end, // Use the call_end icon for hang-up
    color: Colors.white, // Set the icon color to white
  ),
)

,
      ],
    );
  }
}
