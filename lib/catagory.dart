import 'package:flutter/material.dart';
import 'package:html/parser.dart';
import 'package:quotes_app/utils.dart';
import 'package:http/http.dart' as http;
import 'package:html/dom.dart' as dom;
import 'package:html/parser.dart' as parser;

class QuotePage extends StatefulWidget {
  final String catagoryName;
  const QuotePage(this.catagoryName);

  @override
  State<QuotePage> createState() => _QuotePageState();
}

class _QuotePageState extends State<QuotePage> {
  List quotes = [];
  List authors = [];

  bool isDataThere = false;
  @override
  void initState() {
    super.initState();
    getstate();
  }

  getstate() async {
    String url = "https://quotes.toscrape.com/tag/${widget.catagoryName}/";
    Uri endpoint = Uri.parse(url);
    http.Response response = await http.get(endpoint);
    dom.Document document = parser.parse(response.body);
    final quoteclass = document.getElementsByClassName("quote");
    quotes = quoteclass
        .map((element) => element.getElementsByClassName('text')[0].innerHtml)
        .toList();
    authors = quoteclass
        .map((element) => element.getElementsByClassName('author')[0].innerHtml)
        .toList();
    setState(() {
      isDataThere = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: isDataThere == false
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : SingleChildScrollView(
              physics: const ScrollPhysics(),
              child: Column(
                children: [
                  Container(
                    alignment: Alignment.center,
                    margin: const EdgeInsets.only(top: 60),
                    child: Text(
                      "${widget.catagoryName} quots".toUpperCase(),
                      style: textStyle(25, Colors.black, FontWeight.w700),
                    ),
                  ),
                  ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: quotes.length,
                    itemBuilder: (context, index) {
                      return Container(
                        padding: EdgeInsets.all(10),
                        child: Card(
                          elevation: 10,
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(
                                    top: 20, left: 20, bottom: 20),
                                child: Text(
                                  quotes[index],
                                  style: textStyle(
                                      18, Colors.black, FontWeight.w600),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(bottom: 10),
                                child: Text(
                                  authors[index],
                                  style: textStyle(
                                      15, Colors.black, FontWeight.w600),
                                ),
                              )
                            ],
                          ),
                        ),
                      );
                    },
                  )
                ],
              ),
            ),
    );
  }
}
