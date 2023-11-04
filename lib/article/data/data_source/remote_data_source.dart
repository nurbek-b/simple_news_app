import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart';
import 'package:news_test/article/data/model/article.dart';
import 'package:news_test/core/handle_error/execptions.dart';


abstract class RemoteData {
  Future<List<Article>> getData(
      {required int pageNumber, required int numberOfArticlesPerRequest});
}

class RemoteDataImpl extends RemoteData {
  @override
  Future<List<Article>> getData(
      {required int pageNumber, required int numberOfArticlesPerRequest}) async {
    final response = await get(Uri.parse(
        "https://jsonplaceholder.typicode.com/posts?_page=$pageNumber&_limit=$numberOfArticlesPerRequest"));
log('RESPONSE: $response');
    try {
      List responseList = json.decode(response.body);
      List<Article> articleList = responseList
          .map((data) => Article(data['title'], data['body']))
          .toList();
      return articleList;
    } catch (e) {
      throw ServerException(message: e.toString());
    }
  }
}
