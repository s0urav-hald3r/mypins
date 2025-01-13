class PinModel {
  PinModel({
    required this.imageUrl,
    required this.isSelected,
  });

  final String? imageUrl;
  final bool? isSelected;

  PinModel copyWith({
    String? imageUrl,
    bool? isSelected,
  }) {
    return PinModel(
      imageUrl: imageUrl ?? this.imageUrl,
      isSelected: isSelected ?? this.isSelected,
    );
  }

  factory PinModel.fromJson(Map<String, dynamic> json) {
    return PinModel(
      imageUrl: json["imageUrl"],
      isSelected: false,
    );
  }

  Map<String, dynamic> toJson() => {
        "imageUrl": imageUrl,
        "isSelected": false,
      };

  @override
  String toString() {
    return "$imageUrl, $isSelected";
  }
}
