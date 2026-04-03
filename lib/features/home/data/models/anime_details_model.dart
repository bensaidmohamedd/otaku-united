class AnimeDetailsModel {
  final String title;
  final String imageUrl;
  final String description;
  final double score;
  final int nbVotes;

  AnimeDetailsModel({
    required this.title,
    required this.imageUrl,
    required this.description,
    required this.score,
    required this.nbVotes,
  });

  factory AnimeDetailsModel.fromJson(Map<String, dynamic> json) {
    return AnimeDetailsModel(
      title: json['title'] ?? 'No title',
      imageUrl: json['images']?['jpg']?['large_image_url'] ?? '',
      description: json['synopsis'] ?? 'No description',
      score: (json['score'] as num?)?.toDouble() ?? 0.0,
      nbVotes: json['scored_by'] as int? ?? 0,
    );
  }
}
