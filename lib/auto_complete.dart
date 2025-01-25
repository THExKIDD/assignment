
import 'dart:developer';

import 'package:http/http.dart' as http;
import 'dart:convert';
//for autocomplete
class AutoComplete
{

  static Future<List<String>> fetchSuggestions(String query) async {
    try {

      final response = await http.get(Uri.parse('http://universities.hipolabs.com/search?name=$query'));


      if (response.statusCode == 200) {

        List<dynamic> data = json.decode(response.body);

        return data.map((item) => item['name'] as String).toList();

      } else {

        throw Exception('Failed to load suggestions');

      }


    }
    catch (error) {
      log('error in api call: $error');
      return [];
    }
  }
}