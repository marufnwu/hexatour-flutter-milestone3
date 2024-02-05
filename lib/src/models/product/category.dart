// To parse this JSON data, do
//
//     final productCategory = productCategoryFromJson(jsonString);

import 'dart:convert';

ProductCategory productCategoryFromJson(String str) => ProductCategory.fromJson(json.decode(str));

String productCategoryToJson(ProductCategory data) => json.encode(data.toJson());

class ProductCategory {
    List<CategoriesProduct> data;
    String message;

    ProductCategory({
        required this.data,
        required this.message,
    });

    factory ProductCategory.fromJson(Map<String, dynamic> json) => ProductCategory(
        data: List<CategoriesProduct>.from(json["data"].map((x) => CategoriesProduct.fromJson(x))),
        message: json["message"],
    );

    Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
        "message": message,
    };
}

class CategoriesProduct {
    int id;
    String parent;
    String categoryName;
    bool isDeleted;
    DateTime? createdAt;
    DateTime? updatedAt;

    CategoriesProduct({
        required this.id,
        required this.parent,
        required this.categoryName,
        required this.isDeleted,
        required this.createdAt,
        required this.updatedAt,
    });

    factory CategoriesProduct.fromJson(Map<String, dynamic> json) => CategoriesProduct(
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
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
    };
}
