import 'package:flutter/material.dart';

class FavoritesProvider extends ChangeNotifier {
  final List<Map> _favorites = [];

  List<Map> get favorites => _favorites;

  void toggleFavorite(Map book) {
    final exists = _favorites.any((b) => b['title'] == book['title']);
    if (exists) {
      _favorites.removeWhere((b) => b['title'] == book['title']);
    } else {
      _favorites.add(book);
    }
    notifyListeners();
  }

  bool isFavorite(Map book) {
    return _favorites.any((b) => b['title'] == book['title']);
  }
}
