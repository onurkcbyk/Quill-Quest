import 'dart:convert';
import 'package:http/http.dart' as http;

class BookService {
  Future<List> fetchBooks([String query = 'flutter']) async {
    final url = Uri.parse('https://www.googleapis.com/books/v1/volumes?q=$query');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final items = data['items'] as List?;
      return items?.map((item) {
        final volumeInfo = item['volumeInfo'];
        return {
          'title': volumeInfo['title'],
          'authors': volumeInfo['authors'],
          'description': volumeInfo['description'],
        };
      }).toList() ?? [];
    } else {
      throw Exception('Failed to load books');
    }
  }
}
