import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'detail.dart';

class Day extends StatefulWidget {
  final String day;
  final String mystery;
  const Day({Key? key,required this.day,required this.mystery}) : super(key: key);

  @override
  State<Day> createState() => _DayState();
}

class _DayState extends State<Day> {
  @override
  Widget build(BuildContext context) {
    return (
      GestureDetector(
          child: Container(
            padding: const EdgeInsets.all(8),
            child: Center(
              child: Text('${widget.day}',style: TextStyle(fontSize: 20,color: Colors.teal)),

            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.teal[100],

            ),

          ),
          onTap : (){
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => Detail(text: widget.mystery,),
                ));
          }
      )
    );
  }
}
