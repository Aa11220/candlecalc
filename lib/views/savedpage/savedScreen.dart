import 'dart:convert';

import 'package:candle/models/cargo.dart';
import 'package:candle/views/calcPrice/calcPrice.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

Future<List<cargo>> getSaved() async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  List<String>? saved = prefs.getStringList("saved") ?? [];
  List<cargo> items = saved.map((e) => cargo.fromJson(json.decode(e))).toList();
  return items;
}

class savedScreen extends StatelessWidget {
  savedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text(AppLocalizations.of(context)!.templates),
          backgroundColor: Color(0xff0E59C4),
        ),
        body: FutureBuilder(
          future: getSaved(),
          builder: (context, snapshot) {
            List<cargo> cargolist = snapshot.data ?? [];
            return ListView.builder(
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () {
                    double wax =
                        double.tryParse(cargolist[index].waxneeded) ?? 0;
                    double oil =
                        double.tryParse(cargolist[index].oilneeded) ?? 0;
                    double candles =
                        double.tryParse(cargolist[index].candles) ?? 1;
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => calcPrice(
                                wax: wax, oil: oil, candles: candles)));
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "${AppLocalizations.of(context)!.fSSBwaxneeded} ${cargolist[index].waxneeded}",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 18),
                        ),
                        Text(
                          " ${AppLocalizations.of(context)!.fSSBoilneeded} ${cargolist[index].oilneeded}",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 18),
                        ),
                        Row(
                          children: [
                            Text(
                                "${AppLocalizations.of(context)!.totalweight} : ${cargolist[index].weight}"),
                            SizedBox(
                              width: 12,
                            ),
                            Text(
                                "${AppLocalizations.of(context)!.tSFBoil} : ${cargolist[index].oil}"),
                          ],
                        ),
                        Text(
                            "${AppLocalizations.of(context)!.fSFBcandles} ${(cargolist[index].candles)[0]}")
                      ],
                    ),
                  ),
                );
              },
              itemCount: cargolist.length,
            );
          },
        ));
  }
}
