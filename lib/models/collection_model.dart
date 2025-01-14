import 'package:mypins/models/pin_model.dart';

class CollectionModel {
  CollectionModel({
    required this.name,
    required this.pins,
  });

  final String? name;
  final List<PinModel> pins;

  CollectionModel copyWith({
    String? name,
    List<PinModel>? pins,
  }) {
    return CollectionModel(
      name: name ?? this.name,
      pins: pins ?? this.pins,
    );
  }

  factory CollectionModel.fromJson(Map<String, dynamic> json) {
    return CollectionModel(
      name: json["name"],
      pins: json["pins"] == null
          ? []
          : List<PinModel>.from(json["pins"]!.map((x) => PinModel.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() => {
        "name": name,
        "pins": pins.map((x) => x.toJson()).toList(),
      };

  @override
  String toString() {
    return "$name, $pins";
  }
}
