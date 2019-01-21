import 'package:flutter/material.dart';

class About extends StatefulWidget {
  @override
  _AboutState createState() => _AboutState();
}

class _AboutState extends State<About> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        backgroundColor: const Color(0xFF0d3645),
        appBar: new AppBar(
          backgroundColor: const Color(0xFF0d3645),
          title: new Text("About This App",style: new TextStyle(fontFamily: 'Lobster',fontSize: 25),),
          centerTitle: true,
        ),
        body: new ListView(
            children: <Widget>[
              new Center(
                child: new Column(
                  children: <Widget>[
                    new Padding(padding: const EdgeInsets.all(25.0)),
                    new Image(
                      image: new AssetImage("images/logo.png"),width: 128.0,height: 170.0,
                    ),
                    new Text(
                      'Flutter Currency Center',
                      style: TextStyle(fontSize: 31.0, color: const Color(0xFF75AE5F),fontFamily: 'Lobster'),textAlign: TextAlign.center,
                    ),
                    new Padding(padding: const EdgeInsets.only(top: 18.0)),
                    new Text(
                      'With Flutter Currency Center you can check currency rates, exchange money and see banknotes.',
                      style: TextStyle(fontSize: 20, color: Colors.white, fontFamily: 'Lobster'),textAlign: TextAlign.center,
                    ),
                  ],
                ),
              )
            ],
          )
    );
  }
}
