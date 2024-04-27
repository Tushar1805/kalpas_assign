import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:kalpas_assign/Data/news_model.dart';
import 'package:kalpas_assign/Service/api_service.dart';
import 'package:provider/provider.dart';

@override
Widget favorites(
    {BuildContext? context,
    ScrollController? scrollController,
    List<Article>? articles,
    bool? isMoreLoading}) {
  return ListView.builder(
      controller: scrollController,
      itemCount: isMoreLoading! ? articles!.length + 1 : articles!.length,
      itemBuilder: (context, index) {
        if (index < articles.length) {
          return FutureBuilder(
              future: context.watch<ApiService>().imageFor(articles[index]),
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
                  padding: EdgeInsets.fromLTRB(15, 10, 15, 10),
                  child: Card(
                    elevation: 10,
                    shadowColor: Colors.grey.shade600,
                    shape: RoundedRectangleBorder(
                      side: BorderSide(color: Colors.white70, width: 1),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Container(
                      padding: EdgeInsets.only(left: 10, top: 10, bottom: 10),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            height: 100,
                            width: 100,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              image: DecorationImage(
                                fit: BoxFit.cover,
                                image:
                                    Image.memory((snapshot.data as Uint8List))
                                        .image,
                              ),
                            ),
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Container(
                                  alignment: Alignment.topLeft,
                                  padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                                  child: Text(
                                    articles[index].title,
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    maxLines: 1, // Limit to one line
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                                Container(
                                  alignment: Alignment.centerLeft,
                                  padding: EdgeInsets.fromLTRB(10, 5, 0, 8),
                                  child: Text(
                                    articles[index].description,
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.black,
                                    ),
                                    maxLines: 3, // Limit to one line
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                                Container(
                                  alignment: Alignment.centerLeft,
                                  padding: EdgeInsets.fromLTRB(10, 0, 5, 0),
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
                                            .format(articles[index].publishedAt)
                                            .toString(),
                                        style: TextStyle(
                                          fontSize: 12,
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
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              });
        } else {
          return Center(child: CircularProgressIndicator());
        }
      });
}
