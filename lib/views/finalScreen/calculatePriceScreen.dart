import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class FinalScreen extends StatefulWidget {
  const FinalScreen(
      {super.key,
      required this.oilneeded,
      required this.candles,
      required this.price1,
      required this.price2,
      required this.price3});
  final double oilneeded;
  final double candles;
  final double price1;
  final double price2;
  final double price3;

  @override
  State<FinalScreen> createState() => _FinalScreenState();
}

TextEditingController? oilpricecontroller;
TextEditingController? oilWeightcontroller;

TextEditingController? jarpricecontroller = null;
TextEditingController? wickpricecontroller = null;

TextEditingController? candlecountcontroller = null;

class _FinalScreenState extends State<FinalScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    oilpricecontroller = TextEditingController();
    oilWeightcontroller = TextEditingController(
        text: (widget.oilneeded) > 1000
            ? (widget.oilneeded / 1000).toStringAsFixed(2)
            : widget.oilneeded.toStringAsFixed(2));

    jarpricecontroller = TextEditingController();
    wickpricecontroller = TextEditingController();

    candlecountcontroller =
        TextEditingController(text: widget.candles.toStringAsFixed(0));
  }

  @override
  void dispose() {
    // TODO: implement dispose
    oilpricecontroller!.dispose();
    oilWeightcontroller!.dispose();
    jarpricecontroller!.dispose();
    wickpricecontroller!.dispose();
    candlecountcontroller!.dispose();
    super.dispose();
  }

  num jarprice = 0.0;
  num wickprice = 0.0;
  num oilprice = 0.0;
  void setjarprice(num value) {
    jarprice = value / widget.candles;
  }

  void setwickprice(num value) {
    wickprice = value / widget.candles;
  }

  void setoilprice(num value) {
    oilprice = value;
  }

  bool flag = false;

  @override
  Widget build(BuildContext context) {
    double totalprice = widget.candles *
        (widget.price1 +
            widget.price2 +
            (widget.price3) +
            jarprice +
            oilprice +
            wickprice);
    double totalwax = widget.price1 + widget.price2 + (widget.price3);
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.tscreentext),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: <Widget>[
              renderAllBox(
                  .85,
                  .3,
                  0.40,
                  AppLocalizations.of(context)!.tSFBoil,
                  AppLocalizations.of(context)!.sSFBsubtitle2,
                  (widget.oilneeded < 1000
                      ? "${AppLocalizations.of(context)!.weight}/g"
                      : "${AppLocalizations.of(context)!.weight}/kg"),
                  oilpricecontroller!,
                  oilWeightcontroller!,
                  widget.oilneeded < 1000 ? true : false,
                  setoilprice),
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                renderAllBox(
                    .49,
                    .4,
                    0.15,
                    AppLocalizations.of(context)!.jar,
                    AppLocalizations.of(context)!.priceunti,
                    AppLocalizations.of(context)!.count,
                    jarpricecontroller!,
                    candlecountcontroller!,
                    false,
                    setjarprice),
                renderAllBox(
                    .5,
                    .4,
                    0.15,
                    AppLocalizations.of(context)!.wick,
                    AppLocalizations.of(context)!.priceunti,
                    AppLocalizations.of(context)!.count,
                    wickpricecontroller!,
                    candlecountcontroller!,
                    false,
                    setwickprice)
              ]),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      child: Text(
                          "${AppLocalizations.of(context)!.totalcandles} ${(widget.candles).toStringAsFixed(0)}"),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        print(widget.price1);
                        print(widget.price2);
                        print(widget.price3);
                        setState(() {
                          flag = true;
                        });
                      },
                      child: Text(
                        AppLocalizations.of(context)!.tscreentext,
                        style: TextStyle(color: Colors.white),
                      ),
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all<Color>(Color(0xff0E59C4)),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.circular(10.0), // radius you want
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              if (flag)
                Container(
                  margin: EdgeInsets.only(bottom: 20),
                  width: 300,
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
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      children: [
                        _costtext(
                            "${AppLocalizations.of(context)!.totalcandlescost}",
                            (totalprice).toStringAsFixed(2)),
                        _costtext(
                            "${AppLocalizations.of(context)!.costpercandle}",
                            (totalprice / widget.candles).toStringAsFixed(2)),
                        _costtext(
                            "${AppLocalizations.of(context)!.waxpricepercandle}",
                            totalwax.toStringAsFixed(2)),
                        _costtext(
                            "${AppLocalizations.of(context)!.oilpricepercandle}",
                            oilprice.toStringAsFixed(2)),
                        _costtext("${AppLocalizations.of(context)!.type1price}",
                            (widget.price1).toStringAsFixed(2)),
                        _costtext("${AppLocalizations.of(context)!.type2price}",
                            (widget.price2).toStringAsFixed(2)),
                        _costtext("${AppLocalizations.of(context)!.type3price}",
                            (widget.price3).toStringAsFixed(2),
                            last: true),
                      ],
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget renderAllBox(
      double width,
      double height,
      double contentWidth,
      String title,
      String fristSubTitle,
      String secondSubTitle,
      TextEditingController fristcontroller,
      TextEditingController secondcontroller,
      bool convert,
      Function(num) save) {
    return Container(
      padding: EdgeInsets.all(12),
      margin: EdgeInsets.symmetric(vertical: 5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(50),
        color: Colors.white.withOpacity(0.3),
      ),
      width: MediaQuery.of(context).size.width * width,
      height: MediaQuery.of(context).size.height * height,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Center(
            child: Text(
              "$title",
              style: TextStyle(color: Colors.white),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text(
                "$fristSubTitle",
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * contentWidth,
                child: TextField(
                  enabled: true,
                  controller: fristcontroller,
                  keyboardType: TextInputType.number,
                  textAlign: TextAlign.center,
                  onChanged: (value) {
                    if (value.isEmpty) {
                      value = "0.00";
                    }
                    setState(() {
                      save(((num.tryParse(fristcontroller.text) ?? 0) *
                          (convert == true
                              ? num.tryParse(secondcontroller.text)! / 1000
                              : num.tryParse(secondcontroller.text)!)));
                    });
                  },
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                "$secondSubTitle",
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * contentWidth,
                child: TextField(
                  enabled: false,
                  controller: secondcontroller,
                  keyboardType: TextInputType.number,
                  textAlign: TextAlign.center,
                ),
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
                width: MediaQuery.of(context).size.width * contentWidth,
                child: Text(((num.tryParse(fristcontroller.text) ?? 0) *
                        (convert == true
                            ? num.tryParse(secondcontroller.text)! / 1000
                            : num.tryParse(secondcontroller.text)!))
                    .toStringAsFixed(2)),
              ),
            ],
          )
        ],
      ),
    );
  }
}

Widget _costtext(String text, String price, {bool last = false}) {
  return Column(
    children: [
      RichText(
        text: TextSpan(
          text: text,
          style: TextStyle(
              fontWeight: FontWeight.bold, fontSize: 15, color: Colors.black),
          children: <TextSpan>[
            TextSpan(
                text: "$price",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    color: Color(0xff0E59C4))),
          ],
        ),
      ),
      if (last == false)
        const Divider(
          color: Colors.black,
          height: 5,
          thickness: .5,
          indent: 40,
          endIndent: 2,
        )
    ],
  );
}
