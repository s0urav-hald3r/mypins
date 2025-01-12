class CollectionModel {
  CollectionModel({
    required this.name,
    required this.images,
  });

  final String? name;
  final List<String> images;

  CollectionModel copyWith({
    String? name,
    List<String>? images,
  }) {
    return CollectionModel(
      name: name ?? this.name,
      images: images ?? this.images,
    );
  }

  factory CollectionModel.fromJson(Map<String, dynamic> json) {
    return CollectionModel(
      name: json["name"],
      images: json["images"] == null
          ? []
          : List<String>.from(json["images"]!.map((x) => x)),
    );
  }

  Map<String, dynamic> toJson() => {
        "name": name,
        "images": images.map((x) => x).toList(),
      };

  @override
  String toString() {
    return "$name, $images";
  }
}
