import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quote_app_exam/views/homepage.dart';

import 'controller/quote_provider.dart';

void main() {
  runApp(MultiProvider(
    providers: [ChangeNotifierProvider(create: (context) => quotesprovider())],
    builder: (context, _) {
      return MaterialApp(
        routes: {'/': (context) => HomeScreen()},
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
      );
    },
  ));
}
