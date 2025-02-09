import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:news_app/bloc/states.dart';
import 'package:http/http.dart' as http;

import '../models/source_response.dart';


class HomeCubit extends Cubit<HomeStates> {
  SourceResponse? sourceResponse;

  HomeCubit() : super(HomeInitState());

  void getSources(String catId) async{
    try{
      emit(GetSourcesLoadingState());
      Uri url = Uri.https('newsapi.org', '/v2/top-headlines/sources',
          {'apiKey': '462899c3d2b44f11b1a3a0fea7581bcc'});

      http.Response response = await http.get(url);
      if (response.statusCode == 200) {
        var json = jsonDecode(response.body);
        sourceResponse = SourceResponse.fromJson(json);
        emit(GetSourcesSuccessState());
      } else {
        emit(GetSourcesErrorState());
      }
    }catch(e){
      emit(GetSourcesErrorState());

    }



  }
}
