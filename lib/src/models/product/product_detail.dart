// To parse this JSON data, do
//
//     final productDetail = productDetailFromJson(jsonString);

import 'dart:convert';

ProductDetail productDetailFromJson(String str) => ProductDetail.fromJson(json.decode(str));

String productDetailToJson(ProductDetail data) => json.encode(data.toJson());

class ProductDetail {
    ProductData data;
    String message;

    ProductDetail({
        required this.data,
        required this.message,
    });

    factory ProductDetail.fromJson(Map<String, dynamic> json) => ProductDetail(
        data: ProductData.fromJson(json["data"]),
        message: json["message"],
    );

    Map<String, dynamic> toJson() => {
        "data": data.toJson(),
        "message": message,
    };
}

class ProductData {
    int ?id;
    String ?productName;
    String ?description;
    int ?price;
    int ?categoryId;
    DateTime ?productExpiryDate;
    String ?availability;
    bool ?isDeleted;
    DateTime ?createdAt;
    DateTime ?updatedAt;
    List<ProductDataImage> ?images;
    ProductDataCategory ?category;

    ProductData({
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
         this.category,
    });

    factory ProductData.fromJson(Map<String, dynamic> json) => ProductData(
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
        images: List<ProductDataImage>.from(json["images"].map((x) => ProductDataImage.fromJson(x))),
        category: ProductDataCategory.fromJson(json["category"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "product_name": productName,
        "description": description,
        "price": price,
        "category_id": categoryId,
        "product_expiry_date": productExpiryDate!.toIso8601String(),
        "availability": availability,
        "is_deleted": isDeleted,
        "createdAt": createdAt!.toIso8601String(),
        "updatedAt": updatedAt!.toIso8601String(),
        "images": List<dynamic>.from(images!.map((x) => x.toJson())),
        "category": category!.toJson(),
    };
}

class ProductDataCategory {
    int id;
    String parent;
    String categoryName;
    bool isDeleted;
    DateTime createdAt;
    DateTime updatedAt;
    List<ProductDataCategory> productCategoryAttributes;

    ProductDataCategory({
        required this.id,
        required this.parent,
        required this.categoryName,
        required this.isDeleted,
        required this.createdAt,
        required this.updatedAt,
        required this.productCategoryAttributes,
    });

    factory ProductDataCategory.fromJson(Map<String, dynamic> json) => ProductDataCategory(
        id: json["id"],
        parent: json["parent"],
        categoryName: json["category_name"],
        isDeleted: json["is_deleted"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        productCategoryAttributes: List<ProductDataCategory>.from(json["product_category_attributes"].map((x) => x)),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "parent": parent,
        "category_name": categoryName,
        "is_deleted": isDeleted,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "product_category_attributes": List<dynamic>.from(productCategoryAttributes.map((x) => x)),
    };
}

class ProductDataImage {
    int id;
    String parent;
    int parentId;
    String imagepath;
    DateTime createdAt;
    DateTime updatedAt;

    ProductDataImage({
        required this.id,
        required this.parent,
        required this.parentId,
        required this.imagepath,
        required this.createdAt,
        required this.updatedAt,
    });

    factory ProductDataImage.fromJson(Map<String, dynamic> json) => ProductDataImage(
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
