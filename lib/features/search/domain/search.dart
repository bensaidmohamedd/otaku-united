import 'package:flutter/material.dart';
import 'package:manga/features/search/data/search_api.dart';
import 'package:manga/features/home/data/models/home_model.dart';

class AnimeSearchDelegate extends SearchDelegate {
  @override
  String get searchFieldLabel => "Rechercher un anime";
  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () {
          query = '';
          showSuggestions(context);
        },
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return FutureBuilder<List<HomeModel>>(
      future: searchAnime(query),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        if (snapshot.hasError) {
          return Text("Erreur: ${snapshot.error}");
        }
        if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Text("Aucun résultat trouvé");
        }

        final data = snapshot.data!;

        final results = data
            .where(
              (anime) =>
                  anime.title.toLowerCase().contains(query.toLowerCase()),
            )
            .toList();
        if (results.isEmpty) {
          return const Center(
            child: Text(
              "Aucun résultat trouvé",
              style: TextStyle(fontSize: 16),
            ),
          );
        }

        return ListView.builder(
          itemCount: results.length,
          itemBuilder: (context, index) {
            final anime = results[index];
            return ListTile(
              leading: Image.network(
                anime.imageUrl,
                width: 50,
                height: 50,
                fit: BoxFit.cover,
              ),
              title: Text(anime.title),
              onTap: () {
                // Naviguer vers la page de détails de l'anime
              },
            );
          },
        );
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return buildResults(context);
  }
}
