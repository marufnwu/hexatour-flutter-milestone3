// To parse this JSON data, do
//
//     final service = serviceFromJson(jsonString);

import 'dart:convert';

Service serviceFromJson(String str) => Service.fromJson(json.decode(str));

String serviceToJson(Service data) => json.encode(data.toJson());

class Service {
  Service({
    required this.data,
  });

  Data data;

  factory Service.fromJson(Map<String, dynamic> json) => Service(
        data: Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "data": data.toJson(),
      };
}

class Data {
  Data({
    required this.servicePackages,
  });

  List<ServicePackage> servicePackages;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        servicePackages: List<ServicePackage>.from(
            json["servicePackages"].map((x) => ServicePackage.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "servicePackages":
            List<dynamic>.from(servicePackages.map((x) => x.toJson())),
      };
}

class ServicePackage {
  ServicePackage({
    required this.id,
    required this.serviceName,
    required this.description,
    required this.images,
  });

  int id;
  String serviceName;
  String description;
  List<dynamic> images;

  factory ServicePackage.fromJson(Map<String, dynamic> json) => ServicePackage(
        id: json["id"],
          description: json["description"],
        serviceName: json["service_name"],
        images: List<dynamic>.from(
            json["images"].map((x) => ServiceImages.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "service_name": serviceName,
        "images": List<dynamic>.from(images.map((x) => x.toJson())),
      };
}

class ServiceImages {
  ServiceImages({
    required this.imagepath,
  });

  String imagepath;

  factory ServiceImages.fromJson(Map<String, dynamic> json) => ServiceImages(
        imagepath: json["imagepath"],
      );

  Map<String, dynamic> toJson() => {};
}

class MyServiceBookings {
  List<MyServices> data;
  String message;

  MyServiceBookings({
    required this.data,
    required this.message,
  });

  factory MyServiceBookings.fromJson(Map<String, dynamic> json) => json["data"] == null
      ? MyServiceBookings(data: [MyServices(id: 0,description: '',product_id: 0,quantity: '0',name: '',price: 0,images: [])], message: 'No Items Added Yet.')
      : MyServiceBookings(
    data: List<MyServices>.from(json["data"].map((x) => MyServices.fromJson(x))),
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
    "message": message,
  };

}

class MyServices {
  int? id,product_id;
  String? name,quantity;
  String? description;
  int? price;
  List<MyServicesImage> images;

  MyServices({
    required  this.id,
    required  this.name,
    required  this.description,
    required  this.price,
    required  this.images,
    required  this.product_id,
    required  this.quantity,
  });

  factory MyServices.fromJson(Map<String, dynamic> json) => MyServices(
    id: json["id"],
    product_id: json['service']['id'],
    name: json['service']["service_name"],
    description: json['service']["description"],
    price: json['service']["service_price"],
    images: json['service']['images']!=null ? List<MyServicesImage >.from(json['service']["images"].map((x) => MyServicesImage .fromJson(x))) : [MyServicesImage(id: 0, parent: '0', parentId: 0, imagepath: 'imagepath', createdAt: DateTime.now(), updatedAt: DateTime.now())],
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

class MyServicesImage {
  int id;
  String parent;
  int parentId;
  String imagepath;
  DateTime createdAt;
  DateTime updatedAt;

  MyServicesImage ({
    required this.id,
    required this.parent,
    required this.parentId,
    required this.imagepath,
    required this.createdAt,
    required this.updatedAt,
  });

  factory MyServicesImage .fromJson(Map<String, dynamic> json) => MyServicesImage (
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