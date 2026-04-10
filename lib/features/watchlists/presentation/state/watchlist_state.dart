import 'package:manga/features/home/data/models/anime_details_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class WatchlistState extends Notifier<List<AnimeDetailsModel>> {
  @override
  List<AnimeDetailsModel> build() {
    return [];
  }

  void addToWatchlist(AnimeDetailsModel anime) {
    if (!state.any((a) => a.id == anime.id)) {
      state = [...state, anime];
    }
  }

  void removeFromWatchlist(int id) {
    state = state.where((anime) => anime.id != id).toList();
  }
}

final watchlistProvider =
    NotifierProvider<WatchlistState, List<AnimeDetailsModel>>(
      () => WatchlistState(),
    );
