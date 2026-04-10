import 'package:flutter/material.dart';
import 'package:manga/features/home/presentation/anime_details.dart';
import 'package:manga/features/watchlists/presentation/state/watchlist_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class WatchlistPage extends ConsumerWidget {
  const WatchlistPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final watchlist = ref.watch(watchlistProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Watchlist')),
      body: watchlist.isEmpty
          ? const Center(child: Text("Aucun anime ajouté"))
          : GridView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: watchlist.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                childAspectRatio: 0.6,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
              ),
              itemBuilder: (context, index) {
                final anime = watchlist[index];

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
                    children: [
                      Expanded(child: Image.network(anime.imageUrl)),
                      Text(
                        anime.title,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                );
              },
            ),
    );
  }
}
