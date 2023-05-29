import 'dart:convert';

import 'package:http/http.dart' as http;

import '../model/quote_Model.dart';

class APIHelper {
  APIHelper._(); //private named constructor
  static final APIHelper apiHelper = APIHelper._();

  Future<QuotesModel?> fetchQuote() async {
    String baseUrl = "http://api.quotable.io/random";
    http.Response response = await http.get(Uri.parse(baseUrl));
    if (response.statusCode == 200) {
      Map<String, dynamic> decodedData = jsonDecode(response.body);
      QuotesModel quotesData = QuotesModel.fromMap(decodedData);
      return quotesData;
    }
    return null;
  }
}
