// To parse this JSON data, do
//
//     final tourData = tourDataFromJson(jsonString);

import 'dart:convert';

TourData tourDataFromJson(String str) => TourData.fromJson(json.decode(str));

String tourDataToJson(TourData data) => json.encode(data.toJson());

class TourData {
  TourData({
    required this.data,
    required this.message,
  });

  DataClass data;
  String message;

  factory TourData.fromJson(Map<String, dynamic> json) => TourData(
        data: DataClass.fromJson(json["data"]),
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "data": data.toJson(),
        "message": message,
      };
}

class DataClass {
  DataClass({
     this.id,
     this.tourname,
     this.duration,
     this.price,
     this.description,
     this.startDate,
     this.endDate,
     this.sourceId,
     this.destinationId,
     this.noOfPerson,
     this.minimumBookingAmount,
     this.tourCategoryId,
     this.createdAt,
     this.updatedAt,
     this.images,
     this.tourItenaries,
     this.source,
     this.destination,
  });

  int? id;
  String ?tourname;
  String? duration;
  int? price;
  String ?description;
  DateTime ?startDate;
  DateTime? endDate;
  int? sourceId;
  int? destinationId;
  int? noOfPerson;
  int? minimumBookingAmount;
  int? tourCategoryId;
  DateTime? createdAt;
  DateTime ?updatedAt;
  List<TourImages> ?images;
  List<TourItenary>? tourItenaries;
  LocDestination? source;
  LocDestination? destination;

  factory DataClass.fromJson(Map<String, dynamic> json) => DataClass(
        id: json["id"],
        tourname: json["tourname"],
        duration: json["duration"],
        price: json["price"],
        description: json["description"],
        startDate: DateTime.parse(json["start_date"]),
        endDate: DateTime.parse(json["end_date"]),
        sourceId: json["source_id"],
        destinationId: json["destination_id"],
        noOfPerson: json["no_of_person"],
        minimumBookingAmount: json["minimum_booking_amount"],
        tourCategoryId: json["tour_category_id"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        images: List<TourImages>.from(
            json["images"].map((x) => TourImages.fromJson(x))),
        tourItenaries: List<TourItenary>.from(
            json["tour_itenaries"].map((x) => TourItenary.fromJson(x))),
        source: LocDestination.fromJson(json["source"]),
        destination: LocDestination.fromJson(json["destination"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "tourname": tourname,
        "duration": duration,
        "price": price,
        "description": description,
        "start_date": startDate?.toIso8601String(),
        "end_date": endDate?.toIso8601String(),
        "source_id": sourceId,
        "destination_id": destinationId,
        "no_of_person": noOfPerson,
        "minimum_booking_amount": minimumBookingAmount,
        "tour_category_id": tourCategoryId,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "images": List<dynamic>.from(images!.map((x) => x.toJson())),
        "tour_itenaries":
            List<dynamic>.from(tourItenaries!.map((x) => x.toJson())),
        "source": source?.toJson(),
        "destination": destination?.toJson(),
      };
}

class LocDestination {
  LocDestination({
    required this.locationName,
  });

  String locationName;

  factory LocDestination.fromJson(Map<String, dynamic> json) => LocDestination(
        locationName: json["location_name"],
      );

  Map<String, dynamic> toJson() => {
        "location_name": locationName,
      };
}

class TourImages {
  TourImages({
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

  factory TourImages.fromJson(Map<String, dynamic> json) => TourImages(
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

class TourItenary {
  TourItenary({
    required this.id,
    required this.tourId,
    required this.itenaryId,
    required this.createdAt,
    required this.updatedAt,
    required this.location,
  });

  int id;
  int tourId;
  int itenaryId;
  DateTime createdAt;
  DateTime updatedAt;
  LocDestination location;

  factory TourItenary.fromJson(Map<String, dynamic> json) => TourItenary(
        id: json["id"],
        tourId: json["tour_id"],
        itenaryId: json["itenary_id"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        location: LocDestination.fromJson(json["location"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "tour_id": tourId,
        "itenary_id": itenaryId,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "location": location.toJson(),
      };
}
