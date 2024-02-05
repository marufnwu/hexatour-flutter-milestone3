import 'dart:convert';

SearchProduct searchProductFromJson(String str) => SearchProduct.fromJson(json.decode(str));

String searchProductToJson(SearchProduct data) => json.encode(data.toJson());

class SearchProduct {
    DataSearch data;

    SearchProduct({
        required this.data,
    });

    factory SearchProduct.fromJson(Map<String, dynamic> json) => SearchProduct(
        data: DataSearch.fromJson(json["data"]),
    );

    Map<String, dynamic> toJson() => {
        "data": data.toJson(),
    };
}

class DataSearch {
    List<ProductType> products;

    DataSearch({
        required this.products,
    });

    factory DataSearch.fromJson(Map<String, dynamic> json) => DataSearch(
        products: List<ProductType>.from(json["products"].map((x) => ProductType.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "products": List<dynamic>.from(products.map((x) => x.toJson())),
    };
}

class ProductType {
    int ?id;
    String ?productName;
    String? description;
    int ?price;
    int ?categoryId;
    DateTime? productExpiryDate;
    String ?availability;
    bool ?isDeleted;
    DateTime ?createdAt;
    DateTime ?updatedAt;
    Category? category;

    ProductType({
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
         this.category,
    });

    factory ProductType.fromJson(Map<String, dynamic> json) => ProductType(
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
        category: Category.fromJson(json["category"]),
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
        "category": category?.toJson(),
    };
}

class Category {
    int id;
    String parent;
    String categoryName;
    bool isDeleted;
    DateTime createdAt;
    DateTime updatedAt;

    Category({
        required this.id,
        required this.parent,
        required this.categoryName,
        required this.isDeleted,
        required this.createdAt,
        required this.updatedAt,
    });

    factory Category.fromJson(Map<String, dynamic> json) => Category(
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

MyBookings wishlistFromJson(String str) => MyBookings.fromJson(json.decode(str));

String wishlistToJson(MyBookings data) => json.encode(data.toJson());

class MyBookings {
    List<MyProducts> data;
    String message;

    MyBookings({
        required this.data,
        required this.message,
    });

    factory MyBookings.fromJson(Map<String, dynamic> json) => json["data"] == null
        ? MyBookings(data: [MyProducts(id: 0,description: '',product_id: 0,quantity: '0',name: '',price: 0,images: [])], message: 'No Items Added Yet.')
        : MyBookings(
        data: List<MyProducts>.from(json["data"].map((x) => MyProducts.fromJson(x))),
        message: json["message"],
    );

    Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
        "message": message,
    };

}

class MyProducts {
    int? id,product_id;
    String? name,quantity;
    String? description;
    int? price;
    List<MyProductsImage> images;

    MyProducts({
        required  this.id,
        required  this.name,
        required  this.description,
        required  this.price,
        required  this.images,
        required  this.product_id,
        required  this.quantity,
    });

    factory MyProducts.fromJson(Map<String, dynamic> json) => MyProducts(
        id: json["id"],
        product_id: json['product']['id'],
        name: json['product']["product_name"],
        description: json['product']["description"],
        price: json['product']["price"],
        images: json['product']['images']!=null ? List<MyProductsImage >.from(json['product']["images"].map((x) => MyProductsImage .fromJson(x))) : [MyProductsImage(id: 0, parent: '0', parentId: 0, imagepath: 'imagepath', createdAt: DateTime.now(), updatedAt: DateTime.now())],
        quantity: json['quantity'].toString(),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "description": description,
        "price": price,
        "images": List<dynamic>.from(images.map((x) => x.toJson())),
        "quantity": quantity,
    };

}

class MyProductsImage {
    int id;
    String parent;
    int parentId;
    String imagepath;
    DateTime createdAt;
    DateTime updatedAt;

    MyProductsImage ({
        required this.id,
        required this.parent,
        required this.parentId,
        required this.imagepath,
        required this.createdAt,
        required this.updatedAt,
    });

    factory MyProductsImage .fromJson(Map<String, dynamic> json) => MyProductsImage (
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
