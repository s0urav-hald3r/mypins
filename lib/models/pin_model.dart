class PinModel {
  PinModel({
    required this.title,
    required this.description,
    required this.imageUrl,
    required this.pinterestLink,
    required this.isSelected,
    required this.userName,
    required this.userFullName,
    required this.userImage,
    required this.isPinned,
  });

  final String? title;
  final String? description;
  final String? imageUrl;
  final String? pinterestLink;
  final bool? isSelected;
  final String? userName;
  final String? userFullName;
  final String? userImage;
  final bool? isPinned;

  PinModel copyWith({
    String? title,
    String? description,
    String? imageUrl,
    String? pinterestLink,
    bool? isSelected,
    String? userName,
    String? userFullName,
    String? userImage,
    bool? isPinned,
  }) {
    return PinModel(
      title: title ?? this.title,
      description: description ?? this.description,
      imageUrl: imageUrl ?? this.imageUrl,
      pinterestLink: pinterestLink ?? this.pinterestLink,
      isSelected: isSelected ?? this.isSelected,
      userName: userName ?? this.userName,
      userFullName: userFullName ?? this.userFullName,
      userImage: userImage ?? this.userImage,
      isPinned: isPinned ?? this.isPinned,
    );
  }

  factory PinModel.fromJson(Map<String, dynamic> json) {
    return PinModel(
      title: json["title"],
      description: json["description"],
      imageUrl: json["imageUrl"],
      pinterestLink: json["pinterestLink"],
      isSelected: false,
      userName: json["userName"],
      userFullName: json["userFullName"],
      userImage: json["userImage"],
      isPinned: json["isPinned"],
    );
  }

  Map<String, dynamic> toJson() => {
        "title": title,
        "description": description,
        "imageUrl": imageUrl,
        "pinterestLink": pinterestLink,
        "isSelected": false,
        "userName": userName,
        "userFullName": userFullName,
        "userImage": userImage,
        "isPinned": isPinned,
      };

  @override
  String toString() {
    return "$title, $description, $imageUrl, $pinterestLink, $isSelected, $userName, $userFullName, $userImage, $isPinned";
  }
}
