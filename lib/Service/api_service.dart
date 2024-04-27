import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:kalpas_assign/Data/news_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ApiService extends ChangeNotifier {
  List<Article> articles = [];
  List<Article> favorites = [];
  List<Article> filterList = [];

  // Lets call the api and fill the data
  Future<void> getArticles(int page) async {
    final apiHead =
        "https://newsapi.org/v2/everything?q=tesla&apiKey=1d5424fca4b145e3848a4f50c6a3016d&pageSize=10&page=$page";

    http.Response res = await http.get(Uri.parse(apiHead));

    // Statuscode == 200
    // print("TUSHAR 2: ${res.statusCode}");
    if (res.statusCode == 200) {
      // print("TUSHAR 3 ");
      Map<String, dynamic> json = jsonDecode(res.body);

      List<dynamic> body = json['articles'];

      articles += body.map((dynamic item) => Article.fromJson(item)).toList();
      print("Articles loaded Length: ${articles.length}");
    }
    notifyListeners();
  }

  Future<void> getFavorites(int page) async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    final List<String>? favoritesList = sp.getStringList("articles");
    if (favoritesList != null) {
      favorites = favoritesList
          .map((article) => Article.fromJson(jsonDecode(article)))
          .toList();
    }
    notifyListeners();
  }

  Future<void> filter(var search) async {
    String searchAPI =
        "https://newsapi.org/v2/everything?q=tesla&apiKey=1d5424fca4b145e3848a4f50c6a3016d?q=$search";

    http.Response res = await http.get(Uri.parse(searchAPI));

    if (res.statusCode == 200) {
      Map<String, dynamic> json = jsonDecode(res.body);

      List<dynamic> body = json['articles'];

      // Convert each show in the list to a Movie object
      filterList = body.map((dynamic item) => Article.fromJson(item)).toList();
    } else {
      print("Error: Searching");
    }
    notifyListeners();
  }

  Map<String, Uint8List> _imageCache = {};

  Future<Uint8List?> imageFor(Article article) async {
    // Size: 0 - small, 1 large
    String imageUrl = article.urlToImage;

    if (_imageCache.containsKey(imageUrl)) {
      return _imageCache[imageUrl];
    }
    // Fetch the image from the network
    http.Response response = await http.get(Uri.parse(imageUrl));

    if (response.statusCode == 200) {
      Uint8List imageBytes = response.bodyBytes;
      _imageCache[imageUrl] = imageBytes;
      return imageBytes;
    } else {
      // Handle error, return a default image, or throw an exception
      print('Failed to load image: ${response.statusCode}');
      return Uint8List(0); // Return an empty Uint8List for simplicity
    }
  }
}
