import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'model.dart';

class listofsong extends StatefulWidget {
  const listofsong({Key? key}) : super(key: key);

  @override
  State<listofsong> createState() => _listofsongState();
}

class _listofsongState extends State<listofsong> {
  AudioPlayer player = AudioPlayer();

  List<bool> statuslist = [];




  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    statuslist = List.filled(Model.songlist.length, false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("All Songlist"),
      ),
      body: ListView.builder(
        itemCount: Model.songlist.length,
        itemBuilder: (context, index) {
          return ListTile(
            trailing: statuslist[index]
                ? IconButton(
                onPressed: () async {
                  setState(() {
                    statuslist = List.filled(Model.songlist.length, false);
                  });
                  print(statuslist);
                  await player.stop();
                },
                icon: Icon(Icons.pause))
                : IconButton(
                onPressed: () async {
                  await player.stop();
                  setState(() {
                    statuslist = List.filled(Model.songlist.length, false);
                    statuslist[index] = true;
                  });
                  await player
                      .play(DeviceFileSource(Model.songlist[index].data));

                  print(statuslist);
                },
                icon: Icon(Icons.play_arrow)),
            title: Text("${Model.songlist[index].displayNameWOExt}"),
            subtitle: Text("${Model.songlist[index].duration}"),
          );
        },
      ),
    );
  }
  String prettyDuration(Duration duration) {
    var seconds = (duration.inMilliseconds % (60 * 1000)) / 1000;
    return '${duration.inMinutes}m${seconds.toStringAsFixed(2)}s';
  }
}
