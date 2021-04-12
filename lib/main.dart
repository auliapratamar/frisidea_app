import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:frisidea_app/main/main_view.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
    ));
    return MaterialApp(
      title: 'Frisidea App',
      themeMode: ThemeMode.light,
      home: MainView(),
      debugShowCheckedModeBanner: false,
    );
  }
}

