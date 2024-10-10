class Meme {
  String image;
  String created;
  String modified;

  Meme({
    required this.image,
    required this.created,
    required this.modified,
  });

  factory Meme.fromJson(Map<String, dynamic> json) {
    return Meme(
      image: json['image'],
      created: json['created'],
      modified: json['modified'],
    );
  }
}
