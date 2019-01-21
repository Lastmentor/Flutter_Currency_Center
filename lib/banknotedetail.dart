import 'dart:async';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_currency/fullscreen.dart';

class MoneyDetail extends StatefulWidget {

  final String codepath;
  MoneyDetail(this.codepath);

  @override
  _MoneyDetailState createState() => _MoneyDetailState();
}

class _MoneyDetailState extends State<MoneyDetail> {

  List showImages;

  StreamSubscription<QuerySnapshot> subscription;
  List<DocumentSnapshot> wallpapersList;
  final CollectionReference collectionReference = Firestore.instance.collection("BankNotes");

  @override
  void initState() {
    super.initState();
    subscription = collectionReference.snapshots().listen((datasnapshot) {
      setState(() {
        wallpapersList = datasnapshot.documents;
        loadImages();
      });
    });
  }

  @override
  void dispose() {
    subscription?.cancel();
    super.dispose();
  }

  void loadImages(){
    showImages = new List();
    for(int i=0;i<wallpapersList.length;i++){
      if(wallpapersList[i].data['BanknoteName'] == widget.codepath){
        for(int j = 0; j < wallpapersList[i].data.length - 1; j++){
          showImages.add(wallpapersList[i].data[j.toString()]);
        }
        break;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0d3645),
      appBar: new AppBar(
        backgroundColor: const Color(0xFF0d3645),
        centerTitle: true,
        title: new Text("${widget.codepath}",style: new TextStyle(fontFamily: 'Lobster',fontSize: 25),),
      ),
      body: showImages != null
          ?
      new ListView.builder(
          itemCount: showImages.length,
          itemBuilder: (context, i){
            return new Center(
              child: new Column(
                children: <Widget>[
                  new Padding(padding: EdgeInsets.only(top: 10)),
                  new Container(
                    height: 250,
                    width: 250,
                    child: new GestureDetector(
                      child: new FadeInImage(
                          placeholder: new AssetImage("images/placeh.png"),
                          image: new NetworkImage(showImages[i])),
                      onTap: () => Navigator.push(context, new MaterialPageRoute(builder: (context) => new ImagePage(showImages[i]))),
                    ),
                  ),
                  new Padding(padding: EdgeInsets.only(bottom: 10)),
                ],
              ),
            );
          })
          :
      new Center(
          child: new SizedBox(
            height: 90,
            width: 90,
            child: new CircularProgressIndicator(
                valueColor: new AlwaysStoppedAnimation<Color>(const Color(0xFFFFFFFF))
            ),
          )
      ),
    );
  }
}
