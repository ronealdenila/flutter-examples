import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import './screens/main_screen.dart';
import 'prefs/global_translation.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await allTranslations.init();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    allTranslations.onLocaleChangedCallback = _onLocalChanged;
  }

  _onLocalChanged() async {
    print('Language has been changed to: ${allTranslations.currentLanguage}');
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: allTranslations.supportedLocales(),
      home: MainScreen(),
    );
  }
}
