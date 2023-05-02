import 'package:flutter/material.dart';
import 'package:quotes_app/catagory.dart';
import 'package:quotes_app/utils.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  List<String> catagories = [
    "love",
    "inspirational",
    "life",
    "humor",
    "books",
    "friends"
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        physics: const ScrollPhysics(),
        child: Column(
          children: [
            Container(
              alignment: Alignment.center,
              margin: const EdgeInsets.only(top: 60),
              child: Text(
                "Quotes App",
                style: textStyle(25, Colors.black, FontWeight.w700),
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            GridView.count(
              crossAxisCount: 2,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              mainAxisSpacing: 10,
              crossAxisSpacing: 10,
              children: catagories.map((catagory) {
                return InkWell(
                  onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => QuotePage(catagory))),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Center(
                      child: Text(
                        catagory.toUpperCase(),
                        style: textStyle(20, Colors.white, FontWeight.bold),
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }
}
