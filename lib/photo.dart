class Photo {
  final String title;
  final String thumbnailUrl;

  Photo({required this.title, required this.thumbnailUrl});

  factory Photo.fromJson(Map<String, dynamic> json) {
    return Photo(title: json['title'], thumbnailUrl: json['thumbnailUrl']);
  }
}
