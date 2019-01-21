import 'dart:io';
import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {

  List _currencyCode = ["eur","gbp","usd","jpy","aud","cad","kwd","try","rub","cny","uah","dkk","czk","ron","nok","sek","chf","inr",
  "brl","clp","hkd","huf","idr","ils","krw","myr","mxn","nzd","pln","sgd"];

  var _tempCurrency = "Add Base Currency";

  bool checkUpload = false;

  final DocumentReference documentReference = Firestore.instance.collection('Accounts').document();

  File _image;

  Future getImage() async {
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);

    setState(() {
      _image = image;
    });
  }

  void _addData() async {
    if(_emailtextfield.text != "" && _passwordtextfield.text != "" && _usernametextfield.text != "" && _repeatpasswordtextfield.text != "" && _tempCurrency != "Add Base Currency"){
      if(_passwordtextfield.text == _repeatpasswordtextfield.text){

        if(_emailtextfield.text[_emailtextfield.text.length - 1] == " "){
          _emailtextfield.text = _emailtextfield.text.substring(0,_emailtextfield.text.length - 1);
        }

        if(_usernametextfield.text[_usernametextfield.text.length - 1] == " "){
          _usernametextfield.text = _usernametextfield.text.substring(0,_usernametextfield.text.length - 1);
        }

        if(_passwordtextfield.text[_passwordtextfield.text.length - 1] == " "){
          _passwordtextfield.text = _passwordtextfield.text.substring(0,_passwordtextfield.text.length - 1);
        }

        if(_repeatpasswordtextfield.text[_repeatpasswordtextfield.text.length - 1] == " "){
          _repeatpasswordtextfield.text = _repeatpasswordtextfield.text.substring(0,_repeatpasswordtextfield.text.length - 1);
        }

        _uploadDialog();

        String tempImage;

        if(_image == null){
          tempImage = "https://cdn2.iconfinder.com/data/icons/halloween-ghosts/256/Ghost_6-512.png";
        }else{
          final String rand1 = "${new Random().nextInt(10000)}";
          final String rand2 = "${new Random().nextInt(10000)}";
          final String rand3 = "${new Random().nextInt(10000)}";
          final StorageReference ref = FirebaseStorage.instance.ref().child('${rand1}_${rand2}_${rand3}.jpg');
          final StorageUploadTask uploadTask = ref.put(_image);
          final Uri downloadUrl = (await uploadTask.future).downloadUrl;
          tempImage = downloadUrl.toString();
        }

        documentReference.setData({ 'CurrencyCode': _tempCurrency, 'Email': _emailtextfield.text, 'Password': _passwordtextfield.text, 'Photo': tempImage , 'Username': _usernametextfield.text});

        _doneDialog();

        setState(() {
          _emailtextfield.text = "";
          _passwordtextfield.text = "";
          _usernametextfield.text = "";
          _repeatpasswordtextfield.text = "";
          _tempCurrency = "Add Base Currency";
          _image = null;
        });
      }else{
        _alertDialog2();
      }
    }else {
      _alertDialog();
    }
  }

  void _uploadDialog() {
    if(checkUpload == false){
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
                  new SizedBox(
                    child: new CircularProgressIndicator(
                      valueColor: new AlwaysStoppedAnimation<Color>(const Color(0xFF75AE5F)),
                    ),
                    height: 75.0,
                    width: 75.0,
                  ),
                  new Padding(padding: const EdgeInsets.only(top: 17.0)),
                  new Text("Account Creating ...",style: new TextStyle(color: const Color(0xFF75AE5F),fontSize: 25.0,fontFamily: 'Lobster')),
                ],
              ),
            ),
          )
      ),);
    }
    else {
      Navigator.of(context).pop();
      checkUpload = false;
    }
  }

  void _doneDialog(){
    setState((){
      checkUpload = true;
    });
    _uploadDialog();
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
                new Text("Successfully Created!",style: new TextStyle(color: const Color(0xFF75AE5F),fontSize: 25.0,fontFamily: 'Lobster')),
                new Padding(padding: const EdgeInsets.only(top: 25.0)),
                new Container(
                  width: 150,
                  height: 50,
                  child: new RaisedButton(
                    onPressed: () => Navigator.of(context).pop(),
                    child: new Text("Close",style: new TextStyle(color: Colors.white,fontSize: 25.0,fontFamily: 'Lobster')),
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

  void _alertDialog(){
    AlertDialog dialog = new AlertDialog(
      content: new Text("Fill All The Lines",textAlign: TextAlign.center,style: new TextStyle(fontFamily: 'Lobster',fontSize: 21),),
      actions: <Widget>[
        new FlatButton(onPressed: () => Navigator.of(context).pop(), child: new Text("OK",style: new TextStyle(fontFamily: 'Lobster',fontSize: 20))),
      ],
    );
    showDialog(context: context, child: dialog);
  }

  void _alertDialog2(){
    AlertDialog dialog = new AlertDialog(
      content: new Text("Passwords Are Not Same",textAlign: TextAlign.center,style: new TextStyle(fontFamily: 'Lobster',fontSize: 21)),
      actions: <Widget>[
        new FlatButton(onPressed: () => Navigator.of(context).pop(), child: new Text("OK",style: new TextStyle(fontFamily: 'Lobster',fontSize: 20),)),
      ],
    );
    showDialog(context: context, child: dialog);
  }

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
      _tempCurrency = _currencyCode[i];
    });
  }

  final _emailtextfield = new TextEditingController();
  final _usernametextfield = new TextEditingController();
  final _passwordtextfield = new TextEditingController();
  final _repeatpasswordtextfield = new TextEditingController();

  final FocusNode _emailFocus = FocusNode();
  final FocusNode _usernameFocus = FocusNode();
  final FocusNode _passwordFocus = FocusNode();
  final FocusNode _repeatpasswordFocus = FocusNode();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xFF0d3645),
        body: new ListView(
          children: <Widget>[
            new Row(
              children: <Widget>[
                new IconButton(
                    icon: new Icon(
                      Icons.arrow_back_ios,
                      size: 35.0,
                      color: Colors.white,
                    ),
                    onPressed: () {
                      Navigator.of(context).pop();
                    }),
              ],
            ),
            new Center(
              child: new Column(
                children: <Widget>[
                  new Container(
                    width: 110.0,
                    height: 110.0,
                    child: _image == null
                        ? new DecoratedBox(
                        decoration: BoxDecoration(
                          border: new Border.all(
                              color: const Color(0xFF75AE5F), width: 2.0),
                          color: const Color(0xFF0a2b37),
                        ))
                        : new Image.file(_image,fit: BoxFit.cover,),
                  ),
                  new Padding(padding: const EdgeInsets.all(7.0)),
                  new Container(
                    width: 140.0,
                    height: 45.0,
                    child: new RaisedButton(
                      onPressed: getImage,
                      child: new Text("Add Image",
                          style: new TextStyle(
                              color: Colors.white, fontSize: 19.0,fontFamily: 'Lobster')),
                      color: const Color(0xFF75AE5F),
                      shape: new RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(30.0)),
                    ),
                  ),
                  new Padding(padding: const EdgeInsets.all(7.0)),

                  new Container(
                    width: 225.0,
                    height: 45.0,
                    child: new RaisedButton(
                      onPressed: _baseCurrency,
                      child: new Text("$_tempCurrency",
                          style: new TextStyle(
                              color: Colors.white, fontSize: 19.0,fontFamily: 'Lobster')),
                      color: const Color(0xFF75AE5F),
                      shape: new RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(30.0)),
                    ),
                  ),
                  new Padding(padding: const EdgeInsets.all(7.0)),

                  new Container(
                    width: 300.0,
                    height: 55.0,
                    child: new DecoratedBox(
                      decoration: new BoxDecoration(
                        borderRadius: new BorderRadius.all(
                            new Radius.circular(50.0)),
                        color: const Color(0xFF254a57),
                      ),
                      child: new ListTile(
                        leading: const Icon(Icons.mail,
                            color: Colors.white),
                        title: new TextField(
                          onSubmitted: (term) {
                            FocusScope.of(context).requestFocus(_usernameFocus);
                          },
                          focusNode: _emailFocus,
                          textInputAction: TextInputAction.next,
                          controller: _emailtextfield,
                          style: new TextStyle(
                            color: Colors.white,
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold
                          ),
                          decoration: new InputDecoration(
                            border: InputBorder.none,
                            hintText: "Email",
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
                        borderRadius: new BorderRadius.all(
                            new Radius.circular(50.0)),
                        color: const Color(0xFF254a57),
                      ),
                      child: new ListTile(
                        leading: const Icon(Icons.person,
                            color: Colors.white),
                        title: new TextField(
                          onSubmitted: (term) {
                            FocusScope.of(context).requestFocus(_passwordFocus);
                          },
                          focusNode: _usernameFocus,
                          textInputAction: TextInputAction.next,
                          controller: _usernametextfield,
                          style: new TextStyle(
                            color: Colors.white,
                            fontSize: 16.0,
                              fontWeight: FontWeight.bold
                          ),
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
                        borderRadius: new BorderRadius.all(
                            new Radius.circular(50.0)),
                        color: const Color(0xFF254a57),
                      ),
                      child: new ListTile(
                        leading: const Icon(Icons.lock,
                            color: Colors.white),
                        title: new TextField(
                          onSubmitted: (term) {
                            FocusScope.of(context).requestFocus(_repeatpasswordFocus);
                          },
                          focusNode: _passwordFocus,
                          textInputAction: TextInputAction.next,
                          controller: _passwordtextfield,
                          style: new TextStyle(
                            color: Colors.white,
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold
                          ),
                          decoration: new InputDecoration(
                            border: InputBorder.none,
                            hintText: "Password",
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
                        borderRadius: new BorderRadius.all(
                            new Radius.circular(50.0)),
                        color: const Color(0xFF254a57),
                      ),
                      child: new ListTile(
                        leading: const Icon(Icons.lock,
                            color: Colors.white),
                        title: new TextField(
                          onSubmitted: (term) {
                            _repeatpasswordFocus.unfocus();
                          },
                          focusNode: _repeatpasswordFocus,
                          textInputAction: TextInputAction.done,
                          controller: _repeatpasswordtextfield,
                          style: new TextStyle(
                            color: Colors.white,
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold
                          ),
                          decoration: new InputDecoration(
                            border: InputBorder.none,
                            hintText: "Repeat Password",
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
                    child: new RaisedButton(
                      onPressed: _addData,
                      child: new Text("Create Account",style: new TextStyle(color: Colors.white,fontSize: 25.0,fontFamily: 'Lobster')),
                      color: const Color(0xFF75AE5F),
                      shape: new RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(30.0)
                      ),
                    ),
                  ),
                  new Padding(padding: const EdgeInsets.all(5.0)),
                ],
              ),
            )
          ],
        )
    );
  }
}
