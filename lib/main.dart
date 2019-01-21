import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_currency/menu.dart';
import 'package:flutter_currency/passwordrecover.dart';
import 'package:flutter_currency/register.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Currency Center',
      theme: new ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Login(),
    );
  }
}

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {

  StreamSubscription<QuerySnapshot> subscription;
  List<DocumentSnapshot> wallpapersList;
  final CollectionReference collectionReference = Firestore.instance.collection("Accounts");

  final _usernametextfield = new TextEditingController();
  final _passwordtextfield = new TextEditingController();

  final FocusNode _usernameFocus = FocusNode();
  final FocusNode _passwordFocus = FocusNode();

  List passwordData;
  List tempPass;

  @override
  void initState() {
    super.initState();
    subscription = collectionReference.snapshots().listen((datasnapshot) {
      setState(() {
        wallpapersList = datasnapshot.documents;
      });
    });
  }

  @override
  void dispose() {
    subscription?.cancel();
    super.dispose();
  }

  void _alertDialog(){
    AlertDialog dialog = new AlertDialog(
      content: new Text("Username or Password Wrong",textAlign: TextAlign.center,style: new TextStyle(fontFamily: 'Lobster',fontSize: 20),),
      actions: <Widget>[
        new FlatButton(onPressed: () => Navigator.of(context).pop(), child: new Text("OK",style: new TextStyle(fontFamily: 'Lobster',fontSize: 20))),
      ],
    );
    showDialog(context: context, child: dialog);
  }

  void _accountLogin(){
    String photo,email,name,code,docID;
    bool tempLog = false;

    if(_usernametextfield.text[_usernametextfield.text.length - 1] == " "){
      _usernametextfield.text = _usernametextfield.text.substring(0,_usernametextfield.text.length - 1);
    }
    if(_passwordtextfield.text[_passwordtextfield.text.length - 1] == " "){
      _passwordtextfield.text = _passwordtextfield.text.substring(0,_passwordtextfield.text.length - 1);
    }

    String realAccount = _usernametextfield.text + _passwordtextfield.text;
    for(int i=0;i<wallpapersList.length;i++){
      String tempAccount = wallpapersList[i].data['Username'] + wallpapersList[i].data['Password'];
      if(realAccount == tempAccount){
        tempLog = true;
        photo = wallpapersList[i].data['Photo'];
        email = wallpapersList[i].data['Email'];
        name = wallpapersList[i].data['Username'];
        code = wallpapersList[i].data['CurrencyCode'];
        docID = wallpapersList[i].documentID;
        break;
      }
    }
    _usernametextfield.text = "";
    _passwordtextfield.text = "";
    tempLog == false ? _alertDialog() : Navigator.push(context, new MaterialPageRoute(builder: (context) => new Menu(accountPhoto:photo, accountEmail:email, accountName:name, accountCode: code, accountDocID: docID)));
  }

  void _recoverPassword() {
    passwordData = new List();
    tempPass = new List();
    for(int i=0;i<wallpapersList.length;i++){
      passwordData.add(wallpapersList[i].data['Email']);
      tempPass.add(wallpapersList[i].data['Password']);
    }
    Navigator.push(context, new MaterialPageRoute(builder: (context) => new Revocer(tempPasswordRecover:passwordData, temp:tempPass)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xFF0d3645),
        body: new ListView(
          children: <Widget>[
            new Column(
                children: <Widget>[
                  new Padding(padding: const EdgeInsets.all(10.0)),
                  new Image(image: new AssetImage("images/logo.png"),width:120,height: 170),
                  new Text(
                    "Flutter Currency Center",
                    style: new TextStyle(color: const Color(0xFFFFFFFF), fontSize: 31.0,fontFamily: 'Lobster'),
                    textAlign: TextAlign.center,
                  ),
                  new Padding(padding: const EdgeInsets.all(20.0)),
                  new Container(
                    width: 300.0,
                    height: 55.0,
                    child: new DecoratedBox(
                      decoration: new BoxDecoration(
                        borderRadius: new BorderRadius.all(new Radius.circular(50.0)),
                        color: const Color(0xFF254a57),
                      ),
                      child: new ListTile(
                        leading: const Icon(Icons.person,color: Colors.white),
                        title: new TextField(
                          onSubmitted: (term) {
                            FocusScope.of(context).requestFocus(_passwordFocus);
                          },
                          focusNode: _usernameFocus,
                          textInputAction: TextInputAction.next,
                          controller: _usernametextfield,
                          style: new TextStyle(color: Colors.white, fontSize: 16.0,fontWeight: FontWeight.bold),
                          decoration: new InputDecoration(
                            border: InputBorder.none,
                            hintText: "Username",
                            hintStyle: new TextStyle(color: Colors.white,fontFamily: 'LibreBaskerville'),
                          ),
                        ),
                      ),
                    ),
                  ),
                  new Padding(padding: const EdgeInsets.all(5.0)),
                  new Container(
                    width: 300.0,
                    height: 55.0,
                    child: new DecoratedBox(
                      decoration: new BoxDecoration(
                        borderRadius: new BorderRadius.all(new Radius.circular(50.0)),
                        color: const Color(0xFF254a57),
                      ),
                      child: new ListTile(
                        leading: const Icon(Icons.lock,color: Colors.white),
                        title: new TextField(
                          onSubmitted: (term) {
                            _passwordFocus.unfocus();
                          },
                          focusNode: _passwordFocus,
                          textInputAction: TextInputAction.done,
                          controller: _passwordtextfield,
                          style: new TextStyle(color: Colors.white, fontSize: 16.0,fontWeight: FontWeight.bold),
                          decoration: new InputDecoration(
                            border: InputBorder.none,
                            hintText: "Password",
                            hintStyle: new TextStyle(color: Colors.white,fontFamily: 'LibreBaskerville'),
                          ),
                          obscureText: true,
                        ),
                      ),
                    ),
                  ),
                  new Padding(padding: const EdgeInsets.all(5.0)),
                  new Container(
                    width: 300.0,
                    height: 55.0,
                    child: new RaisedButton(
                      onPressed: _accountLogin,
                      child: new Text("Let's Exchange",style: new TextStyle(color: Colors.white,fontSize: 25.0,fontFamily: 'Lobster')),
                      color: const Color(0xFF75AE5F),
                      shape: new RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(30.0)
                      ),
                    ),
                  ),
                  new Padding(padding: const EdgeInsets.all(8.0)),
                  new Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      new GestureDetector(
                        child: new Text(
                          "Forgot Password?",
                          style: new TextStyle(color: const Color(0xFFFFFFFF), fontSize: 20.0,fontFamily: 'Lobster'),
                          textAlign: TextAlign.center,
                        ),
                        onTap: _recoverPassword,
                      )
                    ],
                  ),
                  new Container(
                    height: MediaQuery.of(context).size.height * 0.12,
                    color: const Color(0xFF0d3645),
                    child: new Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: <Widget>[
                        new Text("Don't have an account?",style: new TextStyle(color: Colors.white,fontSize: 22.0,fontFamily: 'Lobster'),),
                        new GestureDetector(
                          onTap: () => Navigator.push(context, new MaterialPageRoute(builder: (context) => new Register())),
                          child:  new Text(
                              " Sign Up",
                              style: new TextStyle(color: const Color(0xFF75AE5F),fontWeight: FontWeight.bold,fontSize: 22.0,fontFamily: 'Lobster')
                          ),
                        )
                      ],
                    ),
                  ),
                  new Padding(padding: const EdgeInsets.all(3.0)),
                ],
              ),
          ],
        )
    );
  }
}



