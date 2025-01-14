class PinModel {
  PinModel({
    required this.imageUrl,
    required this.pinterestLink,
    required this.isSelected,
  });

  final String? imageUrl;
  final String? pinterestLink;
  final bool? isSelected;

  PinModel copyWith({
    String? imageUrl,
    String? pinterestLink,
    bool? isSelected,
  }) {
    return PinModel(
      imageUrl: imageUrl ?? this.imageUrl,
      pinterestLink: pinterestLink ?? this.pinterestLink,
      isSelected: isSelected ?? this.isSelected,
    );
  }

  factory PinModel.fromJson(Map<String, dynamic> json) {
    return PinModel(
      imageUrl: json["imageUrl"],
      pinterestLink: json["pinterestLink"],
      isSelected: false,
    );
  }

  Map<String, dynamic> toJson() => {
        "imageUrl": imageUrl,
        "pinterestLink": pinterestLink,
        "isSelected": false,
      };

  @override
  String toString() {
    return "$imageUrl, $pinterestLink, $isSelected";
  }
}
