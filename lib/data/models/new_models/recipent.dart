import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

class RecipentResponse extends Equatable {
  RecipentResponse({
    @required this.status,
    @required this.data,
  });

  final String status;
  final List<Recipent> data;

  factory RecipentResponse.fromJson(Map<String, dynamic> json) =>
      RecipentResponse(
        status: json["status"],
        data:
            List<Recipent>.from(json["data"].map((x) => Recipent.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };

  @override
  List<Object> get props => [status, data];
}

class RecipentObjectResponse extends Equatable {
  //Response untuk type non array
  RecipentObjectResponse({
    @required this.data,
  });

  final Recipent data;

  factory RecipentObjectResponse.fromJson(Map<String, dynamic> json) =>
      RecipentObjectResponse(
        data: json["data"] != null ? Recipent.fromJson(json["data"]) : "",
      );

  Map<String, dynamic> toJson() => {"data": data};

  @override
  List<Object> get props => [data];
}

class Recipent {
  Recipent({
    @required this.id,
    this.provinceId,
    this.cityId,
    @required this.name,
    @required this.phone,
    @required this.address,
    @required this.postalCode,
    @required this.subdistrictId,
    @required this.subdistrict,
    @required this.note,
    @required this.email,
    this.province,
    this.city,
    this.latitude,
    this.longitude,
    // @required this.recipentLocation,
    @required this.isMainAddress,
    this.isActive = true,
  });

  final int id;
  final String name;
  final String phone;
  final String address;
  final String postalCode;
  final int provinceId;
  final String province;
  final int cityId;
  final String city;
  final int subdistrictId;
  final String subdistrict;
  final String note;
  final String email;
  final String latitude;
  final String longitude;

  int isMainAddress;
  bool isActive;

  factory Recipent.fromJson(Map<String, dynamic> json) => Recipent(
        id: json["id"] ?? null,
        provinceId: json["province_id"].runtimeType == String
            ? int.parse(json["province_id"])
            : json["province_id"] ?? '',
        cityId: json["city_id"].runtimeType == String
            ? int.parse(json["city_id"])
            : json["city_id"] ?? '',
        name: json["name"] ?? '',
        phone: json["phonenumber"] ?? '',
        address: json["address"] ?? '',
        postalCode: json["postal_code"],
        subdistrictId: json["subdistrict_id"].runtimeType == String
            ? int.parse(json["subdistrict_id"])
            : json["subdistrict_id"] ?? '',
        province: json["province"] ?? '',
        city: json["city"] ?? '',
        subdistrict: json["subdistrict"] ?? '',
        note: json["note"] ?? '',
        email: json["email"] ?? '',
        isMainAddress: json["is_main_address"],
        latitude: json["latitude"] ?? '',
        longitude: json["longitude"] ?? '',
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "province_id": provinceId,
        "city_id": cityId,
        "subdistrict_id": subdistrictId,
        "name": name,
        "phonenumber": phone,
        "address": address,
        "postal_code": postalCode,
        "subdistrict": subdistrict,
        "note": note,
        "email": email,
        "is_main_address": isMainAddress,
        "province": province,
        "city": city,
        "latitude": latitude,
        "longitude": longitude,
      };
  // List<Object> get props => [
  //       id,
  //       provinceId,
  //       cityId,
  //       name,
  //       phone,
  //       address,
  //       postalCode,
  //       recipentLocation,
  //       province,
  //       city,
  //     ];
}

class RecipentLocationPicker {
  RecipentLocationPicker({
    @required this.address,
    @required this.latitude,
    @required this.longitude,
  });

  final String address;
  final String latitude;
  final String longitude;

  factory RecipentLocationPicker.fromJson(Map<String, dynamic> json) =>
      RecipentLocationPicker(
        address: json["address"],
        latitude: json["latitude"],
        longitude: json["longitude"],
      );

  Map<String, dynamic> toJson() => {
        "address": address,
        "latitude": latitude,
        "longitude": longitude,
      };
}
