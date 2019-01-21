import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

class Exchange extends StatefulWidget {
  @override
  _ExchangeState createState() => _ExchangeState();
}

class _ExchangeState extends State<Exchange> {

  List _currencyCode = ["eur","gbp","usd","jpy","aud","cad","kwd","try","rub","cny","uah","dkk","czk","ron","nok","sek","chf","inr",
  "brl","clp","hkd","huf","idr","ils","krw","myr","mxn","nzd","pln","sgd"];

  double _tempTargetValue = 0;
  double _tempTargetValue2 = 0;
  var makeint;

  var _fromCurrency = "usd";
  var _fromCurrencyText = "USD";

  var _toCurrency = "aud";
  var _toCurrencyText = "AUD";

  var _tempReverseImage = "";
  var _tempReverseText = "";

  bool checkUpload = false;

  final _productCurrency = new TextEditingController();

  void _baseCurrency() {
    showDialog(context: context, child: new Dialog(
        child: new ListView.builder(
            itemCount: _currencyCode.length,
            itemBuilder: (context,i) {
              return new Padding(
                  padding: EdgeInsets.all(15),
                  child: new GestureDetector(
                    onTap: () => _targetCurrency(i),
                    child: new Container(
                      width: 130,
                      height: 130,
                      decoration: new BoxDecoration(
                        shape: BoxShape.circle,
                        image: new DecorationImage(
                          fit: BoxFit.contain,
                          image: new AssetImage("images/" + _currencyCode[i] + ".png"),
                        ),
                      ),
                    ),
                  )
              );
            }
        )
    ));
  }

  void _targetCurrency(int i){
    Navigator.of(context).pop();
    setState((){
      _fromCurrency = _currencyCode[i];
      _fromCurrencyText = _fromCurrency.toUpperCase();
      _productCurrency.text = "";
      _tempTargetValue2 = 0;
      getData();
    });
  }

  void _toBaseCurrency() {
    showDialog(context: context, child: new Dialog(
        child: new ListView.builder(
            itemCount: _currencyCode.length,
            itemBuilder: (context,i) {
              return new Padding(
                  padding: EdgeInsets.all(15),
                  child: new GestureDetector(
                    onTap: () => _targetToCurrency(i),
                    child: new Container(
                      width: 130,
                      height: 130,
                      decoration: new BoxDecoration(
                        shape: BoxShape.circle,
                        image: new DecorationImage(
                          fit: BoxFit.contain,
                          image: new AssetImage("images/" + _currencyCode[i] + ".png"),
                        ),
                      ),
                    ),
                  )
              );
            }
        )
    ));
  }

  void _targetToCurrency(int i){
    Navigator.of(context).pop();
    setState((){
      _toCurrency = _currencyCode[i];
      _toCurrencyText = _toCurrency.toUpperCase();
      _productCurrency.text = "";
      _tempTargetValue2 = 0;
      getData();
    });
  }

  void _reverseCurrency(){
    setState(() {
      _tempReverseImage = _toCurrency;
      _toCurrency = _fromCurrency;
      _fromCurrency = _tempReverseImage;
      _tempReverseText = _toCurrencyText;
      _toCurrencyText = _fromCurrencyText;
      _fromCurrencyText = _tempReverseText;
      _productCurrency.text = "";
      _tempTargetValue2 = 0;
      getData();
    });
  }

  void _alertDialog(){
    AlertDialog dialog = new AlertDialog(
      content: new Text("Can't Be Empty",textAlign: TextAlign.center,style: new TextStyle(fontFamily: 'Lobster',fontSize: 21),),
      actions: <Widget>[
        new FlatButton(onPressed: () => Navigator.of(context).pop(), child: new Text("OK",style: new TextStyle(fontFamily: 'Lobster',fontSize: 20))),
      ],
    );
    showDialog(context: context, child: dialog);
  }

  void makeCurrency() {
    if(_productCurrency.text != ""){
      setState(() {
        _tempTargetValue = double.parse(_productCurrency.text) * double.parse(makeint);
        var ala = _tempTargetValue.toString();
        int ala2 = ala.indexOf('.');
        var ala3 = ala.substring(ala2,ala.length);
        if(ala3.length > 3){
          var ala4 = ala.substring(0,ala2 + 3);
          _tempTargetValue2 = double.parse(ala4);
        }else{
          _tempTargetValue2 = _tempTargetValue;
        }
      });
    }else{
      _alertDialog();
    }
  }

