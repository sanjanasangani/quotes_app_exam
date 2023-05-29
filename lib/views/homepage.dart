import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quote_app_exam/controller/quote_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../model/quote_Model.dart';
import '../utils/helpers.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  QuotesModel? quote;

  @override
  void initState() {
    super.initState();
    fetchRandomQuote();
    savedQuote();
    Provider.of<quotesprovider>(context, listen: false).date();
  }

  Future<void> savedQuote() async {
    final prefs = await SharedPreferences.getInstance();
    final quoteList = prefs.getStringList("saved_quote");
    if (quoteList != null) {
      final quoteMap = {
        'id': quoteList[0],
        'content': quoteList[1],
        'author': quoteList[2],
        'authorSlug': quoteList[3],
      };
      quote = QuotesModel.fromMap(quoteMap);
    }
    setState(() {});
  }

  Future<void> fetchRandomQuote() async {
    quote = await APIHelper.apiHelper.fetchQuote();
    if (quote != null) {
      await saveQuoteToSharedPreferences(quote!);
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double _height = size.height;
    double _width = size.width;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.pink,
        centerTitle: true,
        title: const Text("Random Quotes"),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh_outlined),
            iconSize: 30,
            onPressed: fetchRandomQuote,
          ),
        ],
      ),
      body: ListView(
        children: [
          SizedBox(
            height: 90,
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            height: _height * 0.6,
            width: _width / 2,
            child: Card(
              margin: const EdgeInsets.only(top: 20),
              color: const Color(0XFFeeeeee),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              elevation: 10,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      quote?.content ??
                          "Don\'t talk about what you have done or what you are going to do.",
                      textAlign: TextAlign.justify,
                      style: const TextStyle(
                        fontSize: 20,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                    const SizedBox(height: 22),
                    Align(
                      alignment: Alignment.bottomRight,
                      child: Text(
                        quote?.author ?? "Thomas Jefferson",
                        textAlign: TextAlign.justify,
                        style: const TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 40,
                    ),
                    //Text("${datetime.day}/${datetime.month}/${datetime.year}"),
                    // Text("${datetime.hour}:${datetime.minute}"),
                    Text(Provider.of<quotesprovider>(context, listen: true)
                        .datemodel
                        .dateTime!),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
