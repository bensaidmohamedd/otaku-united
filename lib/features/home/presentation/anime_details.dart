import 'package:flutter/material.dart';
import 'package:manga/features/home/data/models/anime_details_model.dart';
import 'package:manga/features/watchlists/presentation/state/watchlist_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AnimeDetails extends ConsumerStatefulWidget {
  final AnimeDetailsModel animedetails;

  const AnimeDetails({
    super.key,
    required this.animedetails,
    required AnimeDetailsModel anime,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => AnimeDetailsState();
}

class AnimeDetailsState extends ConsumerState<AnimeDetails> {
  @override
  Widget build(BuildContext context) {
    final watchlist = ref.watch(watchlistProvider);
    final isSaved = watchlist.any((a) => a.id == widget.animedetails.id);
    return Scaffold(
      appBar: AppBar(title: Text('Détails de l\'anime')),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 500,
              child: Stack(
                children: [
                  Positioned.fill(
                    child: Image.network(
                      widget.animedetails.imageUrl,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Positioned.fill(
                    child: Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.bottomCenter,
                          end: Alignment.topCenter,
                          colors: [
                            Colors.black.withOpacity(0.8),
                            Colors.black.withOpacity(0.3),
                            Colors.transparent,
                          ],
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 10,
                    right: 10,
                    child: Container(
                      padding: EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                      ),
                      child: IconButton(
                        icon: Icon(
                          isSaved ? Icons.bookmark : Icons.bookmark_border,
                          color: Color(0xFFE53935),
                        ),
                        onPressed: () {
                          if (isSaved) {
                            ref
                                .read(watchlistProvider.notifier)
                                .removeFromWatchlist(widget.animedetails.id);
                          } else {
                            ref
                                .read(watchlistProvider.notifier)
                                .addToWatchlist(widget.animedetails);
                          }
                        },
                      ),
                    ),
                  ),
                  Positioned(
                    left: 10,
                    right: 10,
                    bottom: 20,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.animedetails.title,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            shadows: [
                              Shadow(
                                blurRadius: 10,
                                color: Colors.black,
                                offset: Offset(2, 2),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 5),
                        Text(
                          "Action, Aventure, Fantastique",
                          style: TextStyle(color: Colors.white70),
                        ),
                        SizedBox(height: 5),
                        Row(
                          children: [
                            Icon(Icons.star, color: Colors.amber, size: 16),
                            SizedBox(width: 4),
                            Text(
                              "${widget.animedetails.score}/10 (${widget.animedetails.nbVotes} votes)",
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            Text(
              'Synopsis',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            Text(
              widget.animedetails.description,
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
