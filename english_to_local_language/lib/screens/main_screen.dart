import 'package:english_to_local_language/prefs/global_translation.dart';
import 'package:flutter/material.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedPageIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        //TODO: Must be updated right after the switch is switched
        title: Text(
          allTranslations.text('app_title'),
        ),
      ),
      body: _selectedPageIndex == 0 ? FirstTestPage() : SecondTestPage(),
      bottomNavigationBar: BottomNavigationBar(
        onTap: _selectPage,
        currentIndex: _selectedPageIndex,
        items: [
          BottomNavigationBarItem(label: 'Test 1', icon: Icon(Icons.language)),
          BottomNavigationBarItem(label: 'Test 2', icon: Icon(Icons.language)),
        ],
      ),
    );
  }

  void _selectPage(int value) {
    setState(() {
      _selectedPageIndex = value;
    });
  }
}

class FirstTestPage extends StatefulWidget {
  @override
  _FirstTestPageState createState() => _FirstTestPageState();
}

class _FirstTestPageState extends State<FirstTestPage> {
  @override
  Widget build(BuildContext context) {
    final String language = allTranslations.currentLanguage;
    final String buttonText =
        language == 'bisaya' ? 'Bisaya Language Used' : 'English Language Used';
    bool isBisaya = language == 'bisaya' ? true : false;

    return Container(
      height: MediaQuery.of(context).size.height,
      child: Column(
        children: [
          Center(
            child: Text(buttonText),
          ),
          Switch(
            value: isBisaya,
            onChanged: (bool newValue) async {
              await allTranslations
                  .setNewLanguage(language == 'bisaya' ? 'en' : 'bisaya');
              setState(() {
                isBisaya = newValue;
              });
            },
          ),
          Text(
            allTranslations.text('main_title'),
            style: TextStyle(fontSize: 20),
          ),
          SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Text(
              allTranslations.text('main_body'),
              style: TextStyle(fontSize: 25),
            ),
          ),
        ],
      ),
    );
  }

  // void _selectSwitch(bool value, String language) async {
  //   await allTranslations.setNewLanguage(language == 'fr' ? 'en' : 'fr');
  //   setState(() {
  //     _isBisaya = value;
  //   });
  // }
}

class SecondTestPage extends StatefulWidget {
  @override
  _SecondTestPageState createState() => _SecondTestPageState();
}

class _SecondTestPageState extends State<SecondTestPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text(
            allTranslations.text('second_screen_text'),
            style: TextStyle(fontSize: 30,),
            textAlign: TextAlign.center,
          ),
          Text('Thanks to sharedPreference!'),
        ],
      ),
    );
  }
}
