// To parse this JSON data, do
//
//     final zakaat = zakaatFromJson(jsonString);

import 'dart:convert';

Zakaat zakaatFromJson(String str) => Zakaat.fromJson(json.decode(str));

String zakaatToJson(Zakaat data) => json.encode(data.toJson());

class Zakaat {
    ZakaatData data;
    String message;

    Zakaat({
        required this.data,
        required this.message,
    });

    factory Zakaat.fromJson(Map<String, dynamic> json) => Zakaat(
        data: ZakaatData.fromJson(json["data"]),
        message: json["message"],
    );

    Map<String, dynamic> toJson() => {
        "data": data.toJson(),
        "message": message,
    };
}

class ZakaatData {
    int count;
    List<ZakaatRow> rows;

    ZakaatData({
        required this.count,
        required this.rows,
    });

    factory ZakaatData.fromJson(Map<String, dynamic> json) => ZakaatData(
        count: json["count"],
        rows: List<ZakaatRow>.from(json["rows"].map((x) => ZakaatRow.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "count": count,
        "rows": List<dynamic>.from(rows.map((x) => x.toJson())),
    };
}

class ZakaatRow {
    int id;
    String parent;
    String categoryName;
    bool isDeleted;
    DateTime createdAt;
    DateTime updatedAt;

    ZakaatRow({
        required this.id,
        required this.parent,
        required this.categoryName,
        required this.isDeleted,
        required this.createdAt,
        required this.updatedAt,
    });

    factory ZakaatRow.fromJson(Map<String, dynamic> json) => ZakaatRow(
        id: json["id"],
        parent: json["parent"],
        categoryName: json["category_name"],
        isDeleted: json["is_deleted"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "parent": parent,
        "category_name": categoryName,
        "is_deleted": isDeleted,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
    };
}
