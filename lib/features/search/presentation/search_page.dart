import 'package:flutter/material.dart';
import 'package:manga/core/theme.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Recherche'),
      backgroundColor: AppTheme.darkTheme.appBarTheme.backgroundColor,),
      body: const Center(
        child: Text('Page de Recherche', style: TextStyle(fontSize: 24)),
      ),
    );
  }
}
