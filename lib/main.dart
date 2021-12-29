import 'package:bytebank2/http/webclient.dart';
import 'package:bytebank2/models/transaction.dart';
import 'package:bytebank2/screens/contact_form.dart';
import 'package:bytebank2/screens/contacts_list.dart';
import 'package:bytebank2/screens/dashboard.dart';
import 'package:flutter/material.dart';

import 'database/app_database.dart';
import 'models/contact.dart';

void main() {
  runApp(BytebankApp());
}

class BytebankApp extends StatelessWidget {
  // This widget is the root of your application.
  final ThemeData tema = ThemeData(
    fontFamily: 'Roboto',
  );
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: tema.copyWith(
        colorScheme: tema.colorScheme
            .copyWith(primary: Colors.green[900], secondary: Colors.green[900]),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            primary: Colors.green[900],
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(18.0),
            ),
          ),
        ),
      ),
      home: Dashborad(),
      //home: ContactForm(),
    );
  }
}
