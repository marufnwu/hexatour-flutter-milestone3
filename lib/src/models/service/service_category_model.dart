import 'dart:convert';

ServicesSearch serviceFromJson(String str) => ServicesSearch.fromJson(json.decode(str));

String serviceToJson(ServicesSearch data) => json.encode(data.toJson());

class ServicesSearch {
    ServicesSearch({
        required this.data,
        required this.message,
    });

    List<SearchService> data;
    String message;

    factory ServicesSearch.fromJson(Map<String, dynamic> json) => ServicesSearch(
        data: List<SearchService>.from(json["data"].map((x) => SearchService.fromJson(x))),
        message: json["message"],
    );

    Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
        "message": message,
    };
}

class SearchService {
    SearchService({
        required this.id,
        required this.serviceName,
    });

    int id;
    String serviceName;

    factory SearchService.fromJson(Map<String, dynamic> json) => SearchService(
        id: json["id"],
        serviceName: json["service_name"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "service_name": serviceName,
    };
}
