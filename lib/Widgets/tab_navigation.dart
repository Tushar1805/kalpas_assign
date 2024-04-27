import 'package:flutter/material.dart';
import 'package:kalpas_assign/Widgets/utils.dart';

Widget tabNav() {
  return TabBar(
    // unselectedLabelColor: Colors.grey.shade400,
    indicatorColor: Colors.transparent,
    labelStyle: tabTextStyle(),
    indicator: BoxDecoration(
      color: Colors.blue[100],
      borderRadius: BorderRadius.circular(10),
    ),
    tabs: [
      Tab(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              "assets/menu.png",
              width: 22,
              height: 22,
            ),
            const SizedBox(
              width: 10,
            ),
            Container(
              decoration:
                  BoxDecoration(borderRadius: BorderRadius.circular(10)),
              child: Text(
                "News",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
              ),
            ),
          ],
        ),
      ),
      Tab(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset("assets/favs.png", width: 30, height: 30),
            const SizedBox(
              width: 8,
            ),
            Text(
              "Favs",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
            ),
          ],
        ),
      )
    ],
  );
}
