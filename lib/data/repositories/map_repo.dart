import 'package:dio/dio.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps/data/web_services/remote/dio_helper.dart';
import 'package:google_maps/data/web_services/remote/end_points.dart';
import 'package:uuid/uuid.dart';



Position? position ;


abstract class MapRepo {

  Future<Position?> getCurrentLocation() ;

  Future<Response> getSearchedPlace({required String place});

  Future<Response> getPlaceDetails({required String placeId});

  Future<Response> getDirection({required dynamic origin , required dynamic destination });



}



class MapRepoImpl extends MapRepo {

  DioHelper? dioHelper ;

  MapRepoImpl({required this.dioHelper});



  @override
  Future<Response> getSearchedPlace({required String  place}) async {

    final sessionToken = Uuid().v4();

    final response = await dioHelper!.getData(
        endPoint: searchedPlaceEndPoint ,
        query:
        {
          'input' : place ,
          'type' : 'address' ,
          'components' : 'country:eg' ,
          'key' : apiKey ,
          'sessiontoken' :  sessionToken ,
        }

        );

    return response ;

  }


  @override
  Future<Response> getPlaceDetails({required String  placeId}) async {

    final sessionToken = Uuid().v4();

    final response = await dioHelper!.getData(
        endPoint: placeDetailsEndPoint ,
        query:
        {
          'place_id' : placeId ,
          'key' : apiKey ,
          'fields' : 'geometry' ,
          'sessiontoken' : sessionToken ,
        }

    );

    return response ;

  }



  @override
  Future<Response> getDirection({required dynamic origin, required dynamic destination}) async{


    final response = await dioHelper!.getData(
        endPoint: directionEndPoint ,
        query:
        {
          'origin' : origin ,
          'destination' : destination ,
          'key' : apiKey ,
        }

    );

    return response ;

  }


  @override
  Future<Position?> getCurrentLocation() async {

    bool? serviceEnabled;
    LocationPermission permission;

   serviceEnabled = await Geolocator.isLocationServiceEnabled();

    if(!serviceEnabled){

      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {

        return null;
      }
    }

     permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {

      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {

        return null;
      }
    }

    if (permission == LocationPermission.deniedForever) {

      return null;
    }

    return  position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );
  }















}