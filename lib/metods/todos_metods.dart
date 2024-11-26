import 'package:http/http.dart' as http;
import 'package:task/const/url_constant.dart';
import 'dart:convert';

import '../models/todos_models.dart';

class TodosMetods {
  Future<List<TodoModel>> fetchTodos() async {
    try {
      final response = await http.get(Uri.parse(UrlConstant.baseUrl));

      if (response.statusCode == 200) {
        List<dynamic> body = json.decode(response.body);
        List<TodoModel> todos = body
            .take(20)
            .map((dynamic item) => TodoModel.fromJson(item))
            .toList();
        return todos;
      } else {
        throw Exception('Todolar yüklenemedi');
      }
    } catch (e) {
      throw Exception('Ağ hatası: $e');
    }
  }
}
