// To parse this JSON data, do
//
//     final wishlist = wishlistFromJson(jsonString);

import 'dart:convert';

Wishlist wishlistFromJson(String str) => Wishlist.fromJson(json.decode(str));

String wishlistToJson(Wishlist data) => json.encode(data.toJson());

class Wishlist {
  List<Favorits> data;
  String message;

  Wishlist({
    required this.data,
    required this.message,
  });
  factory Wishlist.fromJson(Map<String, dynamic> json) => 
  // json["data"] == null
  //     ? Wishlist(data: [
  //         Favorits(
  //             id: 0,
  //             description: '',
  //             availability: '',
  //             categoryId: 0,
  //             createdAt: DateTime.now(),
  //             isDeleted: true,
  //             price: 0,
  //             images: [
  //               FavoriteImage(
  //                   id: 0,
  //                   parent: 'parent',
  //                   parentId: 0,
  //                   imagepath: '',
  //                   createdAt: DateTime.now(),
  //                   updatedAt: DateTime.now())
  //             ],
  //             productExpiryDate: DateTime.now(),
  //             productName: '',
  //             updatedAt: DateTime.now())
  //       ], message: 'No Items Added Yet.')
  //     : 
   Wishlist(
      data:
     List<Favorits>.from(json["data"].map((x) => Favorits.fromJson(x))),
    
      message: json["message"],
  );

  Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
        "message": message,
      };
}

class Favorits {
  int id;
  String productName;
  String description;
  int price;
  int categoryId;
  DateTime productExpiryDate;
  String availability;
  bool isDeleted;
  DateTime createdAt;
  DateTime updatedAt;
  List<FavoriteImage> images;

  Favorits({
    required this.id,
    required this.productName,
    required this.description,
    required this.price,
    required this.categoryId,
    required this.productExpiryDate,
    required this.availability,
    required this.isDeleted,
    required this.createdAt,
    required this.updatedAt,
    required this.images,
  });

  factory Favorits.fromJson(Map<String, dynamic> json) => Favorits(
        id: json["id"],
        productName: json["product_name"],
        description: json["description"],
        price: json["price"],
        categoryId: json["category_id"],
        productExpiryDate: DateTime.parse(json["product_expiry_date"]),
        availability: json["availability"],
        isDeleted: json["is_deleted"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        images: List<FavoriteImage>.from(
            json["images"].map((x) => FavoriteImage.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "product_name": productName,
        "description": description,
        "price": price,
        "category_id": categoryId,
        "product_expiry_date": productExpiryDate.toIso8601String(),
        "availability": availability,
        "is_deleted": isDeleted,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "images": List<dynamic>.from(images.map((x) => x.toJson())),
      };
}

class FavoriteImage {
  int id;
  String parent;
  int parentId;
  String imagepath;
  DateTime createdAt;
  DateTime updatedAt;

  FavoriteImage({
    required this.id,
    required this.parent,
    required this.parentId,
    required this.imagepath,
    required this.createdAt,
    required this.updatedAt,
  });

  factory FavoriteImage.fromJson(Map<String, dynamic> json) => FavoriteImage(
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
