import 'package:flutter/material.dart';
import 'package:manga/core/theme.dart';

class WatchlistPage extends StatelessWidget {
  const WatchlistPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Watchlist'),
        backgroundColor: AppTheme.darkTheme.appBarTheme.backgroundColor,
      ),
      body: const Center(
        child: Text('Page de Watchlist', style: TextStyle(fontSize: 24)),
      ),
    );
  }
}
