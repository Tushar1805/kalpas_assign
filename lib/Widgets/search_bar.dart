import 'package:flutter/material.dart';
import 'package:kalpas_assign/Screens/search_screen.dart';
import 'package:kalpas_assign/Service/api_service.dart';
import 'package:provider/provider.dart';

Widget searchBar(context, searchController) {
  final provider = Provider.of<ApiService>(context);
  Future<void> updateList(String text) async {
    await provider.filter(text);
  }

  return InkWell(
    onTap: () {
      print("Pressed the ROW");
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => SearchScreen()));
      // SearchScreen();
    },
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Flexible(
          fit: FlexFit.tight,
          flex: 3,
          child: SizedBox(
            height: 35,
            child: TextFormField(
              controller: searchController,
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.grey.shade400,
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                prefixIcon: Icon(Icons.search),
                hintText: "Search News",
                contentPadding: EdgeInsets.all(0),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(
                    color: Colors.redAccent,
                    width: 0.3,
                  ),
                ),
              ),

              // onChanged: (value) async {
              //   await updateList(value);
              // },
            ),
          ),
        ),
        Flexible(
            flex: 1,
            child: TextButton(
                onPressed: () {
                  searchController.clear();
                },
                child: Text(
                  "Cancel",
                  style:
                      TextStyle(color: Colors.redAccent.shade400, fontSize: 18),
                )))
      ],
    ),
  );
}
