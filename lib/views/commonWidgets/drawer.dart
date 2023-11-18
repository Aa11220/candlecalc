import 'package:candle/main.dart';
import 'package:candle/views/infopage/infoPage.dart';
import 'package:candle/views/savedpage/savedScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class MyDrawer extends StatelessWidget {
  MyDrawer(BuildContext context);
  @override
  Widget build(context) {
    return Drawer(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text(AppLocalizations.of(context)!.menu),
          backgroundColor: Color(0xff0E59C4),
        ),
        body: ListView(
          children: [
            ListTile(
              leading: Icon(Icons.text_snippet_outlined),
              title: Text(AppLocalizations.of(context)!.templates),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => savedScreen()));
              },
            ),
            ListTile(
              leading: Icon(Icons.account_balance_rounded),
              title: Text(AppLocalizations.of(context)!.drawer2),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => infoPage()));
              },
            ),
            const Divider(
              color: Colors.black,
              height: 25,
              thickness: 2,
              indent: 5,
              endIndent: 5,
            ),
            ExpansionTile(
              shape: const Border(),
              title: Text(AppLocalizations.of(context)!.applang),
              leading: Icon(Icons.language), //add icon
              // childrenPadding: EdgeInsets.only(left: 60), //children padding
              children: [
                ListTile(
                  title: RichText(
                    text: TextSpan(
                      children: <TextSpan>[
                        TextSpan(
                          text:
                              '	\u{1F1FA}\u{1F1F8}          ', // emoji characters
                          style: TextStyle(
                            fontFamily: 'EmojiOne',
                          ),
                        ),
                        TextSpan(
                            text: AppLocalizations.of(context)!.drawer31,
                            style: TextStyle(
                                color: Colors.black) // non-emoji characters
                            ),
                      ],
                    ),
                  ),
                  onTap: () {
                    MyApp.setlocal(context, Locale("en"));
                  },
                ),

                ListTile(
                  title: RichText(
                    text: TextSpan(
                      children: <TextSpan>[
                        TextSpan(
                          text:
                              '	\u{1F1EA}\u{1F1EC}          ', // emoji characters
                          style: TextStyle(
                            fontFamily: 'EmojiOne',
                          ),
                        ),
                        TextSpan(
                            text: AppLocalizations.of(context)!.drawer32,
                            style: TextStyle(
                                color: Colors.black) // non-emoji characters
                            ),
                      ],
                    ),
                  ),
                  onTap: () {
                    MyApp.setlocal(context, Locale("ar"));
                  },
                ),

                //more child menu
              ],
            ),
          ],
        ),
      ),
    );
  }
}
