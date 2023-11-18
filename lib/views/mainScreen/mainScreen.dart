import 'dart:convert';

import 'package:candle/models/cargo.dart';
import 'package:candle/views/commonWidgets/drawer.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:candle/utility/commonFuncation.dart';
import 'package:candle/views/calcPrice/calcPrice.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

class mainScreen extends StatefulWidget {
  const mainScreen({
    super.key,
  });

  @override
  State<mainScreen> createState() => _mainScreenState();
}

@override
class _mainScreenState extends State<mainScreen> {
  final weightcontroller = TextEditingController();
  final oilcontroller = TextEditingController();
  final candlescontroller = TextEditingController();

  void dispose() {
    weightcontroller.dispose();
    oilcontroller.dispose();
    candlescontroller.dispose();
    super.dispose();
  }

  List<cargo> _cargolist = [];
  double weight = 0.0;
  double oil = 0.0;
  double candles = 1;
  double waxneeded = 0;
  double oilneeded = 0;
  bool expanded = false;

  void savedata({required cargo}) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    _cargolist.add(cargo);

    List<String> savedItem =
        _cargolist.map((e) => jsonEncode(e.toJson())).toList();

    prefs.setStringList("saved", savedItem);
  }

  late cargo inlist;

  @override
  Widget build(BuildContext context) {
    double waxneeded = weight / (1 + (oil / 100)) * candles;
    double oilneeded =
        weight * candles - (weight / (1 + (oil / 100))) * candles;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(AppLocalizations.of(context)!.fscreentitle),
          centerTitle: true,
        ),
        drawer: MyDrawer(context),
        body: SingleChildScrollView(
          child: Center(
            child: Column(
              children: [
                Container(
                  margin: EdgeInsets.all(15),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(50)),
                    border: Border.all(color: Colors.white, width: 1),
                    color: Colors.white.withOpacity(0.3),
                  ),
                  width: 300,
                  padding: EdgeInsets.symmetric(horizontal: 25, vertical: 15),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(AppLocalizations.of(context)!.fSFBweight),
                      SizedBox(
                        width: 200,
                        child: TextField(
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.white,
                          ),
                          controller: weightcontroller,
                          keyboardType: TextInputType.number,
                          textAlign: TextAlign.center,
                          onChanged: (value) {
                            if (value.isEmpty) {
                              value = "0";
                            }
                            setState(() {
                              weight = double.tryParse(value) ?? 0;
                            });
                          },
                        ),
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      Text(AppLocalizations.of(context)!.fSFBoil),
                      SizedBox(
                        width: 200,
                        child: TextField(
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.white,
                          ),
                          controller: oilcontroller,
                          keyboardType: TextInputType.number,
                          textAlign: TextAlign.center,
                          onChanged: (value) {
                            if (value.isEmpty) {
                              value = "0";
                            }
                            setState(() {
                              oil = double.tryParse(value) ?? 0;
                            });
                          },
                        ),
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      Text(AppLocalizations.of(context)!.fSFBcandles),
                      SizedBox(
                        width: 200,
                        child: TextField(
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.white,
                          ),
                          controller: candlescontroller,
                          keyboardType: TextInputType.number,
                          textAlign: TextAlign.center,
                          onChanged: (value) {
                            if (value.isEmpty) {
                              value = "1";
                            }
                            setState(() {
                              candles = double.tryParse(value) ?? 1;
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(bottom: 20),
                  width: 300,
                  height: 210,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(50)),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.white.withOpacity(0.3),
                        spreadRadius: 4,
                        blurRadius: 0,
                        offset: Offset(0, -5), // changes position of shadow
                      ),
                    ],
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(AppLocalizations.of(context)!.fSSBwaxneeded),
                      Directionality(
                        textDirection: TextDirection.ltr,
                        child: Text(
                          printunits(waxneeded),
                          style: TextStyle(
                            color: Color(0xff0E59C4),
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        ),
                      ), // TODO
                      const Divider(
                        color: Colors.black,
                        height: 25,
                        thickness: 1,
                        indent: 5,
                        endIndent: 5,
                      ),
                      Text(AppLocalizations.of(context)!.fSFBoil),
                      Directionality(
                        textDirection: TextDirection.ltr,
                        child: Text(
                          printunits(oilneeded),
                          style: TextStyle(
                            color: Color(0xff0E59C4),
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        ),
                      ),
                      ElevatedButton(
                        child: Text(
                          AppLocalizations.of(context)!.fSFBcalc,
                          style: TextStyle(color: Colors.white),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xff0E59C4),
                        ),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => calcPrice(
                                  wax: waxneeded,
                                  oil: oilneeded,
                                  candles: candles),
                            ),
                          );
                        },
                      ),
                      // TODO
                    ],
                  ),
                ),
                ElevatedButton(
                  child: Text(
                    AppLocalizations.of(context)!.fSFBsave,
                    style: TextStyle(color: Colors.white),
                  ),
                  onPressed: () {
                    inlist = cargo(
                        weight: weight.toStringAsFixed(2),
                        oil: oil.toStringAsFixed(2),
                        candles: candles.toStringAsFixed(2),
                        waxneeded: waxneeded.toStringAsFixed(2),
                        oilneeded: oilneeded.toStringAsFixed(2));
                    if (inlist.waxneeded == "0.00" &&
                        inlist.oilneeded == "0.00") {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content:
                              Text(AppLocalizations.of(context)!.emptyerror)));
                    } else {
                      savedata(cargo: inlist);
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text("Saved"),
                        ),
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xff0E59C4),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
