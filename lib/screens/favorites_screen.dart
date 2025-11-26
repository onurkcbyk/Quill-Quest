import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/favorites_provider.dart';
import 'book_detail_screen.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final favorites = context.watch<FavoritesProvider>().favorites;

    return Scaffold(
      backgroundColor: const Color(0xFF422725),
      appBar: AppBar(
        title: const Text('Favorites'),
        backgroundColor: const Color(0xFF422725),
        titleTextStyle: const TextStyle(
            color: Colors.white,
            fontSize: 20
        ),
      ),
      body: favorites.isEmpty
          ? const Center(
        child: Text('No favorite books yet.', style: TextStyle(color: Colors.white)),
      )
          : ListView.builder(
        itemCount: favorites.length,
        itemBuilder: (context, index) {
          final book = favorites[index];
          return ListTile(
            title: Text(book['title'] ?? 'No Title', style: const TextStyle(color: Colors.white)),
            subtitle: Text(book['authors']?.join(', ') ?? 'Unknown Author', style: const TextStyle(color: Colors.white70)),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => BookDetailScreen(book: book),
                ),
              );
            },
          );
        },
      ),
    );
  }
}