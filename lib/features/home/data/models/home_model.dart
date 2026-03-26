class HomeModel {
  final String title;
  final String imageUrl;

  HomeModel({required this.title, required this.imageUrl});

  factory HomeModel.fromJson(Map<String, dynamic> json) {
    return HomeModel(
      title: json['title'] as String,
      imageUrl: json['images']['jpg']['large_image_url'] as String,
    );
  }
}
