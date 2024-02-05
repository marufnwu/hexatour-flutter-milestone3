
// Cart cartFromJson(String str) => Cart.fromJson(json.decode(str));

// String cartToJson(Cart data) => json.encode(data.toJson());

class Cart {
    List<Cartitem> data;
    String message;

    Cart({
        required this.data,
        required this.message,
    });

    factory Cart.fromMap(Map<String, dynamic> json) => json["data"] == null
    ? Cart(data: [Cartitem(updatedAt: DateTime.now(),createdAt: DateTime.now(),id: 0,productId: 0,quantity: 0,userId: 0,products: [ProductCart(id: 0,createdAt: null,updatedAt: null,productName: null,productExpiryDate: null,images: null,price: null,isDeleted: null,categoryId: null,availability: null,description: null)])], message: 'message')
    : Cart(
        data: List<Cartitem>.from(json["data"].map((x) => Cartitem.fromMap(x))),
        message: json["message"],
    );

    Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
        "message": message,
    };
}

class  Cartitem{
    int ?id;
    int ?productId;
    int ?userId;
    int ?quantity;
    DateTime ?createdAt;
    DateTime ? updatedAt;
    List<ProductCart>? products;

    Cartitem({
         this.id,
         this.productId,
         this.userId,
         this.quantity,
         this.createdAt,
         this.updatedAt,
         this.products,
    });

    factory Cartitem.fromMap(Map<String, dynamic> json) => Cartitem(
        id: json["id"],
        productId: json["product_id"],
        userId: json["user_id"],
        quantity: json["quantity"],
        createdAt:  json['createdAt'] == null ? null : DateTime.parse(json['createdAt'] as String),
        updatedAt: json['updatedAt'] == null ? null : DateTime.parse(json['updatedAt'] as String),
        products: json["products"] != null? List<ProductCart>.from(json["products"].map((x) => ProductCart.fromMap(x))) : <ProductCart>[],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "product_id": productId,
        "user_id": userId,
        "quantity": quantity,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "products": List<ProductCart>.from(products!.map((x) => x.toJson())),
    };
}

class ProductCart {
    int ?id;
    String ?productName;
    String ?description;
    int ?price;
    int? categoryId;
    DateTime ?productExpiryDate;
    String ?availability;
    bool? isDeleted;
    DateTime? createdAt;
    DateTime? updatedAt;
    List<CartImage> ?images;

    ProductCart({
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

    factory ProductCart.fromMap(Map<String, dynamic> json) => ProductCart(
        id: json["id"],
        productName: json["product_name"],
        description: json["description"],
        price: json["price"],
        categoryId: json["category_id"],
        productExpiryDate: DateTime.parse(json["product_expiry_date"]),
        availability: json["availability"],
        isDeleted: json["is_deleted"],
        createdAt: json['createdAt'] == null ? null : DateTime.parse(json['createdAt'] as String),
        updatedAt: json['updatedAt'] == null ? null : DateTime.parse(json['updatedAt'] as String),
        images: List<CartImage>.from(json["images"].map((x) => CartImage.fromJson(x))),
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

class CartImage {
    int id;
    String parent;
    int parentId;
    String imagepath;
    DateTime createdAt;
    DateTime updatedAt;

    CartImage({
        required this.id,
        required this.parent,
        required this.parentId,
        required this.imagepath,
        required this.createdAt,
        required this.updatedAt,
    });

    factory CartImage.fromJson(Map<String, dynamic> json) => CartImage(
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