  Future<String> getData() async {
    var response = await http.get(
        Uri.encodeFull("http://www.floatrates.com/daily/" + "$_fromCurrency" + ".json"),
        headers: {
          "Accept": "application/json"
        }
    );

    this.setState(() {
      try {
        var res = json.decode(response.body);
        var _tempRate = res["$_toCurrency"]["rate"].toString();
        int decimal = _tempRate.indexOf('.');
        var adwad = _tempRate.substring(0,decimal+4);
        makeint = adwad;
      }catch (e) {
        getData();
      }
    });

    return "Success!";
  }

  @override
  void initState() {
    this.getData();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: new ListView(
        children: <Widget>[
          new Center(
            child: new Column(
              children: <Widget>[
                new Padding(padding: const EdgeInsets.all(15.0)),
                new Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    new Column(
                      children: <Widget>[
                        new Text("From",style: new TextStyle(color: Colors.white,fontSize: 30,fontFamily: 'Lobster')),
                        new Padding(padding: const EdgeInsets.all(3.0)),
                        new GestureDetector(
                          child: new Image(image: new AssetImage("images/" + "$_fromCurrency" + ".png"),width: 70,height: 70),
                          onTap: _baseCurrency,
                        ),
                        new Padding(padding: const EdgeInsets.all(3.0)),
                        new Text("$_fromCurrencyText",style: new TextStyle(color: Colors.white,fontSize: 26,fontFamily: 'Lobster')),
                      ],
                    ),
                    new GestureDetector(
                      onTap: _reverseCurrency,
                      child: new Icon(Icons.autorenew,size: 50,color: Colors.white),
                    ),
                    new Column(
                      children: <Widget>[
                        new Text("To",style: new TextStyle(color: Colors.white,fontSize: 30,fontFamily: 'Lobster')),
                        new Padding(padding: const EdgeInsets.all(3.0)),
                        new GestureDetector(
                          child: new Image(image: new AssetImage("images/" + "$_toCurrency" + ".png"),width: 70,height: 70),
                          onTap: _toBaseCurrency,
                        ),
                        new Padding(padding: const EdgeInsets.all(3.0)),
                        new Text("$_toCurrencyText",style: new TextStyle(color: Colors.white,fontSize: 26,fontFamily: 'Lobster')),
                      ],
                    ),
                  ],
                ),
                new Padding(padding: const EdgeInsets.all(20.0)),
                new Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    new Column(
                      children: <Widget>[
                        new Container(
                          width: 140.0,
                          height: 60.0,
                          child: new DecoratedBox(
                            decoration: new BoxDecoration(
                              borderRadius: new BorderRadius.all(
                                  new Radius.circular(15.0)),
                              color: const Color(0xFF254a57),
                            ),
                            child: new ListTile(
                              title: new TextField(
                                controller: _productCurrency,
                                keyboardType: TextInputType.number,
                                style: new TextStyle(
                                    color: Colors.white,
                                    fontSize: 23.0,
                                    fontFamily: 'Lobster'
                                ),
                                decoration: new InputDecoration(
                                  border: InputBorder.none,
                                  hintText: "0.0",
                                  hintStyle: new TextStyle(color: Colors.white,fontFamily: 'Lobster'),
                                ),
                              ),
                            ),
                          ),
                        ),
                        new Padding(padding: const EdgeInsets.all(3.0)),
                        new Text("$_fromCurrencyText",style: new TextStyle(color: Colors.white,fontSize: 26,fontFamily: 'Lobster')),
                      ],
                    ),
                    new Column(
                      children: <Widget>[
                        new Container(
                          width: 140.0,
                          height: 60.0,
                          child: new DecoratedBox(
                              decoration: new BoxDecoration(
                                borderRadius: new BorderRadius.all(
                                    new Radius.circular(15.0)),
                                color: const Color(0xFF254a57),
                              ),
                              child: new Row(
                                children: <Widget>[
                                  new Padding(padding: const EdgeInsets.only(left: 15.0)),
                                  new Text("$_tempTargetValue2",style: new TextStyle(color: Colors.white,fontSize: 23,fontFamily: 'Lobster')),
                                ],
                              )
                          ),
                        ),
                        new Padding(padding: const EdgeInsets.all(3.0)),
                        new Text("$_toCurrencyText",style: new TextStyle(color: Colors.white,fontSize: 26,fontFamily: 'Lobster')),
                      ],
                    )
                  ],
                ),
                new Padding(padding: const EdgeInsets.all(20.0)),
                new Container(
                  width: 185.0,
                  height: 55.0,
                  child: new RaisedButton(
                    onPressed: makeCurrency,
                    child: new Text("CONVERT",style: new TextStyle(color: Colors.white,fontSize: 25.0,fontFamily: 'Lobster')),
                    color: const Color(0xFF75AE5F),
                    shape: new RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(15.0),
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
