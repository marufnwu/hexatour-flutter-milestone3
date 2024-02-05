// To parse this JSON data, do
//
//     final charity = charityFromJson(jsonString);

import 'dart:convert';

Charity charityFromJson(String str) => Charity.fromJson(json.decode(str));

String charityToJson(Charity data) => json.encode(data.toJson());

class Charity {
    CharityData data;
    String message;

    Charity({
        required this.data,
        required this.message,
    });

    factory Charity.fromJson(Map<String, dynamic> json) => Charity(
        data: CharityData.fromJson(json["data"]),
        message: json["message"],
    );

    Map<String, dynamic> toJson() => {
        "data": data.toJson(),
        "message": message,
    };
}

class CharityData {
    int count;
    List<CharityRow> rows;

    CharityData({
        required this.count,
        required this.rows,
    });

    factory CharityData.fromJson(Map<String, dynamic> json) => CharityData(
        count: json["count"],
        rows: List<CharityRow>.from(json["rows"].map((x) => CharityRow.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "count": count,
        "rows": List<dynamic>.from(rows.map((x) => x.toJson())),
    };
}

class CharityRow {
    int id;
    String charityType;
    int price;
    String description;
    bool isDeleted;
    DateTime createdAt;
    DateTime updatedAt;
    CharityImage image;

    CharityRow({
        required this.id,
        required this.charityType,
        required this.price,
        required this.description,
        required this.isDeleted,
        required this.createdAt,
        required this.updatedAt,
        required this.image,
    });

    factory CharityRow.fromJson(Map<String, dynamic> json) => CharityRow(
        id: json["id"],
        charityType: json["charity_type"],
        price: json["price"],
        description: json["description"],
        isDeleted: json["is_deleted"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        image: CharityImage.fromJson(json["image"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "charity_type": charityType,
        "price": price,
        "description": description,
        "is_deleted": isDeleted,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "image": image.toJson(),
    };
}

class CharityImage {
    int id;
    String parent;
    int parentId;
    String imagepath;
    DateTime createdAt;
    DateTime updatedAt;

    CharityImage({
        required this.id,
        required this.parent,
        required this.parentId,
        required this.imagepath,
        required this.createdAt,
        required this.updatedAt,
    });

    factory CharityImage.fromJson(Map<String, dynamic> json) => CharityImage(
        id: json["id"],
        parent: json["parent"],
        parentId: json["parent_id"],
        imagepath: json["imagepath"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "parent": parent,
        "parent_id": parentId,
        "imagepath": imagepath,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
    };
}
