import 'package:flutter/material.dart';
import 'package:manga/core/theme.dart';

class ProfilPage extends StatelessWidget {
  const ProfilPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profil'),
        backgroundColor: AppTheme.darkTheme.appBarTheme.backgroundColor,
      ),
      body: const Center(
        child: Text(
          'Page de Profil',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}