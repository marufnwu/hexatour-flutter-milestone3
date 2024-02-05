// To parse this JSON data, do
//
//     final offers = offersFromJson(jsonString);

import 'dart:convert';

Offer offersFromJson(String str) => Offer.fromJson(json.decode(str));

String offersToJson(Offer data) => json.encode(data.toJson());

class Offer {
    Offer({
        required this.data,
    });

    List<Datum> data;

    factory Offer.fromJson(Map<String, dynamic> json) => Offer(
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
    };
}

class Datum {
    Datum({
        required this.id,
        required this.offerName,
        required this.offerCategoryId,
        required this.startDate,
        required this.endDate,
        required this.minimumPayment,
        required this.flatOff,
        required this.discountPercent,
        required this.offerStatus,
        required this.createdAt,
        required this.updatedAt,
        required this.image,
    });

    int id;
    String offerName;
    int offerCategoryId;
    DateTime startDate;
    DateTime endDate;
    int minimumPayment;
    int flatOff;
    int discountPercent;
    int offerStatus;
    DateTime createdAt;
    DateTime updatedAt;
    OfferImage image;

    factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        offerName: json["offer_name"],
        offerCategoryId: json["offer_category_id"],
        startDate: DateTime.parse(json["start_date"]),
        endDate: DateTime.parse(json["end_date"]),
        minimumPayment: json["minimum_payment"],
        flatOff: json["flat_off"],
        discountPercent: json["discount_percent"],
        offerStatus: json["offer_status"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        image: OfferImage.fromJson(json["image"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "offer_name": offerName,
        "offer_category_id": offerCategoryId,
        "start_date": startDate.toIso8601String(),
        "end_date": endDate.toIso8601String(),
        "minimum_payment": minimumPayment,
        "flat_off": flatOff,
        "discount_percent": discountPercent,
        "offer_status": offerStatus,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "image": image.toJson(),
    };
}

class OfferImage {
    OfferImage({
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

    factory OfferImage.fromJson(Map<String, dynamic> json) => OfferImage(
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
