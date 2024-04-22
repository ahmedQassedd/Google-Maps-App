class DirectionModel {
  List<Routes>? routes;
  String? status;


  DirectionModel.fromJson(Map<String, dynamic> json) {
    if (json['routes'] != null) {
      routes = <Routes>[];
      json['routes'].forEach((v) {
        routes!.add( Routes.fromJson(v));
      });
    }
    status = json['status'];
  }


}

class Routes {
  Bounds? bounds;
  List<Legs>? legs;
  OverviewPolyline? overviewPolyline;


  Routes.fromJson(Map<String, dynamic> json) {
    bounds =
    json['bounds'] != null ?  Bounds.fromJson(json['bounds']) : null;
    if (json['legs'] != null) {
      legs = <Legs>[];
      json['legs'].forEach((v) {
        legs!.add( Legs.fromJson(v));
      });
    }
    overviewPolyline = json['overview_polyline'] != null
        ?  OverviewPolyline.fromJson(json['overview_polyline'])
        : null;

  }

}

class Bounds {
  LatLngClass? northeast;
  LatLngClass? southwest;


  Bounds.fromJson(Map<String, dynamic> json) {
    northeast = json['northeast'] != null
        ?  LatLngClass.fromJson(json['northeast'])
        : null;
    southwest = json['southwest'] != null
        ?  LatLngClass.fromJson(json['southwest'])
        : null;
  }


}

class LatLngClass {
  double? lat;
  double? lng;


  LatLngClass.fromJson(Map<String, dynamic> json) {
    lat = json['lat'];
    lng = json['lng'];
  }

}

class Legs {
  Text? distance;
  Text? duration;




  Legs.fromJson(Map<String, dynamic> json) {
    distance = json['distance'] != null
        ?  Text.fromJson(json['distance'])
        : null;
    duration = json['duration'] != null
        ?  Text.fromJson(json['duration'])
        : null;

  }

}

class Text {
  String? text;


  Text.fromJson(Map<String, dynamic> json) {
    text = json['text'];
  }

}

class OverviewPolyline {
  String? points;


  OverviewPolyline.fromJson(Map<String, dynamic> json) {
    points = json['points'];
  }

}
