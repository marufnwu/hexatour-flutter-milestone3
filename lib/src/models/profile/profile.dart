
// Cart cartFromJson(String str) => Cart.fromJson(json.decode(str));

// String cartToJson(Cart data) => json.encode(data.toJson());

class ProfileDetails {
  Profiles data;
  String message;

  ProfileDetails({
    required this.data,
    required this.message,
  });

  factory ProfileDetails.fromMap(Map<String, dynamic> json) => json["data"] == null
      ? ProfileDetails(data: Profiles(id: '0',email: '',gender: '', phone: '',username: ''), message: 'message')
      : ProfileDetails(
    data: Profiles(username: json['data']['username'].toString(),phone: json['data']['phone'].toString(),gender: json['data']['gender'].toString(),email: json['data']['email'].toString(),id: json['data']['id'].toString(),),
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "data": data,
    "message": message,
  };
}

class  Profiles{
  String? id,username,email,phone,gender;


  Profiles({
    this.id,
    this.username,
    this.email,
    this.phone,
    this.gender,
  });

  factory Profiles.fromMap(Map<String, dynamic> json) => Profiles(
    id: json["id"].toString(),
    email:  json["email"].toString(),
    gender:  json["gender"].toString(),
    phone:  json["phone"].toString(),
    username:  json['username'].toString(),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "email": email,
    "gender": gender,
    "phone": phone,
    "username": username,

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