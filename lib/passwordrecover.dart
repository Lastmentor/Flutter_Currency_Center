import 'package:flutter/material.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server/gmail.dart';

class Revocer extends StatefulWidget {

  final List tempPasswordRecover,temp;

  Revocer({Key key, this.tempPasswordRecover, this.temp}) : super(key: key);

  @override
  _RevocerState createState() => _RevocerState();
}

class _RevocerState extends State<Revocer> {

  final _emailtextfield = new TextEditingController();

  void _recoverPassword(){
    if(_emailtextfield.text[_emailtextfield.text.length - 1] == " "){
      _emailtextfield.text = _emailtextfield.text.substring(0,_emailtextfield.text.length - 1);
    }
    if(widget.tempPasswordRecover.contains(_emailtextfield.text)){
      var index = widget.tempPasswordRecover.indexOf(_emailtextfield.text);
      var email = _emailtextfield.text;
      setState(() {
        _emailtextfield.text = "";
      });
      _doneDialog();
      _send(index,email);
    }
    else{
      setState(() {
        _emailtextfield.text = "";
      });
      _errorDialog();
    }
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
                new Text("Check Your Email Address",style: new TextStyle(color: const Color(0xFF75AE5F),fontSize: 21.0,fontFamily: 'Lobster')),
                new Padding(padding: const EdgeInsets.only(top: 25.0)),
                new Container(
                  width: 150,
                  height: 50,
                  child: new RaisedButton(
                    onPressed: () => Navigator.of(context).pop(),
                    child: new Text("Close",style: new TextStyle(color: Colors.white,fontSize: 23.0,fontFamily: 'Lobster')),
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

  void _errorDialog(){
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
                new Icon(Icons.warning,color: const Color(0xFF75AE5F),size: 80,),
                new Padding(padding: const EdgeInsets.only(top: 20.0)),
                new Text("Email Not Founded",style: new TextStyle(color: const Color(0xFF75AE5F),fontSize: 25.0,fontFamily: 'Lobster')),
                new Padding(padding: const EdgeInsets.only(top: 25.0)),
                new Container(
                  width: 150,
                  height: 50,
                  child: new RaisedButton(
                    onPressed: () => Navigator.of(context).pop(),
                    child: new Text("Close",style: new TextStyle(color: Colors.white,fontSize: 23.0,fontFamily: 'Lobster')),
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

  _send(int index, String email) async {
    String username = 'your gmail email address';
    String password = 'gmail password';

    final smtpServer = gmail(username, password);

    // Create our message.
    final message = new Message()
      ..from = new Address(username, 'Lastmentor')
      ..recipients.add(email)
      ..subject = 'Flutter Currency Center'
      ..text = 'This is the plain text.\nThis is line 2 of the text part.'
      ..html = "<h2>Password Recover Request</h2>\n<p>Your Password : ${widget.temp[index]}</p>";

    final sendReports = await send(message, smtpServer);

    print(sendReports);
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
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
                  new Padding(padding: const EdgeInsets.all(20.0)),
                  new Image(image: new AssetImage("images/logo.png"),width:120,height: 170),
                  new Text(
                    "Flutter Currency Center",
                    style: new TextStyle(color: const Color(0xFFFFFFFF), fontSize: 31.0,fontFamily: 'Lobster'),
                    textAlign: TextAlign.center,
                  ),
                  new Padding(padding: const EdgeInsets.all(15.0)),
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
                    child: new RaisedButton(
                      onPressed: _recoverPassword,
                      child: new Text("Recover Password",style: new TextStyle(color: Colors.white,fontSize: 25.0,fontFamily: 'Lobster')),
                      color: const Color(0xFF75AE5F),
                      shape: new RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(30.0)
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        )
    );
  }
}
