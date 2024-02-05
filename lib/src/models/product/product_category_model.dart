// To parse this JSON data, do
//
//     final categories = categoriesFromJson(jsonString);

import 'dart:convert';

categoriesProduct categoriesFromJson(String str) => categoriesProduct.fromJson(json.decode(str));

String categoriesToJson(categoriesProduct data) => json.encode(data.toJson());

class categoriesProduct {
    List<ProductsCategory> data;
    String message;

    categoriesProduct({
        required this.data,
        required this.message,
    });

    factory categoriesProduct.fromJson(Map<String, dynamic> json) => categoriesProduct(
        data: List<ProductsCategory>.from(json["data"].map((x) => ProductsCategory.fromJson(x))),
        message: json["message"],
    );

    Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
        "message": message,
    };
}

class ProductsCategory {
    int ?id;
    String ?productName;
    String ?description;
    int ?price;
    int ?categoryId;
    DateTime? productExpiryDate;
    String? availability;
    bool? isDeleted;
    DateTime ?createdAt;
    DateTime ?updatedAt;
    List<ProductsCategoryImage> ?images;

    ProductsCategory({
         this.id,
         this.productName,
         this.description,
         this.price,
        this.categoryId,
       this.productExpiryDate,
        this.availability,
        this.isDeleted,
        this.createdAt,
         this.updatedAt,
         this.images,
    });

    factory ProductsCategory.fromJson(Map<String, dynamic> json) => ProductsCategory(
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
        images: List<ProductsCategoryImage>.from(json["images"].map((x) => ProductsCategoryImage.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "product_name": productName,
        "description": description,
        "price": price,
        "category_id": categoryId,
        "product_expiry_date": productExpiryDate?.toIso8601String(),
        "availability": availability,
        "is_deleted": isDeleted,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "images": List<dynamic>.from(images!.map((x) => x.toJson())),
    };
}

class ProductsCategoryImage {
    int id;
    String parent;
    int parentId;
    String imagepath;
    DateTime createdAt;
    DateTime updatedAt;

    ProductsCategoryImage({
        required this.id,
        required this.parent,
        required this.parentId,
        required this.imagepath,
        required this.createdAt,
        required this.updatedAt,
    });

    factory ProductsCategoryImage.fromJson(Map<String, dynamic> json) => ProductsCategoryImage(
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
