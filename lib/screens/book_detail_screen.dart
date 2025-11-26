import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/favorites_provider.dart';

class BookDetailScreen extends StatelessWidget {
  final Map book;

  const BookDetailScreen({super.key, required this.book});

  @override
  Widget build(BuildContext context) {
    final favoritesProvider = context.watch<FavoritesProvider>();
    final isFavorite = favoritesProvider.isFavorite(book);

    return Scaffold(
      backgroundColor: const Color(0xFF422725),
      appBar: AppBar(
        backgroundColor: const Color(0xFF422725),
        title: Text(book['title'] ?? 'Book'),
        titleTextStyle: const TextStyle(
            color: Colors.white,
            fontSize: 20
        ),

      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              book['title'] ?? 'No Title',
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
            ),
            const SizedBox(height: 10),
            Text(
              'Author(s): ${book['authors']?.join(', ') ?? 'Unknown'}',
              style: const TextStyle(color: Colors.white70),
            ),
            const SizedBox(height: 20),
            Text(
              book['description'] ?? 'No description available.',
              style: const TextStyle(color: Colors.white70),
            ),
            const SizedBox(height: 20),
            IconButton(
              icon: Icon(
                isFavorite ? Icons.favorite : Icons.favorite_border,
                color: isFavorite ? Colors.red : Colors.white70,
              ),
              onPressed: () {
                favoritesProvider.toggleFavorite(book);
              },
            ),
          ],
        ),
      ),
    );
  }
}