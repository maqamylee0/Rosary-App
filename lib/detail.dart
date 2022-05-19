import 'dart:core';
import 'dart:typed_data';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';


class Detail extends StatefulWidget {
  final String text;

  const Detail({Key? key,required this.text}) : super(key: key);

  @override
  State<Detail> createState() => new _DetailState(text);
}
class _DetailState extends State<Detail> {
   late String audioasset;
  _DetailState(String text){
    audioasset = "assets/audio/${text}.mp3";
    print("urllllllllllll is "+ audioasset);
  }
  int maxduration = 100;
  int currentpos = 0;
  String currentpostlabel = "00:00";
  bool isplaying = false;
  bool audioplayed = false;
  late Uint8List audiobytes;

  AudioPlayer player = AudioPlayer();


  @override
  void initState() {
    Future.delayed(Duration.zero, () async {

      ByteData bytes = await rootBundle.load(audioasset); //load audio from assets
      audiobytes = bytes.buffer.asUint8List(bytes.offsetInBytes, bytes.lengthInBytes);
      //convert ByteData to Uint8List

      player.onDurationChanged.listen((Duration d) { //get the duration of audio
        maxduration = d.inMilliseconds;
        setState(() {

        });
      });

      player.onAudioPositionChanged.listen((Duration  p){
        currentpos = p.inMilliseconds; //get the current position of playing audio

        //generating the duration label
        int shours = Duration(milliseconds:currentpos).inHours;
        int sminutes = Duration(milliseconds:currentpos).inMinutes;
        int sseconds = Duration(milliseconds:currentpos).inSeconds;

        int rhours = shours;
        int rminutes = sminutes - (shours * 60);
        int rseconds = sseconds - (sminutes * 60 + shours * 60 * 60);

        currentpostlabel = "$rhours:$rminutes:$rseconds";

        setState(() {
          //refresh the UI
        });
      });

    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.teal[100],
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(100),
            child: AppBar(
            title: Text("${widget.text} Mysteries".toUpperCase()),
            backgroundColor: Colors.teal,
          bottomOpacity: 0.4,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              bottom: Radius.circular(30),
            ),
          ),
        ),),
        body: Container(
            margin: EdgeInsets.only(top:50),
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.all(50),
                  child: Image.asset('assets/images/banner.png'),
                ),

                Container(
                  child: Text(currentpostlabel, style: TextStyle(fontSize: 25),),
                ),

                Container(

                    child: Slider(
                      value: double.parse(currentpos.toString()),
                      min: 0,
                      max: double.parse(maxduration.toString()),
                      divisions: maxduration,
                      label: currentpostlabel,
                      onChanged: (double value) async {
                        int seekval = value.round();
                        int result = await player.seek(Duration(milliseconds: seekval));
                        if(result == 1){ //seek successful
                          currentpos = seekval;
                        }else{
                          print("Seek unsuccessful.");
                        }
                      },
                    )
                ),

                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30)
                  ),
                  child: Wrap(
                    spacing: 10,
                    children: [
                      ElevatedButton.icon(
                  style: ButtonStyle(
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18.0),
                    side: BorderSide(color: Colors.red)
                )
    )
    ),
                          onPressed: () async {
                            if(!isplaying && !audioplayed){
                              int result = await player.playBytes(audiobytes);
                              if(result == 1){ //play success
                                setState(() {
                                  isplaying = true;
                                  audioplayed = true;
                                });
                              }else{
                                print("Error while playing audio.");
                              }
                            }else if(audioplayed && !isplaying){
                              int result = await player.resume();
                              if(result == 1){ //resume success
                                setState(() {
                                  isplaying = true;
                                  audioplayed = true;
                                });
                              }else{
                                print("Error on resume audio.");
                              }
                            }else{
                              int result = await player.pause();
                              if(result == 1){ //pause success
                                setState(() {
                                  isplaying = false;
                                });
                              }else{
                                print("Error on pause audio.");
                              }
                            }
                          },
                          icon: Icon(isplaying?Icons.pause:Icons.play_arrow),
                          label:Text(isplaying?"Pause":"Play")
                      ),

                      ElevatedButton.icon(
                          style: ButtonStyle(
                              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(18.0),
                                      side: BorderSide(color: Colors.red)
                                  )
                              )

                          ),
                          onPressed: () async {
                            int result = await player.stop();
                            if(result == 1){ //stop success
                              setState(() {
                                isplaying = false;
                                audioplayed = false;
                                currentpos = 0;
                              });
                            }else{
                              print("Error on stop audio.");
                            }
                          },
                          icon: Icon(Icons.stop),
                          label:Text("Stop")
                      ),
                    ],
                  ),
                )

              ],
            )

        )
    );
  }
}

