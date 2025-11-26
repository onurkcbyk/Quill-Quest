import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class BookProvider extends ChangeNotifier {
  List<dynamic> books = [];

  Future<void> fetchBooks() async {
    const url = 'https://openlibrary.org/subjects/fantasy.json?limit=10';
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      books = List.from(data['works']).map((e) => {
        'title': e['title'],
        'author': (e['authors'] != null && e['authors'].isNotEmpty) ? e['authors'][0]['name'] : 'Unknown'
      }).toList();
      notifyListeners();
    }
  }
}
