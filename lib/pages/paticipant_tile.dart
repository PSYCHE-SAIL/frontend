import 'package:flutter/material.dart';
import 'package:videosdk/videosdk.dart';

class ParticipantTile extends StatelessWidget {
  final Stream? stream;
  final double width;
  final double height;
  const ParticipantTile({
    Key? key, required this.stream,
    required this.width, required this.height
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SizedBox(
        height: height,
        width: width,
        child: stream != null ? RTCVideoView(
          stream!.renderer!,
          objectFit: RTCVideoViewObjectFit.RTCVideoViewObjectFitCover,
        ) : Container(
          decoration: BoxDecoration(
            border: Border.all(color: Colors.white)
          ),
          child: Icon(Icons.videocam_off,fill: 1.0,size: 200.0)),
      ),
    );
  }
}
