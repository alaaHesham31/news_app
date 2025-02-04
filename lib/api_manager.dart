import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:news_app/models/source_response.dart';

import 'models/news_data_response.dart';

class ApiManager {
   static Future<SourceResponse> getResources() async {
    Uri url = Uri.https('newsapi.org', '/v2/top-headlines/sources',
        {'apiKey': '462899c3d2b44f11b1a3a0fea7581bcc'});

    http.Response response = await http.get(url);

    var json = jsonDecode(response.body);

     SourceResponse sourceResponse = SourceResponse.fromJson(json);

     return sourceResponse;
  }


   static Future<NewsDataResponse>  getNewsData( String sourceId) async{
    Uri url = Uri.https('newsapi.org', '/v2/everything',
        {'apiKey': '462899c3d2b44f11b1a3a0fea7581bcc',
        'sources': sourceId});

    http.Response response = await http.get(url);

    var json = jsonDecode(response.body);
    NewsDataResponse newsDataResponse = NewsDataResponse.fromJson(json);

    return newsDataResponse ;

  }
}
