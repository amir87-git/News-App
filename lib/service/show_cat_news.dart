import 'dart:convert';
import 'dart:ffi';
import 'package:http/http.dart'as http;
import 'package:news/model/show_category.dart';
import 'package:news/model/slider_mod.dart';

class ShowCatNews{
  List<ShowCatMod> categories = [];

  Future<Void> getCategoriesNews(String category) async{
    String url = "https://newsapi.org/v2/top-headlines?country=us&category=$category&apiKey=6c094aebf12b4dab9e472576c32ab964";
    var response = await http.get(Uri.parse(url));

    var jsonData = jsonDecode(response.body);

    if(jsonData['status'] == 'ok') {
      jsonData["articles"].forEach((element) {
        if (element['urlToImage']! = null && element['description']! = null) {
          ShowCatMod catMod = ShowCatMod(
            author: element["author"],
            title: element["title"],
            description: element["description"],
            url: element["url"],
            urlToImage: element["urlToImage"],
            publishedAt: element["publishedAt"],
            content: element["content"],  
          );
          categories.add(catMod);
        }
      });
    }

  }
}