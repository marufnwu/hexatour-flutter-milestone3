class Dropdown {
  Dropdown({
    required this.id,
    required this.category_id,
    required this.name,
    required this.tag,
    this.destination,
  });

  int id,category_id;
  String name;
  String tag;
  Destination? destination;

  factory Dropdown.fromJson(Map<String, dynamic> json, String type) => Dropdown(
      id: json["id"],
      name: json[type],
      tag: json["tag"],
      category_id: json['category_id'],
      destination: json['destination'] == null
          ? null
          : Destination.fromJson(json["destination"]));

  Map<String, dynamic> toJson() =>
      {"id": id, "type": name, "tag": tag, "destination": destination,'category_id': category_id};
}

class Destination {
  Destination({
    required this.id,
    required this.locationName,
    required this.locationType,
    this.createdAt,
    this.updatedAt,
  });

  int id;
  String locationName;
  String locationType;
  dynamic createdAt;
  dynamic updatedAt;

  factory Destination.fromJson(Map<String, dynamic> json) => Destination(
        id: json["id"],
        locationName: json["location_name"],
        locationType: json["location_type"],
        createdAt: json["createdAt"],
        updatedAt: json["updatedAt"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "location_name": locationName,
        "location_type": locationType,
        "createdAt": createdAt,
        "updatedAt": updatedAt,
      };
}
