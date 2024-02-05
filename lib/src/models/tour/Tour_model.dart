// To parse this JSON data, do
//
//     final service = serviceFromJson(jsonString);

import 'dart:convert';

Tour serviceFromJson(String str) => Tour.fromJson(json.decode(str));

String serviceToJson(Tour data) => json.encode(data.toJson());

class Tour {
  Tour({
    required this.data,
  });

  Data data;

  factory Tour.fromJson(Map<String, dynamic> json) => Tour(
        data: Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "data": data.toJson(),
      };
}

class Data {
  Data({
    required this.toursPackages,
  });

  List<ToursPackage> toursPackages;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        toursPackages: List<ToursPackage>.from(
            json["toursPackages"].map((x) => ToursPackage.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "toursPackages":
            List<dynamic>.from(toursPackages.map((x) => x.toJson())),
      };
}

class ToursPackage {
  ToursPackage({
    required this.id,
    required this.tourname,
    required this.price,
    required this.description,
    required this.duration,
    required this.images,
  });

  int id;
  String tourname;
  int price;
  String duration;
  String description;
  List<TourImage> images;

  factory ToursPackage.fromJson(Map<String, dynamic> json) => ToursPackage(
        id: json["id"],
        tourname: json["tourname"],
        description: json["description"],
        price: json["price"],
        duration: json["duration"],
        images: List<TourImage>.from(
            json["images"].map((x) => TourImage.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "tourname": tourname,
        "description" : description,
        "price": price,
        "duration": duration,
        "images": List<dynamic>.from(images.map((x) => x.toJson())),
      };
}

class TourImage {
  TourImage({
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

  factory TourImage.fromJson(Map<String, dynamic> json) => TourImage(
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

class MyTourBookings {
  List<MyTours> data;
  String message;

  MyTourBookings({
    required this.data,
    required this.message,
  });

  factory MyTourBookings.fromJson(Map<String, dynamic> json) => json["data"] == null
      ? MyTourBookings(data: [MyTours(id: 0,description: '',product_id: 0,quantity: '0',name: '',price: 0,images: [])], message: 'No Items Added Yet.')
      : MyTourBookings(
    data: List<MyTours>.from(json["data"].map((x) => MyTours.fromJson(x))),
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
    "message": message,
  };

}

class MyTours {
  int? id,product_id;
  String? name,quantity;
  String? description;
  int? price;
  List<MyTourImage> images;

  MyTours({
    required  this.id,
    required  this.name,
    required  this.description,
    required  this.price,
    required  this.images,
    required  this.product_id,
    required  this.quantity,
  });

  factory MyTours.fromJson(Map<String, dynamic> json) => MyTours(
    id: json["id"],
    product_id: json['tour']['id'],
    name: json['tour']["tourname"],
    description: json['tour']["description"],
    price: json['tour']["price"],
    images: json['tour']['images']!=null ? List<MyTourImage >.from(json['tour']["images"].map((x) => MyTourImage .fromJson(x))) : [MyTourImage(id: 0, parent: '0', parentId: 0, imagepath: 'imagepath', createdAt: DateTime.now(), updatedAt: DateTime.now())],
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

class MyTourImage {
  int id;
  String parent;
  int parentId;
  String imagepath;
  DateTime createdAt;
  DateTime updatedAt;

  MyTourImage ({
    required this.id,
    required this.parent,
    required this.parentId,
    required this.imagepath,
    required this.createdAt,
    required this.updatedAt,
  });

  factory MyTourImage .fromJson(Map<String, dynamic> json) => MyTourImage (
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
