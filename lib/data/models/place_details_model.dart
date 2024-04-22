class PlaceDetailsModel {
  Result? result;
  String? status;


  PlaceDetailsModel.fromJson(Map<String, dynamic> json) {

    result = json['result'] != null ?  Result.fromJson(json['result']) : null;
    status = json['status'];
  }


}

class Result {
  Geometry? geometry;


  Result.fromJson(Map<String, dynamic> json) {
    geometry = json['geometry'] != null
        ?  Geometry.fromJson(json['geometry'])
        : null;
  }


}

class Geometry {
  Location? location;


  Geometry.fromJson(Map<String, dynamic> json) {
    location = json['location'] != null
        ?  Location.fromJson(json['location'])
        : null;

  }

}

class Location {
  double? lat;
  double? lng;


  Location.fromJson(Map<String, dynamic> json) {
    lat = json['lat'];
    lng = json['lng'];
  }

}

