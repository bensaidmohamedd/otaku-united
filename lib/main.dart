import 'package:flutter/material.dart';
import 'features/home/presentation/myhome_page.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'core/theme.dart';

void main() {
  runApp(ProviderScope(child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Otaku United',
      theme: AppTheme.darkTheme,
      debugShowCheckedModeBanner: false,
      home: const MyHomePage(),
    );
  }
}
