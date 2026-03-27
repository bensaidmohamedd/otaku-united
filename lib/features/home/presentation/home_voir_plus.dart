import 'package:flutter/material.dart';
import 'package:manga/features/home/data/api/home_voir_plus_api.dart';
import 'package:manga/features/home/presentation/anime_details.dart';

class HomeVoirPlus extends StatefulWidget {
  const HomeVoirPlus({super.key});

  @override
  State<HomeVoirPlus> createState() => _HomeVoirPlusState();
}

class _HomeVoirPlusState extends State<HomeVoirPlus> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Les plus populaires")),
      body: FutureBuilder(
        future: fetchAnimeData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text("Erreur: ${snapshot.error}"));
          }
          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text("Aucune donnée"));
          }

          final data = snapshot.data!;
          return ListView.builder(
            itemCount: data.length,
            itemBuilder: (context, index) {
              final anime = data[index];
              return InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => AnimeDetails(anime: anime)),
                  );
                },
                child: Container(
                  margin: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Image.network(
                        anime.imageUrl,
                        width: 100,
                        height: 150,
                        fit: BoxFit.cover,
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              anime.title,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),

                            Row(
                              children: [
                                const Icon(
                                  Icons.star,
                                  color: Colors.amber,
                                  size: 16,
                                ),
                                const SizedBox(width: 4),
                                Text(
                                  "${anime.score}/10",
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                            Text(
                              anime.description,
                              maxLines: 3,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
