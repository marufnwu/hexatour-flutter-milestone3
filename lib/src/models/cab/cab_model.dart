// To parse this JSON data, do
//
//     final cab = cabFromJson(jsonString);

import 'dart:convert';

Cab cabFromJson(String str) => Cab.fromJson(json.decode(str));

String cabToJson(Cab data) => json.encode(data.toJson());

class Cab {
  Cab({
    required this.data,
    required this.message,
  });

  List<CabModel> data;
  String message;

  factory Cab.fromJson(Map<String, dynamic> json) => Cab(
        data:
            List<CabModel>.from(json["data"].map((x) => CabModel.fromJson(x))),
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
        "message": message,
      };
}

class CabModel {
  CabModel({
    this.id,
    this.cabType,
    this.cabName,
    this.cabModal,
    this.duration,
    this.cabSize,
    this.cabStatus,
    this.cabNumber,
    this.price,
    this.pricePerKm,
    this.contactNumber,
    this.createdAt,
    this.updatedAt,
    this.image,
    this.minimumBookingAmount,
  });

  int? id;
  String? cabType;
  String? cabName;
  String? cabModal;
  String? duration;
  int? cabSize;
  String? cabStatus;
  String? cabNumber;
  int? price;
  int? minimumBookingAmount;
  dynamic pricePerKm;
  String? contactNumber;
  DateTime? createdAt;
  DateTime? updatedAt;
  CabImage? image;

  factory CabModel.fromJson(Map<String, dynamic> json) => CabModel(
        id: json["id"],
        cabType: json["cab_type"],
        cabName: json["cab_name"],
        cabModal: json["cab_modal"],
        duration: json["duration"],
        cabSize: json["cab_size"],
        cabStatus: json["cab_status"],
        cabNumber: json["cab_number"],
        price: json["price"], // out station
        minimumBookingAmount: json["minimum_booking_amount"],
        pricePerKm: json["price_per_km"], // in station
        contactNumber: json["contact_number"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        image: CabImage.fromJson(json["image"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "cab_type": cabType,
        "cab_name": cabName,
        "cab_modal": cabModal,
        "duration": duration,
        "cab_size": cabSize,
        "cab_status": cabStatus,
        "cab_number": cabNumber,
        "price": price,
        "price_per_km": pricePerKm,
        "contact_number": contactNumber,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "image": image?.toJson(),
      };
}

class CabImage {
  CabImage({
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

  factory CabImage.fromJson(Map<String, dynamic> json) => CabImage(
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


class MyCabBookings {
  List<MyCabs> data;
  String message;

  MyCabBookings({
    required this.data,
    required this.message,
  });

  factory MyCabBookings.fromJson(Map<String, dynamic> json) => json["data"] == null
      ? MyCabBookings(data: [MyCabs(id: 0,product_id: 0,quantity: '0',name: '',images: '')], message: 'No Items Added Yet.')
      : MyCabBookings(
    data: List<MyCabs>.from(json["data"].map((x) => MyCabs.fromJson(x))),
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
    "message": message,
  };

}

class MyCabs {
  int? id,product_id;
  String? name,quantity;
  String images;

  MyCabs({
    required  this.id,
    required  this.name,
    required  this.images,
    required  this.product_id,
    required  this.quantity,
  });

  factory MyCabs.fromJson(Map<String, dynamic> json) => MyCabs(
    id: json["id"],
    product_id: json['cab']['id'],
    name: json['cab']["cab_name"],
    images: json['cab']['image']['imagepath'],
    quantity: json['quantity'].toString(),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "image": images,
    "quantity": quantity,
  };

}

class MyCabsImage {
  int id;
  String parent;
  int parentId;
  String imagepath;
  DateTime createdAt;
  DateTime updatedAt;

  MyCabsImage ({
    required this.id,
    required this.parent,
    required this.parentId,
    required this.imagepath,
    required this.createdAt,
    required this.updatedAt,
  });

  factory MyCabsImage .fromJson(Map<String, dynamic> json) => MyCabsImage (
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

