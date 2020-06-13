import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'coin_data.dart';
import 'dart:io' show Platform;
import 'package:http/http.dart' as http;

class PriceScreen extends StatefulWidget {
  @override
  _PriceScreenState createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {
  String dropDownMenuValue = 'USD';
  int bitcoin;
  int etherhum;
  int litecoin;



  Widget androidDropDown() {
    return DropdownButton<String>(
      items: currenciesList.map<DropdownMenuItem<String>>((String e) {
        return DropdownMenuItem<String>(
          value: e,
          child: Text(e),
          onTap: () {
            setState(() {
              dropDownMenuValue = e;
              getOneBitcoin();
              getOneEthereum();
              getOneLitecoin();
            });
          },
        );
      }).toList(),
      onChanged: (String value) {
        print(value);
      },
      value: dropDownMenuValue,
    );
  }

  Widget IOSPicker() {
    return CupertinoPicker(
        backgroundColor: Colors.lightBlue,
        itemExtent: 32,
        onSelectedItemChanged: (int i) {
          print(i);
        },
        children: currenciesList.map<Widget>((e) {
          return Text(e);
        }).toList());
  }

  Future<void> getOneBitcoin() async {
    var url = 'https://rest.coinapi.io/v1/exchangerate/BTC/$dropDownMenuValue';
    var response = await http.get(url, headers: {'X-CoinAPI-Key': '7BA77601-A362-43BB-A9E6-EBC81422C8FF'});
    print('Response status: ${response.statusCode}');
    bitcoin=json.decode(response.body)['rate'].toInt();
  }

  Future<void> getOneEthereum() async {
    var url = 'https://rest.coinapi.io/v1/exchangerate/ETH/$dropDownMenuValue';
    var response = await http.get(url, headers: {'X-CoinAPI-Key': '7BA77601-A362-43BB-A9E6-EBC81422C8FF'});
    print('Response status: ${response.statusCode}');
    etherhum=json.decode(response.body)['rate'].toInt();
  }

  Future<void> getOneLitecoin() async {
    var url = 'https://rest.coinapi.io/v1/exchangerate/LTC/$dropDownMenuValue';
    var response = await http.get(url, headers: {'X-CoinAPI-Key': '7BA77601-A362-43BB-A9E6-EBC81422C8FF'});
    print('Response status: ${response.statusCode}');
    litecoin=json.decode(response.body)['rate'].toInt();
  }
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text('🤑 Coin Ticker'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
            child: Card(
              color: Colors.lightBlueAccent,
              elevation: 5.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 28.0),
                child: Text(
                  '1 BTC = $bitcoin $dropDownMenuValue',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20.0,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),Padding(
            padding: EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
            child: Card(
              color: Colors.lightBlueAccent,
              elevation: 5.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 28.0),
                child: Text(
                  '1 ETH = $etherhum $dropDownMenuValue',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20.0,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),Padding(
            padding: EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
            child: Card(
              color: Colors.lightBlueAccent,
              elevation: 5.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 28.0),
                child: Text(
                  '1 LTC = $litecoin $dropDownMenuValue',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20.0,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
          Container(
              height: 150.0,
              alignment: Alignment.center,
              padding: EdgeInsets.only(bottom: 30.0),
              color: Colors.lightBlue,
              child: Platform.isIOS ? IOSPicker() : androidDropDown(),
          ),
        ],
      ),
    );
  }
}
