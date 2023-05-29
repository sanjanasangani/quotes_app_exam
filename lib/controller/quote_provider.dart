import 'package:flutter/material.dart';
import 'package:quote_app_exam/model/quote_Model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class quotesprovider extends ChangeNotifier {
  dateModel datemodel = dateModel(datetime: DateTime.now());
  date() async {
    datemodel.dateTime =
        "${datemodel.datetime.day}/${datemodel.datetime.month}/${datemodel.datetime.year}     ${datemodel.datetime.hour}:${datemodel.datetime.minute}";

    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString('dateTime', datemodel.dateTime!);

    notifyListeners();
  }
}
