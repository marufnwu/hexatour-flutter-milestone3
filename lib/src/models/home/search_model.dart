import 'dart:convert';

SearchModel productsFromJson(String str) =>
    SearchModel.fromJson(json.decode(str));

String productsToJson(SearchModel data) => json.encode(data.toJson());



// 

class SearchModel {
  SearchModel({
    required this.id,
    required this.productName,
    required this.description,
    required this.price,
    required this.serviceName,
    required this.tourname,
    required this.duration,
    required this.categoryId,
    required this.productExpiryDate,
    required this.availability,
    required this.createdAt,
    required this.updatedAt,
    required this.images,
  });

  int id;
  String productName;
  String serviceName;
  String tourname;
  String duration;
  String description;
  int price;
  int categoryId;
  DateTime productExpiryDate;
  String availability;
  DateTime createdAt;
  DateTime updatedAt;
  List<ProductImage> images;

  factory SearchModel.fromJson(Map<String, dynamic> json) => SearchModel(
        id: json["id"],
        productName: json["product_name"],
        description: json["description"],
        serviceName: json["serviceName"],
        duration: json["duration"],
        tourname:json["tourname"],
        price: json["price"],
        categoryId: json["category_id"],
        productExpiryDate: DateTime.parse(json["product_expiry_date"]),
        availability: json["availability"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        images: List<ProductImage>.from(
            json["images"].map((x) => ProductImage.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "product_name": productName,
        "description": description,
        "serviceName" : serviceName,
        "tourname" : tourname,
        "duration" : duration,
        "price": price,
        "category_id": categoryId,
        "product_expiry_date": productExpiryDate.toIso8601String(),
        "availability": availability,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "images": List<dynamic>.from(images.map((x) => x.toJson())),
      };
}

class ProductImage {
  ProductImage({
    required this.id,
    required this.imagepath,
  });

  int id;
  String imagepath;

  factory ProductImage.fromJson(Map<String, dynamic> json) => ProductImage(
        id: json["id"],
        imagepath: json["imagepath"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "imagepath": imagepath,
      };
}
