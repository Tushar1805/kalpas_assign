import 'package:flutter/material.dart';
import 'package:kalpas_assign/Widgets/tab_navigation.dart';
import 'package:kalpas_assign/Widgets/utils.dart';

PreferredSize appBar(
    BuildContext context, TextEditingController searchController) {
  return PreferredSize(
      preferredSize: Size.fromHeight(100),
      child: Container(
        padding: EdgeInsets.fromLTRB(30, 10, 30, 0),
        decoration: boxDecoration(),
        child: SafeArea(
          child: Column(
            children: [
              // topBar(),
              // SizedBox(
              //   height: 10,
              // ),
              // searchBar(context, searchController),
              SizedBox(
                height: 10,
              ),
              tabNav()
            ],
          ),
        ),
      ));
}

Widget topBar() {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Icon(
        Icons.menu,
      ),
      Text("News",
          style: TextStyle(
              fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold)),
      Icon(
        Icons.more_horiz,
        color: Colors.white,
      )
    ],
  );
}
