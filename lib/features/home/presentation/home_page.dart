import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:manga/features/home/data/api/anime_details_api.dart';
import 'package:manga/features/home/data/models/anime_details_model.dart';
import 'package:manga/features/home/presentation/anime_details.dart';
import 'package:manga/features/search/domain/search.dart';
import 'home_voir_plus.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<HomePage> {
  final CarouselSliderController _controller = CarouselSliderController();
  int _current = 0;

  late Future<List<AnimeDetailsModel>> _animeData;

  @override
  void initState() {
    _animeData = fetchAnimeData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Accueil'),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              showSearch(context: context, delegate: AnimeSearchDelegate());
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            FutureBuilder(
              future: _animeData,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (snapshot.hasError) {
                  return Text("veillez utliser une connexion internet");
                }
                if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return const Text("Aucune donnée");
                }

                final data = snapshot.data!;

                return Column(
                  children: [
                    CarouselSlider(
                      items: data.take(5).map((anime) {
                        return GestureDetector(
                          onTap: () {
                            // Naviguer vers une page de détails avec les informations de l'anime
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => AnimeDetails(
                                  anime: anime,
                                  animedetails: anime,
                                ),
                              ),
                            );
                          },
                          child: Container(
                            margin: const EdgeInsets.all(5.0),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.0),
                              image: DecorationImage(
                                image: NetworkImage(anime.imageUrl),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        );
                      }).toList(),
                      carouselController: _controller,
                      options: CarouselOptions(
                        height: 500,
                        autoPlay: true,
                        enlargeCenterPage: true,
                        onPageChanged: (index, reason) {
                          setState(() {
                            _current = index;
                          });
                        },
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: snapshot.data!
                          .take(5)
                          .toList()
                          .asMap()
                          .entries
                          .map((entry) {
                            return GestureDetector(
                              onTap: () => _controller.animateToPage(entry.key),
                              child: Container(
                                width: 12,
                                height: 12,
                                margin: const EdgeInsets.symmetric(
                                  vertical: 8,
                                  horizontal: 4,
                                ),
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color:
                                      (Theme.of(context).brightness ==
                                                  Brightness.dark
                                              ? Colors.red
                                              : Colors.black)
                                          .withValues(
                                            alpha: _current == entry.key
                                                ? 0.9
                                                : 0.4,
                                          ),
                                ),
                              ),
                            );
                          })
                          .toList(),
                    ),
                  ],
                );
              },
            ),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Les plus populaires",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  TextButton(
                    onPressed: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const HomeVoirPlus(),
                      ),
                    ),
                    child: Row(
                      children: const [
                        Text("Voir plus"),
                        SizedBox(width: 5),
                        Icon(Icons.arrow_forward_ios, size: 14),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 10),

            FutureBuilder(
              future: _animeData,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (snapshot.hasError) {
                  return const Text("veillez utliser une connexion internet");
                }
                if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return const Text("Aucune donnée");
                }

                final data = snapshot.data!;

                return GridView.count(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  padding: const EdgeInsets.all(16),
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  crossAxisCount: 3,
                  childAspectRatio: 0.6,
                  children: List.generate(6, (index) {
                    final anime = data[index];
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
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
