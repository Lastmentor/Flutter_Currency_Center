import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_currency/About.dart';
import 'package:flutter_currency/banknotes.dart';
import 'package:flutter_currency/exchange.dart';
import 'package:flutter_currency/rates.dart';

class Menu extends StatefulWidget {

  final String accountPhoto, accountEmail, accountName, accountCode, accountDocID;

  Menu({Key key, this.accountPhoto, this.accountEmail, this.accountName, this.accountCode, this.accountDocID}) : super(key: key);

  @override
  _MenuState createState() => _MenuState();
}

class _MenuState extends State<Menu> {

  List _currencyCode = ["eur","gbp","usd","jpy","aud","cad","kwd","try","rub","cny","uah","dkk","czk","ron","nok","sek","chf","inr",
  "brl","clp","hkd","huf","idr","ils","krw","myr","mxn","nzd","pln","sgd"];

  int _selectedIndex = 0;
  String titleApp = "Rates";
  var temp;
  var tempCode;
  var quickImage;

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

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
      tempCode = _currencyCode[i];
      temp = new Image(image: new AssetImage("images/" + "$tempCode" + ".png"),width: 42,height: 42);
    });
    Firestore.instance.collection('Accounts').document(widget.accountDocID).updateData({ 'CurrencyCode': tempCode});
    _doneDialog();
  }

  void _doneDialog(){
    showDialog(context: context, barrierDismissible: false, child: new Dialog(
        child:  new Container(
          width: 250.0,
          height: 300.0,
          decoration: new BoxDecoration(
            color: Colors.white,
            border: new Border.all(color: Colors.white),
          ),
          child: new Center(
            child: new Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                new Icon(Icons.done_all,color: const Color(0xFF75AE5F),size: 80,),
                new Padding(padding: const EdgeInsets.only(top: 20.0)),
                new Text("Refresh Page",style: new TextStyle(color: const Color(0xFF75AE5F),fontSize: 21.0,fontFamily: 'Lobster')),
                new Padding(padding: const EdgeInsets.only(top: 25.0)),
                new Container(
                  width: 150,
                  height: 50,
                  child: new RaisedButton(
                    onPressed: () => Navigator.of(context).pop(),
                    child: new Text("Okay",style: new TextStyle(color: Colors.white,fontSize: 23.0,fontFamily: 'Lobster')),
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

  void _logoutDialog(){
    AlertDialog dialog = new AlertDialog(
      content: new Text("Are You Sure Want To Exit?",textAlign: TextAlign.center,style: new TextStyle(fontFamily: 'Lobster',fontSize: 20),),
      actions: <Widget>[
        new FlatButton(onPressed: _dubleBack, child: new Text("Yes",style: new TextStyle(fontFamily: 'Lobster',fontSize: 19))),
        new FlatButton(onPressed: _onPress2, child: new Text("No",style: new TextStyle(fontFamily: 'Lobster', fontSize: 19))),
      ],
    );
    showDialog(context: context, child: dialog, barrierDismissible: false);
  }

  void _dubleBack() {
    Navigator.of(context).pop();
    Navigator.of(context).pop();
    Navigator.of(context).pop();
  }

  void _onPress() {
    Navigator.of(context).pop();
  }

  void _onPress2() {
    Navigator.of(context).pop();
    Navigator.of(context).pop();
  }

  Widget _pageReturn(){
    if(_selectedIndex == 0){
      return new Rates(accountBaseCode: tempCode);
    }
    else if(_selectedIndex == 1){
      return new Exchange();
    }
    else{
      return new Banknotes();
    }
  }

  void _aboutPage() {
    Navigator.of(context).pop();
    Navigator.push(context, new MaterialPageRoute(builder: (context) => new About()));
  }

  @override
  void initState() {
    super.initState();
    tempCode = widget.accountCode;
    temp = new Image(image: new AssetImage("images/" + "$tempCode" + ".png"),width: 42,height: 42);

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: new AppBar(
        backgroundColor: const Color(0xFF0d3645),
        title: new Text("$titleApp",style: new TextStyle(fontFamily: 'Lobster',fontSize: 25),),
        centerTitle: true,
        actions: <Widget>[
          new Padding(padding: EdgeInsets.only(right: 10.0),
            child: new GestureDetector(
              child: temp,
                onTap: _baseCurrency,
            )
          )
        ],
        leading: new IconButton(
            icon: new Icon(Icons.sort,size: 35.0),
            onPressed: () => _scaffoldKey.currentState.openDrawer()
        ),
      ),
      backgroundColor: const Color(0xFF0d3645),
      body: _pageReturn(),
      drawer: new Drawer(
          child: new Container(
            decoration: new BoxDecoration(
              gradient: LinearGradient(colors: [
                const Color(0xFF203A43),
                const Color(0xFF2C5364),
              ]),
            ),
            child: new ListView(
              children: <Widget>[
                new Padding(padding: const EdgeInsets.all(15.0)),
                new Column(
                  children: <Widget>[
                    new Container(
                      height: 100.0,
                      width: 100.0,
                      decoration: new BoxDecoration(
                        borderRadius: new BorderRadius.circular(50.0),
                        border: new Border.all(
                          width: 2.0,
                          color: Colors.white,
                        ),
                      ),
                      child: new GestureDetector(onTap: null, child: new CircleAvatar(backgroundImage: new NetworkImage("${widget.accountPhoto}",),),),
                    ),
                    new Padding(padding: const EdgeInsets.all(5.0)),
                    new Text("${widget.accountName}",style: new TextStyle(fontWeight: FontWeight.bold, color: Colors.white,fontSize: 24,fontFamily: 'Lobster'),),
                    new Padding(padding: const EdgeInsets.all(5.0)),
                    new Text("${widget.accountEmail}",style: new TextStyle(color: Colors.white,fontSize: 19,fontFamily: 'Lobster'),),
                    new Padding(padding: const EdgeInsets.all(10.0)),
                  ],
                ),
                new Container(
                  height: 2,
                  color: Colors.white,
                ),
                new Padding(padding: const EdgeInsets.all(5.0)),
                new ListTile(
                  leading: new Icon(
                    Icons.euro_symbol,
                    color: Colors.green,
                    size: 28,
                  ),
                  title: new Text("Rates",style: new TextStyle(color: Colors.white,fontSize: 22,fontFamily: 'Lobster'),),
                  onTap: () {
                    _onPress();
                    setState(() {
                      _selectedIndex = 0;
                      titleApp = "Rates";
                    });
                  },
                ),
                new ListTile(
                  leading: new Icon(
                    Icons.account_balance,
                    color: Colors.green,
                    size: 28,
                  ),
                  title: new Text("Exchange",style: new TextStyle(color: Colors.white,fontFamily: 'Lobster',fontSize: 22),),
                  onTap: () {
                    _onPress();
                    setState(() {
                      _selectedIndex = 1;
                      titleApp = "Exchange";
                    });
                  },
                ),
                new ListTile(
                  leading: new Icon(
                    Icons.local_atm,
                    color: Colors.green,
                    size: 28,
                  ),
                  title: new Text("Banknotes",style: new TextStyle(color: Colors.white,fontFamily: 'Lobster',fontSize: 22),),
                  onTap: () {
                    _onPress();
                    setState(() {
                      _selectedIndex = 2;
                      titleApp = "Banknotes";
                    });
                  },
                ),
                new ListTile(
                  onTap: _aboutPage,
                  leading: new Icon(
                    Icons.info_outline,
                    color: Colors.green,
                    size: 28,
                  ),
                  title: new Text("About This App",style: new TextStyle(color: Colors.white,fontFamily: 'Lobster',fontSize: 22),),
                ),
                new Padding(padding: EdgeInsets.only(top: 15)),
                new Center(
                  child: new Column(
                    children: <Widget>[
                      new Container(
                        width: 120,
                        height: 50,
                        child: new RaisedButton(
                          onPressed: _logoutDialog,
                          child: new Text("Log Out",style: new TextStyle(color: Colors.white,fontSize: 22.0,fontFamily: 'Lobster')),
                          color: const Color(0xFF75AE5F),
                          shape: new RoundedRectangleBorder(
                              borderRadius: new BorderRadius.circular(15.0)
                          ),
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          )
      ),
    );
  }
}




