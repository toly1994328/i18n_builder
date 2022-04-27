import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'i18n/I18n.dart';
import 'i18n/I18n_delegate.dart';



void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final List<Locale> locals = I18nDelegate.delegate.supportedLocales;

  int _index = 0;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      localizationsDelegates: [
        ...GlobalMaterialLocalizations.delegates,
        I18nDelegate.delegate
      ],
      supportedLocales: locals,
      locale: locals[_index],
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(
        active: _index==0,
        onLocalChange: _onLocalChange,
      ),
    );
  }

  void _onLocalChange(bool value) {
    _index = value?0:1;
    setState(() {

    });
  }
}

class MyHomePage extends StatefulWidget {
  final ValueChanged<bool> onLocalChange;
  final bool active;
  const MyHomePage({Key? key,required this.onLocalChange,this.active=false}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          Switch(activeColor: Colors.white70, value: widget.active, onChanged: widget.onLocalChange)
        ],
        title: Text(I18n.of(context).title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              I18n.of(context).info,
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headline4,
            ),
            Text(
              I18n.of(context).info2(count: '$_counter'),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: I18n.of(context).increment,
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
