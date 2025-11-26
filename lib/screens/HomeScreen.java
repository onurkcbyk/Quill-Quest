import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../services/book_service.dart';
import '../screens/book_detail_screen.dart';
import '../screens/favorites_screen.dart';
import '../providers/favorites_provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List books = [];

  @override
  void initState() {
    super.initState();
    fetchBooks();
  }

  void fetchBooks() async {
    final fetchedBooks = await BookService().fetchBooks();
    setState(() {
      books = fetchedBooks;
    });
  }

  @override
  Widget build(BuildContext context) {
    final favoritesProvider = context.read<FavoritesProvider>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Quill Quest'),
        actions: [
          IconButton(
            icon: const Icon(Icons.favorite),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const FavoritesScreen()),
              );
            },
          ),
        ],
      ),
      body: books.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: books.length,
              itemBuilder: (context, index) {
                final book = books[index];
                final isFavorite = favoritesProvider.isFavorite(book);

                return ListTile(
                  title: Text(book['title'] ?? 'No Title'),
                  subtitle:
                      Text(book['authors']?.join(', ') ?? 'Unknown Author'),
                  trailing: IconButton(
                    icon: Icon(
                      isFavorite ? Icons.favorite : Icons.favorite_border,
                      color: isFavorite ? Colors.red : null,
                    ),
                    onPressed: () {
                      favoritesProvider.toggleFavorite(book);
                    },
                  ),
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