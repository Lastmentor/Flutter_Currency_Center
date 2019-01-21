import 'package:flutter/material.dart';
import 'package:flutter_currency/banknotedetail.dart';

class Banknotes extends StatefulWidget {
  @override
  _BanknotesState createState() => _BanknotesState();
}

class _BanknotesState extends State<Banknotes> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0d3645),
      body: new ListView(
        children: <Widget>[
          new Center(
            child: new Column(
              children: <Widget>[
                new Padding(padding: const EdgeInsets.all(15.0)),
                // Done
                new Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    new GestureDetector(
                      child: new Image(image: new AssetImage("images/eur.png"),width: 75,height: 75),
                      onTap: () => Navigator.push(context, new MaterialPageRoute(builder: (context) => new MoneyDetail("Euro"))),
                    ),
                    new GestureDetector(
                      child: new Image(image: new AssetImage("images/gbp.png"),width: 75,height: 75),
                      onTap: () => Navigator.push(context, new MaterialPageRoute(builder: (context) => new MoneyDetail("United Kingdom"))),
                    ),
                    new GestureDetector(
                      child: new Image(image: new AssetImage("images/usd.png"),width: 75,height: 75),
                      onTap: () => Navigator.push(context, new MaterialPageRoute(builder: (context) => new MoneyDetail("American"))),
                    ),
                  ],
                ),
                new Padding(padding: const EdgeInsets.all(15.0)),
                // Done
                new Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    new GestureDetector(
                      child: new Image(image: new AssetImage("images/jpy.png"),width: 75,height: 75),
                      onTap: () => Navigator.push(context, new MaterialPageRoute(builder: (context) => new MoneyDetail("Japan"))),
                    ),
                    new GestureDetector(
                      child: new Image(image: new AssetImage("images/aud.png"),width: 75,height: 75),
                      onTap: () => Navigator.push(context, new MaterialPageRoute(builder: (context) => new MoneyDetail("Australia"))),
                    ),
                    new GestureDetector(
                      child: new Image(image: new AssetImage("images/cad.png"),width: 75,height: 75),
                      onTap: () => Navigator.push(context, new MaterialPageRoute(builder: (context) => new MoneyDetail("Canadian"))),
                    ),
                  ],
                ),
                new Padding(padding: const EdgeInsets.all(15.0)),
                // Done
                new Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    new GestureDetector(
                      child: new Image(image: new AssetImage("images/kwd.png"),width: 75,height: 75),
                      onTap: () => Navigator.push(context, new MaterialPageRoute(builder: (context) => new MoneyDetail("Kuwaiti"))),
                    ),
                    new GestureDetector(
                      child: new Image(image: new AssetImage("images/try.png"),width: 75,height: 75),
                      onTap: () => Navigator.push(context, new MaterialPageRoute(builder: (context) => new MoneyDetail("Turkey"))),
                    ),
                    new GestureDetector(
                      child: new Image(image: new AssetImage("images/rub.png"),width: 75,height: 75),
                      onTap: () => Navigator.push(context, new MaterialPageRoute(builder: (context) => new MoneyDetail("Russian"))),
                    ),
                  ],
                ),
                new Padding(padding: const EdgeInsets.all(15.0)),
                // Done
                new Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    new GestureDetector(
                      child: new Image(image: new AssetImage("images/cny.png"),width: 75,height: 75),
                      onTap: () => Navigator.push(context, new MaterialPageRoute(builder: (context) => new MoneyDetail("Chinese"))),
                    ),
                    new GestureDetector(
                      child: new Image(image: new AssetImage("images/uah.png"),width: 75,height: 75),
                      onTap: () => Navigator.push(context, new MaterialPageRoute(builder: (context) => new MoneyDetail("Ukrainian"))),
                    ),
                    new GestureDetector(
                      child: new Image(image: new AssetImage("images/dkk.png"),width: 75,height: 75),
                      onTap: () => Navigator.push(context, new MaterialPageRoute(builder: (context) => new MoneyDetail("Denmark"))),
                    ),
                  ],
                ),
                new Padding(padding: const EdgeInsets.all(15.0)),
                // Done
                new Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    new GestureDetector(
                      child: new Image(image: new AssetImage("images/nok.png"),width: 75,height: 75),
                      onTap: () => Navigator.push(context, new MaterialPageRoute(builder: (context) => new MoneyDetail("Norway"))),
                    ),
                    new GestureDetector(
                      child: new Image(image: new AssetImage("images/sek.png"),width: 75,height: 75),
                      onTap: () => Navigator.push(context, new MaterialPageRoute(builder: (context) => new MoneyDetail("Sweden"))),
                    ),
                    new GestureDetector(
                      child: new Image(image: new AssetImage("images/chf.png"),width: 75,height: 75),
                      onTap: () => Navigator.push(context, new MaterialPageRoute(builder: (context) => new MoneyDetail("Switzerland"))),
                    ),
                  ],
                ),
                new Padding(padding: const EdgeInsets.all(15.0)),
                // Done
                new Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    new GestureDetector(
                      child: new Image(image: new AssetImage("images/inr.png"),width: 75,height: 75),
                      onTap: () => Navigator.push(context, new MaterialPageRoute(builder: (context) => new MoneyDetail("Indian"))),
                    ),
                    new GestureDetector(
                      child: new Image(image: new AssetImage("images/ron.png"),width: 75,height: 75),
                      onTap: () => Navigator.push(context, new MaterialPageRoute(builder: (context) => new MoneyDetail("Romania"))),
                    ),
                    new GestureDetector(
                      child: new Image(image: new AssetImage("images/czk.png"),width: 75,height: 75),
                      onTap: () => Navigator.push(context, new MaterialPageRoute(builder: (context) => new MoneyDetail("Czech Republic"))),
                    ),
                  ],
                ),
                new Padding(padding: const EdgeInsets.all(15.0)),
                // Done
                new Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    new GestureDetector(
                      child: new Image(image: new AssetImage("images/brl.png"),width: 75,height: 75),
                      onTap: () => Navigator.push(context, new MaterialPageRoute(builder: (context) => new MoneyDetail("Brazil"))),
                    ),
                    new GestureDetector(
                      child: new Image(image: new AssetImage("images/clp.png"),width: 75,height: 75),
                      onTap: () => Navigator.push(context, new MaterialPageRoute(builder: (context) => new MoneyDetail("Chile"))),
                    ),
                    new GestureDetector(
                      child: new Image(image: new AssetImage("images/hkd.png"),width: 75,height: 75),
                      onTap: () => Navigator.push(context, new MaterialPageRoute(builder: (context) => new MoneyDetail("Hong Kong"))),
                    ),
                  ],
                ),
                new Padding(padding: const EdgeInsets.all(15.0)),
                // Done
                new Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    new GestureDetector(
                      child: new Image(image: new AssetImage("images/huf.png"),width: 75,height: 75),
                      onTap: () => Navigator.push(context, new MaterialPageRoute(builder: (context) => new MoneyDetail("Hungarian"))),
                    ),
                    new GestureDetector(
                      child: new Image(image: new AssetImage("images/idr.png"),width: 75,height: 75),
                      onTap: () => Navigator.push(context, new MaterialPageRoute(builder: (context) => new MoneyDetail("Indonesia"))),
                    ),
                    new GestureDetector(
                      child: new Image(image: new AssetImage("images/ils.png"),width: 75,height: 75),
                      onTap: () => Navigator.push(context, new MaterialPageRoute(builder: (context) => new MoneyDetail("Israel"))),
                    ),
                  ],
                ),
                new Padding(padding: const EdgeInsets.all(15.0)),
                // Done
                new Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    new GestureDetector(
                      child: new Image(image: new AssetImage("images/krw.png"),width: 75,height: 75),
                      onTap: () => Navigator.push(context, new MaterialPageRoute(builder: (context) => new MoneyDetail("South Korean"))),
                    ),
                    new GestureDetector(
                      child: new Image(image: new AssetImage("images/myr.png"),width: 75,height: 75),
                      onTap: () => Navigator.push(context, new MaterialPageRoute(builder: (context) => new MoneyDetail("Malaysia"))),
                    ),
                    new GestureDetector(
                      child: new Image(image: new AssetImage("images/mxn.png"),width: 75,height: 75),
                      onTap: () => Navigator.push(context, new MaterialPageRoute(builder: (context) => new MoneyDetail("México"))),
                    ),
                  ],
                ),
                new Padding(padding: const EdgeInsets.all(15.0)),
                // Done
                new Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    new GestureDetector(
                      child: new Image(image: new AssetImage("images/nzd.png"),width: 75,height: 75),
                      onTap: () => Navigator.push(context, new MaterialPageRoute(builder: (context) => new MoneyDetail("New Zealand"))),
                    ),
                    new GestureDetector(
                      child: new Image(image: new AssetImage("images/pln.png"),width: 75,height: 75),
                      onTap: () => Navigator.push(context, new MaterialPageRoute(builder: (context) => new MoneyDetail("Poland"))),
                    ),
                    new GestureDetector(
                      child: new Image(image: new AssetImage("images/sgd.png"),width: 75,height: 75),
                      onTap: () => Navigator.push(context, new MaterialPageRoute(builder: (context) => new MoneyDetail("Singapore"))),
                    ),
                  ],
                ),
                new Padding(padding: const EdgeInsets.all(15.0))
              ],
            ),
          )
        ],
      ),
    );
  }
}
