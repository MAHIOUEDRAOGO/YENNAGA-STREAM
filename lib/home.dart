import 'package:flutter/material.dart';

import '../login.dart';
class home extends StatefulWidget {
  const home({super.key});


  @override
  State<home> createState() => _homeState();
}

class _homeState extends State<home> {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery
        .of(context)
        .size
        .height;
    double width = MediaQuery
        .of(context)
        .size
        .width;
    return Scaffold(
      body: Stack(
        alignment: Alignment.center,
        children: [
      Container(
      child:
      Column(
      crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                width: width*0.25,
                height: height*0.25,
                color: Colors.black87,
              ),
              Container(
                width: width*0.25,
                height: height*0.25,
                color: Colors.black54,
              ),
              Container(
                width: width*0.25,
                height: height*0.25,
                color: Colors.black45,
              ),
              Container(
                width: width*0.25,
                height: height*0.25,
                color: Colors.black38,
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                width: width*0.25,
                height: height*0.25,
                color: Colors.black38,
              ),
              Container(
                width: width*0.25,
                height: height*0.25,
                color: Colors.black45,
              ),
              Container(
                width: width*0.25,
                height: height*0.25,
                color: Colors.black54,
              ),
              Container(
                width: width*0.25,
                height: height*0.25,
                color: Colors.black87,
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                width: width*0.25,
                height: height*0.25,
                color: Colors.black87,
              ),
              Container(
                width: width*0.25,
                height: height*0.25,
                color: Colors.black54,
              ),
              Container(
                width: width*0.25,
                height: height*0.25,
                color: Colors.black45,
              ),
              Container(
                width: width*0.25,
                height: height*0.25,
                color: Colors.black38,
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                width: width*0.25,
                height: height*0.25,
                color: Colors.black38,
              ),
              Container(
                width: width*0.25,
                height: height*0.25,
                color: Colors.black45,
              ),
              Container(
                width: width*0.25,
                height: height*0.25,
                color: Colors.black54,
              ),
              Container(
                width: width*0.25,
                height: height*0.25,
                color: Colors.black87,
              ),
            ],
          ),
        ],
      ),
    ),
          Container(
            width: 500,
            height: 300,
            child:
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text("YENNENGA",
                  style: TextStyle(fontWeight: FontWeight.bold,
                      color: Colors.red[900],
                      fontStyle: FontStyle.italic,
                      fontSize:50),
                ),
                Text("MOVIES",
                  style: TextStyle(fontWeight: FontWeight.bold,
                      color: Colors.red[900],
                      fontStyle: FontStyle.italic,
                      fontSize:50),
                ),
                Text("STREAM",
                  style: TextStyle(fontWeight: FontWeight.bold,
                      color: Colors.red[900],
                      fontStyle: FontStyle.italic,
                      fontSize:50),
                ),
                OutlinedButton(
                  onPressed: () {
                    Navigator.push(context,
                    MaterialPageRoute(builder: (context)=>LoginPage()));
                  },
                  style: OutlinedButton.styleFrom(
                    foregroundColor: Colors.red[900], // Couleur du texte et de l'icône
                    side: BorderSide(color: Colors.red, width: 2), // Couleur et largeur de la bordure
                  ),
                  child: Text("GET STARTED"),
                ),
              ],
            ),

          ),
        ],
      ),
    );
  }
}
