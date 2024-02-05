// To parse this JSON data, do
//
//     final qurbani = qurbaniFromJson(jsonString);

import 'dart:convert';

Qurbani qurbaniFromJson(String str) => Qurbani.fromJson(json.decode(str));

String qurbaniToJson(Qurbani data) => json.encode(data.toJson());

class Qurbani {
  QurbaniData data;
  String message;

  Qurbani({
    required this.data,
    required this.message,
  });

  factory Qurbani.fromJson(Map<String, dynamic> json) => Qurbani(
        data: QurbaniData.fromJson(json["data"]),
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "data": data.toJson(),
        "message": message,
      };
}

class QurbaniData {
  int count;
  List<QurbaniRow> rows;

  QurbaniData({
    required this.count,
    required this.rows,
  });

  factory QurbaniData.fromJson(Map<String, dynamic> json) => QurbaniData(
        count: json["count"],
        rows: List<QurbaniRow>.from(
            json["rows"].map((x) => QurbaniRow.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "count": count,
        "rows": List<dynamic>.from(rows.map((x) => x.toJson())),
      };
}

class QurbaniRow {
  int id;
  int index;
  String qurbaniType;
  String size;
  int price;
  String description;
  bool isDeleted;
  DateTime createdAt;
  DateTime updatedAt;

  QurbaniRow({
    required this.id,
    required this.index,
    required this.qurbaniType,
    required this.size,
    required this.price,
    required this.description,
    required this.isDeleted,
    required this.createdAt,
    required this.updatedAt,
  });

  factory QurbaniRow.fromJson(Map<String, dynamic> json) => QurbaniRow(
        id: json["id"],
        index: json["index"],
        qurbaniType: json["qurbani_type"],
        size: json["size"],
        price: json["price"],
        description: json["description"],
        isDeleted: json["is_deleted"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "qurbani_type": qurbaniType,
        "size": size,
        "price": price,
        "description": description,
        "is_deleted": isDeleted,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
      };
}
