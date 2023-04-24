import 'dart:core';

import 'package:flutter/material.dart';
import 'package:rough/util/customcolors.dart';



class tipcal extends StatefulWidget {
  const tipcal({Key? key}) : super(key: key);

  @override
  State<tipcal> createState() => _tipcalState();
}

class _tipcalState extends State<tipcal> {
  int _tippercentage = 0;
  int _personcounter = 1;
  double _billamount = 0;

  Color _purple = HexColor("#6908D6");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      alignment: Alignment.center,
      color: Colors.white,
      child: ListView(
        scrollDirection: Axis.vertical,
        padding: EdgeInsets.all(20),
        children: <Widget>[
          Container(
            width: 350,
            height: 200,
            margin:
                EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.1),
            decoration: BoxDecoration(
                color: _purple.withOpacity(0.1),
                //Colors.purpleAccent.shade700,
                borderRadius: BorderRadius.circular(10)),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  "Total per Person",
                  style: TextStyle(
                      color: _purple,
                      fontSize: 17,
                      fontWeight: FontWeight.bold),
                ),
                Padding(
                  padding: const EdgeInsets.all(35.0),
                  child: Text(
                    "\$ ${calculatetotalperperson( _billamount, _personcounter, _tippercentage)}",
                    style: TextStyle(
                        fontSize: 27,
                        fontWeight: FontWeight.bold,
                        color: _purple),
                  ),
                )
              ],
            ),
          ),
          Container(
            width: 350,
            height: 300,
            margin:
                EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.1),
            decoration: BoxDecoration(
                border: Border.all(
                    color: Colors.blueGrey.shade100, style: BorderStyle.solid),
                color: Colors.transparent,
                borderRadius: BorderRadius.circular(20)),
            child: Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    keyboardType:
                        TextInputType.numberWithOptions(decimal: true),
                    style: TextStyle(color: Colors.black87),
                    decoration: InputDecoration(
                        prefixIcon: Icon(
                      Icons.attach_money,
                    )),
                    onChanged: (String value) {
                      try {
                        _billamount = double.parse(value);
                      } catch (exception) {
                        _billamount = 0.0;
                      }
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        "SPLIT",
                        style: TextStyle(
                            color: Colors.black87,
                            fontWeight: FontWeight.bold,
                            fontSize: 20),
                      ),
                      Row(
                        children: <Widget>[
                          InkWell(
                            onTap: () {
                              setState(() {
                                if (_personcounter > 1) {
                                  _personcounter--;
                                } else {
                                  debugPrint("can not be less than 1");
                                }
                              });
                            },
                            child: Container(
                              width: 40,
                              height: 40,
                              margin: EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                  color: _purple.withOpacity(0.1),
                                  borderRadius: BorderRadius.circular(10)),
                              child: Center(
                                  child: Text(
                                "-",
                                style: TextStyle(
                                    color: _purple,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 17),
                              )),
                            ),
                          ),
                          Text(
                            "$_personcounter",
                            style: TextStyle(
                                color: _purple,
                                fontSize: 20,
                                fontWeight: FontWeight.bold),
                          ),
                          InkWell(
                            onTap: () {
                              setState(() {
                                _personcounter++;
                              });
                            },
                            child: Container(
                              width: 40,
                              height: 40,
                              margin: EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                  color: _purple.withOpacity(0.1),
                                  borderRadius: BorderRadius.circular(10)),
                              child: Center(
                                  child: Text("+",
                                      style: TextStyle(
                                          color: _purple,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 17))),
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        "TIP",
                        style: TextStyle(
                            color: Colors.black87,
                            fontWeight: FontWeight.bold,
                            fontSize: 20),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Text(
                          "\$${calculatetotaltip( _billamount,  _personcounter, _tippercentage)}",
                          style: TextStyle(
                              color: _purple,
                              fontWeight: FontWeight.bold,
                              fontSize: 20),
                        ),
                      ),
                    ],
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      "$_tippercentage %",
                      style: TextStyle(
                          fontSize: 27,
                          fontWeight: FontWeight.bold,
                          color: _purple),
                    ),
                    Slider(
                        min: 0,
                        max: 100,
                        divisions: 10,
                        activeColor: _purple,
                        inactiveColor: _purple.withOpacity(0.1),
                        value: _tippercentage.toDouble(),
                        onChanged: (double value) {
                          setState(() {
                            _tippercentage = value.round();
                          });
                        })
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    ));
  }

  calculatetotalperperson(
      double _billamount, int _personcounter, int _tippercentage) {
    double perperson = 0;
    perperson = (calculatetotaltip(_billamount,_personcounter,_tippercentage) + _billamount) / _personcounter;
    return perperson.toStringAsFixed(2);
  }

  calculatetotaltip(
      double _billamount, int _personcounter, int _tippercentage) {
    double totaltip = 0;
    if (_billamount == null ||
        _billamount.toString().isEmpty ||
        _billamount < 0) {
    } else {
      totaltip = _billamount * _tippercentage / 100;
      return totaltip;
    }
  }
}
