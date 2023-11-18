import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:candle/views/mainScreen/mainScreen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
  static void setlocal(BuildContext context, Locale newlocal) {
    _MyAppState? state = context.findAncestorStateOfType<_MyAppState>();
    state?.setlocal(newlocal);
  }
}

class _MyAppState extends State<MyApp> {
  Locale? _locale;
  setlocal(Locale locale) {
    setState(() {
      _locale = locale;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // disabledColor: Colors.black,
        inputDecorationTheme: const InputDecorationTheme(
          filled: true,
          fillColor: Colors.white,
        ),
        scaffoldBackgroundColor: Color(0xff90B5EA),
        appBarTheme:
            AppBarTheme(backgroundColor: Colors.white.withOpacity(0.2)),
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      locale: _locale,
      home: mainScreen(),
    );
  }
}
