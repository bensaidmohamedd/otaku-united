class HomeVoirPlusModel {
  final String title;
  final String imageUrl;
  final String description;
  final double score;

  HomeVoirPlusModel({
    required this.title,
    required this.imageUrl,
    required this.description,
    required this.score,
  });

  factory HomeVoirPlusModel.fromJson(Map<String, dynamic> json) {
    return HomeVoirPlusModel(
      title: json['title'] as String,
      imageUrl: json['images']['jpg']['large_image_url'] as String,
      description: json['synopsis'] as String,
      score: (json['score'] as num).toDouble(),
    );
  }
}
