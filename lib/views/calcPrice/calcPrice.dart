import 'package:candle/utility/commonFuncation.dart';
import 'package:candle/views/finalScreen/calculatePriceScreen.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter/material.dart';

class calcPrice extends StatefulWidget {
  calcPrice(
      {super.key, required this.wax, required this.oil, required this.candles});
  final double wax;
  final double oil;
  final double candles;
  @override
  State<calcPrice> createState() => _calcPriceState();
}

class _calcPriceState extends State<calcPrice> {
  final FocusNode unitCodeCtrlFocusNode = FocusNode();
  final TextEditingController fristTypeController =
      TextEditingController(text: "100");

  final secondTypeController = TextEditingController(text: "0.00");
  final thirdTypeController = TextEditingController(text: "0.00");

  final fristPriceController = TextEditingController();
  final secondPriceController = TextEditingController();
  final thirdPriceController = TextEditingController();

  void dispose() {
    fristTypeController.dispose();
    secondTypeController.dispose();
    thirdTypeController.dispose();
    unitCodeCtrlFocusNode.dispose();
    fristPriceController.dispose();
    secondPriceController.dispose();
    thirdPriceController.dispose();

    super.dispose();
  }

  bool enablefrist = true;
  bool enablesecond = false;
  bool enablethird = false;

  bool enablefristprice = true;
  bool enablesecondprice = false;
  bool enablethirdprice = false;

  void changeSecond(bool value) {
    enablesecond = value;
  }

  void changeSecondprice(bool value) {
    enablesecondprice = value;
  }

  void changethirdprice(bool value) {
    enablethirdprice = value;
  }

  void calctheresult() {
    double first = double.tryParse(fristTypeController.text) ?? 0;
    if (first < 100) {
      secondTypeController.text = (100 - first).toString();
    } else {
      secondTypeController.text = '0.00';
    }

    if ((first) > 100) {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(AppLocalizations.of(context)!.erroroverflow)));
      fristTypeController.text = '';
    }
  }

  void calctheresultsecond() {
    double first = double.tryParse(fristTypeController.text) ?? 0;
    double second = double.tryParse(secondTypeController.text) ?? 0;
    if (first + second > 100) {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(AppLocalizations.of(context)!.erroroverflow)));
      secondTypeController.text = '';
      thirdTypeController.text = "0.00";
    }
    if (first + second < 100) {
      thirdTypeController.text = (100 - (first + second)).toString();
    } else {
      thirdTypeController.text = '0.00';
    }
  }

  double type1price = 0.00;
  double type2price = 0.00;
  double type3price = 0.00;
  void setpricese1(double value) {
    type1price = value;
  }

  void setpricese2(double value) {
    type2price = value;
  }

  void setpricese3(double value) {
    type3price = value;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          AppLocalizations.of(context)!.sscreentitle,
        ),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: SingleChildScrollView(
            child: Column(children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.5,
                    child: Text(AppLocalizations.of(context)!.sSFTtext,
                        style: TextStyle(color: Colors.white, fontSize: 15)),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => FinalScreen(
                                  oilneeded: widget.oil,
                                  candles: widget.candles,
                                  price1: type1price,
                                  price2: type2price,
                                  price3: type3price,
                                )),
                      );
                    },
                    child: Text(
                      AppLocalizations.of(context)!.sSFLBtext,
                      style: TextStyle(color: Colors.white),
                    ),
                    style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all<Color>(Color(0xff0E59C4)),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.circular(10.0), // radius you want
                        ),
                      ),
                    ),
                  )
                ],
              ),
              boxes(
                  AppLocalizations.of(context)!.sSFBtitle,
                  fristTypeController,
                  fristPriceController,
                  enablefrist,
                  enablefristprice,
                  changeSecond,
                  changeSecondprice,
                  calctheresult,
                  setpricese1),
              boxes(
                  AppLocalizations.of(context)!.sSSBtitle,
                  secondTypeController,
                  secondPriceController,
                  enablesecond,
                  enablesecondprice,
                  (_) {},
                  changethirdprice,
                  calctheresultsecond,
                  setpricese2),
              boxes(
                  AppLocalizations.of(context)!.sSTBtitle,
                  thirdTypeController,
                  thirdPriceController,
                  enablethird,
                  enablethirdprice,
                  (_) {},
                  (_) {},
                  () {},
                  setpricese3),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => FinalScreen(
                        oilneeded: widget.oil,
                        candles: widget.candles,
                        price1: type1price,
                        price2: type2price,
                        price3: type3price,
                      ),
                    ),
                  );
                },
                child: Text(
                  AppLocalizations.of(context)!.sSFLBtext,
                  style: TextStyle(color: Colors.white),
                ),
                style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all<Color>(Color(0xff0E59C4)),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.circular(10.0), // radius you want
                    ),
                  ),
                ),
              )
            ]),
          ),
        ),
      ),
    );
  }

  Widget boxes(
      String title,
      TextEditingController precent,
      TextEditingController price,
      bool enable,
      bool enablePrice,
      Function(bool) change,
      Function(bool) changeprice,
      Function changevalue,
      Function(double) setprice) {
    double percentage = 0;
    double num_price = 0;
    double res = 0;

    return Container(
      padding: EdgeInsets.all(8),
      margin: EdgeInsets.symmetric(horizontal: 25, vertical: 8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(50),
        color: Colors.white.withOpacity(0.3),
      ),
      width: MediaQuery.of(context).size.width * .85,
      // height: MediaQuery.of(context).size.height * .3,
      child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Center(
              child: Text(
                title,
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                  "%",
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * .4,
                  child: TextField(
                    style: TextStyle(color: Colors.black),
                    enabled: enable,
                    controller: precent,
                    keyboardType: TextInputType.number,
                    textAlign: TextAlign.center,
                    onChanged: (value) {
                      if (value.isEmpty) {
                        value = "0.00";
                      }
                      if (double.tryParse(value) == null) {
                        return;
                      }
                      if (double.tryParse(value)! < 100) {
                        setState(() {
                          // change = true;
                          changevalue();
                          change(true);
                          changeprice(true);
                        });
                      } else {
                        setState(() {
                          // change = false;
                          changevalue();
                          change(false);
                          changeprice(false);
                        });
                      }
                    },
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  AppLocalizations.of(context)!.sSFBsubtitle,
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
                SizedBox(
                  width: 150,
                  child: Text(
                    (printunits((widget.wax *
                        (double.tryParse(precent.text) ?? 0) /
                        100))),
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                  AppLocalizations.of(context)!.sSFBsubtitle2,
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * .3,
                  child: TextField(
                      enabled: enablePrice,
                      controller: price,
                      keyboardType: TextInputType.number,
                      textAlign: TextAlign.center,
                      onChanged: (value) {
                        if (value.isEmpty) {
                          value = "0.00";
                        }
                        percentage =
                            (((double.tryParse(precent.text) ?? 0) / 100));
                        num_price = (double.tryParse(price.text) ?? 0);
                        res = percentage * ((widget.wax) / 1000) * num_price;

                        print(res);

                        setprice(res);

                        setState(() {});
                      }),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                  AppLocalizations.of(context)!.sSFBprice,
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * .2,
                  child: Text(
                    ((((double.tryParse(precent.text) ?? 0) / 100)) *
                            (double.tryParse(price.text) ?? 0) *
                            ((widget.wax) / 1000))
                        .toStringAsFixed(2),
                  ),
                )
              ],
            )
          ]),
    );
  }
}
