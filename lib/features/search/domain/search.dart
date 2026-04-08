import 'package:flutter/material.dart';
import 'package:manga/features/home/data/models/anime_details_model.dart';
import 'package:manga/features/home/presentation/anime_details.dart';
import 'package:manga/features/search/data/search_api.dart';

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
    return FutureBuilder<List<AnimeDetailsModel>>(
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

        // return ListView.builder(
        //   itemCount: results.length,
        //   itemBuilder: (context, index) {
        //     final anime = results[index];
        //     return ListTile(
        //       leading: Image.network(
        //         anime.imageUrl,
        //         width: 50,
        //         height: 50,
        //         fit: BoxFit.cover,
        //       ),
        //       title: Text(anime.title),
        //       onTap: () {
        //         // Naviguer vers la page de détails de l'anime
        //       },
        //     );
        //   },
        // );
        return SingleChildScrollView(
          child: GridView.count(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            padding: const EdgeInsets.all(16),
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            crossAxisCount: 3,
            childAspectRatio: 0.6,
            children: List.generate(results.length, (index) {
              final anime = results[index];
              return GestureDetector(
                onTap: () {
                  // Naviguer vers une page de détails avec les informations de l'anime
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          AnimeDetails(anime: anime, animedetails: anime),
                    ),
                  );
                },
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.network(
                          anime.imageUrl,
                          fit: BoxFit.cover,
                          width: double.infinity,
                        ),
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      anime.title,
                      maxLines: 2,
                      style: const TextStyle(fontSize: 12),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              );
            }),
          ),
        );
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return buildResults(context);
  }
}
