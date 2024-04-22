class SearchedPlacesModel {
  List<Predictions>? predictions;
  String? status;


  SearchedPlacesModel.fromJson(Map<String, dynamic> json) {
    if (json['predictions'] != null) {
      predictions = <Predictions>[];
      json['predictions'].forEach((v) {
        predictions!.add( Predictions.fromJson(v));
      });
    }
    status = json['status'];
  }


}

class Predictions {
  String? description;
  String? placeId;


  Predictions.fromJson(Map<String, dynamic> json) {
    description = json['description'];
    placeId = json['place_id'];
  }


}

