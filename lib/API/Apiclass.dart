import 'dart:convert';
import 'package:flutter_app_test/main.dart';

import 'ResponseModelForContentModel.dart';
import 'ResponseModelForTage.dart';
import "package:http/http.dart" as http;

class API_DATA {
  var chips_data = List<Tags_Chip>.empty();

  /// fetches the tags from the api
  Future<List<Tags_Chip>> fetchTagsData() async {
    List<Tags_Chip> list;
    var url = Uri.parse(
        'https://run.mocky.io/v3/c498ac6a-5be7-4ac3-b407-b703af3e2247');
    final response = await http.get(url);
    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      var rest = data["tags"] as List;
      // print("TAGS");
      // print(rest);
      // print("END TAGS");
      list = rest.map<Tags_Chip>((json) => Tags_Chip.fromJson(json)).toList();
      // ChipsWithColor(tagList);
      return list;
    } else {
      throw Exception('Unexpected error occured!');
    }
  }

  ///fetches the contents from the api
  Future<List<LearnContent>> fetchContentData() async {
    List<LearnContent> contentlist;
    var url = Uri.parse(
        'https://run.mocky.io/v3/742454fc-089b-47df-b7c1-4c1ce4091586');
    final response = await http.get(url);
    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      var rest = data["learn_content"] as List;
      // print("response body ${response.body}");
      // print("CONTENTS");
      // print(rest);
      // print("END CONTENTS");
      contentlist = rest.map<LearnContent>((json) => LearnContent.fromJson(json)).toList();
      // if (chipSlected.isEmpty) {
      //   print('--------------NO FILTERCHIP USED----------');
      //   return contentlist;
      // } else {
      //   for (int i = 0; i < contentlist.length; i++) {
      //    contentlist.where((element) => element.tags[i].name == chipSlected).toList();
      //   }
      if(contentlist.isEmpty){
        print('EMPTY');
      }
      return contentlist;

      // }
    }
    else
      {
      throw Exception('Unexpected error occured!');
    }
  }
}
