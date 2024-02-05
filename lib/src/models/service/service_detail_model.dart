// To parse this JSON data, do
//
//     final service = serviceFromJson(jsonString);

import 'dart:convert';

ServiceModel serviceFromJson(String str) =>
    ServiceModel.fromJson(json.decode(str));

String serviceToJson(ServiceModel data) => json.encode(data.toJson());

class ServiceModel {
  ServiceModel({
    required this.data,
    required this.message,
  });

  ServiceData data;
  String message;

  factory ServiceModel.fromJson(Map<String, dynamic> json) => ServiceModel(
        data: ServiceData.fromJson(json["data"]),
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "data": data.toJson(),
        "message": message,
      };
}

class ServiceData {
  ServiceData({
    this.id,
    this.serviceName,
    this.description,
    this.categoryId,
    this.servicePrice,
    this.createdAt,
    this.updatedAt,
    this.images,
  });

  int? id;
  String? serviceName;
  String? description;
  int? categoryId;
  int? servicePrice;
  DateTime? createdAt;
  DateTime? updatedAt;
  List<ServiceImage>? images;

  factory ServiceData.fromJson(Map<String, dynamic> json) => ServiceData(
        id: json["id"],
        serviceName: json["service_name"],
        description: json["description"],
        categoryId: json["category_id"],
        servicePrice: json["service_price"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        images: List<ServiceImage>.from(
            json["images"].map((x) => ServiceImage.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "service_name": serviceName,
        "description": description,
        "category_id": categoryId,
        "service_price": servicePrice,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "images": List<dynamic>.from(images!.map((x) => x.toJson())),
      };
}

class ServiceImage {
  ServiceImage({
    required this.id,
    required this.parent,
    required this.parentId,
    required this.imagepath,
    required this.createdAt,
    required this.updatedAt,
  });

  int id;
  String parent;
  int parentId;
  String imagepath;
  DateTime createdAt;
  DateTime updatedAt;

  factory ServiceImage.fromJson(Map<String, dynamic> json) => ServiceImage(
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
