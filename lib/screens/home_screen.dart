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
  String query = 'flutter';

  @override
  void initState() {
    super.initState();
    fetchBooks();
  }

  void fetchBooks() async {
    final fetchedBooks = await BookService().fetchBooks(query);
    setState(() {
      books = fetchedBooks;
    });
  }

  @override
  Widget build(BuildContext context) {
    final favoritesProvider = context.read<FavoritesProvider>();

    return Scaffold(
      backgroundColor: const Color(0xFF422725),
      appBar: AppBar(
        title: const Text('Quill Quest'),
        backgroundColor: const Color(0xFF422725),
        titleTextStyle: const TextStyle(
          color: Colors.white,
          fontSize: 20
        ),

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
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              decoration: const InputDecoration(
                labelText: 'Search books by topic',
                labelStyle: TextStyle(color: Colors.white),
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.search, color: Colors.white),
              ),
              style: const TextStyle(color: Colors.white),
              onSubmitted: (value) {
                setState(() {
                  query = value;
                });
                fetchBooks();
              },
            ),
          ),
          Expanded(
            child: books.isEmpty
                ? const Center(child: CircularProgressIndicator())
                : ListView.builder(
              itemCount: books.length,
              itemBuilder: (context, index) {
                final book = books[index];
                final isFavorite = favoritesProvider.isFavorite(book);

                return ListTile(
                  title: Text(book['title'] ?? 'No Title', style: const TextStyle(color: Colors.white)),
                  subtitle: Text(book['authors']?.join(', ') ?? 'Unknown Author', style: const TextStyle(color: Colors.white70)),
                  trailing: IconButton(
                    icon: Icon(
                      isFavorite ? Icons.favorite : Icons.favorite_border,
                      color: isFavorite ? Colors.red : Colors.white70,
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
          ),
        ],
      ),
    );
  }
}