import 'package:flutter/material.dart';

class WatchlistPage extends StatelessWidget {
  const WatchlistPage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Ma Watchlist')),
      body: Text('Votre watchlist est vide pour le moment.'),
    );
  }
}
