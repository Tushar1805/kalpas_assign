import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:kalpas_assign/Data/news_model.dart';
import 'package:kalpas_assign/Service/api_service.dart';
import 'package:provider/provider.dart';

class FullNews extends StatefulWidget {
  Article article;
  FullNews({Key? key, required this.article}) : super(key: key);

  @override
  State<FullNews> createState() => _FullNewsState();
}

class _FullNewsState extends State<FullNews> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.only(top: 30, left: 15, right: 15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            InkWell(
              onTap: () {
                Navigator.of(context).pop();
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(
                    Icons.arrow_back_ios_new_outlined,
                    color: Colors.black,
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  Text(
                    "Back",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            SingleChildScrollView(
              child: Container(
                child: FutureBuilder(
                  future: context.watch<ApiService>().imageFor(widget.article),
                  builder: (context, snapshot) {
                    if (snapshot.hasData == false || snapshot.data == null) {
                      return const SizedBox(
                        height: 0,
                        child: Center(
                          child: CircularProgressIndicator(),
                        ),
                      );
                    }
                    return Container(
                      child: Column(
                        children: [
                          Stack(children: [
                            Positioned(
                              child: Container(
                                height:
                                    MediaQuery.of(context).size.height * 0.3,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  image: DecorationImage(
                                    fit: BoxFit.cover,
                                    image: Image.memory(
                                            (snapshot.data as Uint8List))
                                        .image,
                                  ),
                                ),
                              ),
                            ),
                            Positioned(
                              top: 0,
                              right: 0,
                              child: Container(
                                padding: EdgeInsets.all(8),
                                child: Image.asset(
                                  "assets/favs.png",
                                  height: 25,
                                  width: 25,
                                ),
                              ),
                            ),
                          ]),
                          const SizedBox(
                            height: 15,
                          ),
                          Container(
                            alignment: Alignment.topLeft,
                            child: Text(
                              widget.article.title,
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          Container(
                            alignment: Alignment.topLeft,
                            child: Text(
                              widget.article.description,
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          Container(
                            alignment: Alignment.centerLeft,
                            child: Row(
                              children: [
                                Image.asset(
                                  "assets/schedule.png",
                                  width: 18,
                                  height: 18,
                                  color: Colors.grey[400],
                                ),
                                SizedBox(width: 4),
                                Text(
                                  DateFormat('E, dd MMM yyyy HH:MM')
                                      .format(widget.article.publishedAt)
                                      .toString(),
                                  style: TextStyle(
                                    fontSize: 13,
                                    color: Colors.grey[400],
                                    fontWeight: FontWeight.bold,
                                  ), // Limit to one line
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
