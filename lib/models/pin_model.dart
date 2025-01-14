class PinModel {
  PinModel({
    required this.title,
    required this.imageUrl,
    required this.pinterestLink,
    required this.isSelected,
  });

  final String? title;
  final String? imageUrl;
  final String? pinterestLink;
  final bool? isSelected;

  PinModel copyWith({
    String? title,
    String? imageUrl,
    String? pinterestLink,
    bool? isSelected,
  }) {
    return PinModel(
      title: title ?? this.title,
      imageUrl: imageUrl ?? this.imageUrl,
      pinterestLink: pinterestLink ?? this.pinterestLink,
      isSelected: isSelected ?? this.isSelected,
    );
  }

  factory PinModel.fromJson(Map<String, dynamic> json) {
    return PinModel(
      title: json["title"],
      imageUrl: json["imageUrl"],
      pinterestLink: json["pinterestLink"],
      isSelected: false,
    );
  }

  Map<String, dynamic> toJson() => {
        "title": title,
        "imageUrl": imageUrl,
        "pinterestLink": pinterestLink,
        "isSelected": false,
      };

  @override
  String toString() {
    return "$title, $imageUrl, $pinterestLink, $isSelected";
  }
}
