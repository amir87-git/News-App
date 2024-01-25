import 'package:flutter/material.dart';

class LandingPage extends StatefulWidget {
  const LandingPage({super.key});

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(child: Column(children: [
        Material(
          elevation: 3,
          borderRadius: BorderRadius.circular(20),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(15),
            child: Image.asset(
              "images/h.jpg",
              height: MediaQuery.of(context).size.width,
              width: MediaQuery.of(context).size.height/1.8,
              fit: BoxFit.cover),
          ),
        ),


        SizedBox(height: 20,),
        Text("News around the world!", style: TextStyle(color: Colors.black, fontSize: 15, fontWeight: FontWeight.bold),),

        SizedBox(height: 20,),
        Text("Best time to read, explore the world", style: TextStyle(color: Colors.black54, fontSize: 12, fontWeight: FontWeight.w300),),


        SizedBox(height: 40,),
        Container(
          width: MediaQuery.of(context).size.width/1.4,
          child: Material(
            borderRadius: BorderRadius.circular(20),
            elevation: 5,
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 20),
              
              decoration: BoxDecoration(color: Colors.blue, borderRadius: BorderRadius.circular(20)),
              child: Center(child: Text("Get Strated", style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.normal),)),
            ),
          ),
        )

      ],),),
    );
  }
}