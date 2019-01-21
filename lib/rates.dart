import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

class Rates extends StatefulWidget {

  final String accountBaseCode;

  Rates({Key key, this.accountBaseCode}) : super(key: key);

  @override
  _RatesState createState() => _RatesState();
}

class _RatesState extends State<Rates> {

  List _showCurrencyName;
  List _showCurrencyRate;
  List _currencyCode = ["eur","gbp","usd","jpy","aud","cad","kwd","try","rub","cny","uah","dkk","czk","ron","nok","sek","chf","inr",
  "brl","clp","hkd","huf","idr","ils","krw","myr","mxn","nzd","pln","sgd"];

  var tempUpperCode;
  var tempLastUpdated;

  Future<String> getData() async {

    var index = _currencyCode.indexOf("${widget.accountBaseCode}");
    print(widget.accountBaseCode);
    _currencyCode.removeAt(index);

    var response = await http.get(
        Uri.encodeFull("http://www.floatrates.com/daily/" + "${widget.accountBaseCode}" + ".json"),
        headers: {
          "Accept": "application/json"
        }
    );

    this.setState(() {
      _showCurrencyName = new List();
      _showCurrencyRate = new List();
      try {
        var res = json.decode(response.body);
        for(int i=0;i<_currencyCode.length;i++){
          var _tempName = res[_currencyCode[i]]["name"];
          var _tempRate = res[_currencyCode[i]]["rate"].toString();
          int decimal = _tempRate.indexOf('.');
          _showCurrencyName.add(_tempName);
          _showCurrencyRate.add(_tempRate.substring(0,decimal+3));
        }
        tempLastUpdated = res[_currencyCode[0]]["date"];
        _updatedDialog();
      }catch(e) {
        _currencyCode.add(widget.accountBaseCode);
        getData();
      }
    });

    return "Success!";
  }

  Future<String> getDataRefresh() async {
    setState(() {
      _currencyCode = ["eur","gbp","usd","jpy","aud","cad","kwd","try","rub","cny","uah","dkk","czk","ron","nok","sek","chf","inr",
      "brl","clp","hkd","huf","idr","ils","krw","myr","mxn","nzd","pln","sgd"];
      tempUpperCode = widget.accountBaseCode.toUpperCase();
    });
    getData();
    return "Success!";
  }

  @override
  void initState() {
    this.getData();
    tempUpperCode = widget.accountBaseCode.toUpperCase();
  }

  Widget _baseApp(){
    return new ListView.builder(
        itemCount: _showCurrencyName == null ? 0 : _showCurrencyName.length,
        itemBuilder: (context,i) {
          return new Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: new Container(
              height: 130.0,
              child: new Stack(
                children: <Widget>[
                  new Positioned(
                    right: 0.0,
                    child: new Container(
                      width: 282.0,
                      height: 130.0,
                      child: new Card(
                        color: const Color(0xFF254a57),
                        child: new Padding(
                          padding: const EdgeInsets.only(
                            top: 8.0,
                            bottom: 8.0,
                            left: 58.0,
                          ),
                          child: new Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: <Widget>[
                              new Text(_showCurrencyName[i],style: new TextStyle(color: Colors.white,fontSize: 21,fontFamily: 'Lobster')),
                              new Text("1 "  + tempUpperCode + " = " + _showCurrencyRate[i],style: new TextStyle(color: Colors.white,fontSize: 18,fontFamily: 'Lobster'))
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  new Positioned(
                      top: 14.5,
                      child: new Container(
                        width: 100.0,
                        height: 100.0,
                        decoration: new BoxDecoration(
                          shape: BoxShape.circle,
                          image: new DecorationImage(
                            fit: BoxFit.cover,
                            image: new AssetImage("images/" + _currencyCode[i] + ".png"),
                          ),
                        ),
                      )
                  ),
                ],
              ),
            ),
          );
        }
    );
  }

  Future _updatedDialog() async {
    await Future.delayed(Duration(milliseconds: 500));
    showDialog(context: context, barrierDismissible: false, child: new Dialog(
        child:  new Container(
          width: 250.0,
          height: 325.0,
          decoration: new BoxDecoration(
            color: Colors.white,
            border: new Border.all(color: Colors.white),
          ),
          child: new Center(
            child: new Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                new Icon(Icons.access_alarm,color: const Color(0xFF75AE5F),size: 75,),
                new Padding(padding: const EdgeInsets.only(top: 20.0)),
                new Text("Updated At",style: new TextStyle(color: const Color(0xFF75AE5F),fontSize: 26.0,fontFamily: 'Lobster')),
                new Padding(padding: const EdgeInsets.only(top: 25.0)),
                new Text(tempLastUpdated,style: new TextStyle(color: const Color(0xFF75AE5F),fontSize: 18.0,fontFamily: 'Lobster')),
                new Padding(padding: const EdgeInsets.only(top: 25.0)),
                new Container(
                  width: 135,
                  height: 50,
                  child: new RaisedButton(
                    onPressed: () => Navigator.of(context).pop(),
                    child: new Text("Okay",style: new TextStyle(color: Colors.white,fontSize: 24.0,fontFamily: 'Lobster')),
                    color: const Color(0xFF75AE5F),
                    shape: new RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(30.0)
                    ),
                  ),
                )
              ],
            ),
          ),
        )
    ),);
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      backgroundColor: const Color(0xFF0d3645),
      body: new RefreshIndicator(
          child: _showCurrencyName != null ?
          _baseApp() : new Center(
              child: new SizedBox(
                height: 90,
                width: 90,
                child: new CircularProgressIndicator(
                    valueColor: new AlwaysStoppedAnimation<Color>(const Color(0xFFFFFFFF))
                ),
              )
          ),
          onRefresh: getDataRefresh
      )
    );
  }
}
