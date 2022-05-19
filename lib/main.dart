import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rosary/day.dart';


void main() {
  runApp(Home());
}
class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late String day;
  var days ={'Monday':'joyful',
             'Tuesday':'sorrowful',
             'Wednesday':'glorious',
             'Thursday':'luminous',
             'Friday':'sorrowful',
             'Saturday':'joyful',
             'Sunday':'glorious',
             'Divine Mercy': 'divine mercy'};
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme:
        ThemeData(primarySwatch: Colors.teal, brightness: Brightness.light),
        debugShowCheckedModeBanner: false,
        color: Colors.teal[100],

        home: Scaffold(
          backgroundColor: Colors.teal,
            appBar: PreferredSize(
              preferredSize: Size.fromHeight(100),
              child: AppBar(
                title: Center(
                  child:Text("ROSARY DAILY",style: TextStyle(color: Colors.teal) ,
                ),),
                backgroundColor: Colors.teal[100],
                bottomOpacity: 0.4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.vertical(
                    bottom: Radius.circular(30),
                  ),
                ),
              ),),
         body: SafeArea(
         child: GridView.count(

           crossAxisSpacing: 20,
          mainAxisSpacing: 10,
         padding: EdgeInsets.all(30),
          crossAxisCount: 2,
          children: [
            Day(day: "Monday",mystery: '${days['Monday']}'),
            Day(day: "Tuesday",mystery: '${days['Tuesday']}'),
            Day(day: "Wednesday",mystery: '${days['Wednesday']}'),
            Day(day: "Thursday",mystery: '${days['Thursday']}'),
            Day(day: "Friday",mystery: '${days['Friday']}'),
            Day(day: "Saturday",mystery: '${days['Saturday']}'),
            Day(day: "Sunday",mystery: '${days['Sunday']}'),
            Day(day: "Divine Mercy",mystery: '${days['Divine Mercy']}'),

          ],
         )
)

      )


    );
  }
}
