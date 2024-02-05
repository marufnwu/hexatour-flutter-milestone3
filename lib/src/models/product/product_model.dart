// To parse this JSON data, do
//
//     final products = productsFromJson(jsonString);

import 'dart:convert';

Products productsFromJson(String str) => Products.fromJson(json.decode(str));

String productsToJson(Products data) => json.encode(data.toJson());

class Products {
    Products({
        required this.data,
    });

    Datas data;

    factory Products.fromJson(Map<String, dynamic> json) => Products(
        data: Datas.fromJson(json["data"]),
    );

    Map<String, dynamic> toJson() => {
        "data": data.toJson(),
    };
}

class Datas {
    Datas({
        required this.recent,
        required this.topSelling,
    });

    List<Recent> recent;
    List<dynamic> topSelling;

    factory Datas.fromJson(Map<String, dynamic> json) => Datas(
        recent: List<Recent>.from(json["recent"].map((x) => Recent.fromJson(x))),
        topSelling: List<dynamic>.from(json["topSelling"].map((x) => x)),
    );

    Map<String, dynamic> toJson() => {
        "recent": List<dynamic>.from(recent.map((x) => x.toJson())),
        "topSelling": List<dynamic>.from(topSelling.map((x) => x)),
    };
}

class Recent {
    Recent({
        required this.id,
        required this.productName,
        required this.description,
        required this.price,
        required this.categoryId,
        required this.productExpiryDate,
        required this.availability,
        required this.createdAt,
        required this.updatedAt,
        required this.images,
    });

    int id;
    String productName;
    String description;
    int price;
    int categoryId;
    DateTime productExpiryDate;
    String availability;
    DateTime createdAt;
    DateTime updatedAt;
    List<ProductImage> images;

    factory Recent.fromJson(Map<String, dynamic> json) => Recent(
        id: json["id"],
        productName: json["product_name"],
        description: json["description"],
        price: json["price"],
        categoryId: json["category_id"],
        productExpiryDate: DateTime.parse(json["product_expiry_date"]),
        availability: json["availability"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        images: List<ProductImage>.from(json["images"].map((x) => ProductImage.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "product_name": productName,
        "description": description,
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
