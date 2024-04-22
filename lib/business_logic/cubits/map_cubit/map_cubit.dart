import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps/business_logic/cubits/map_cubit/map_state.dart';
import 'package:google_maps/data/models/direction_model.dart';
import 'package:google_maps/data/models/place_details_model.dart';
import 'package:google_maps/data/models/searched_places_model.dart';
import 'package:google_maps/data/repositories/map_repo.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';



class MapCubit extends Cubit<MapState> {

  final MapRepo mapRepo ;

  MapCubit({required this.mapRepo}) : super(MapInitial());

  static MapCubit get(context) => BlocProvider.of(context);

  String searchControlValue = '' ;

  Set<Marker> markers = Set() ;




  dynamic searchOnChangedMethod ({required String control}){

    searchControlValue == control ;
    emit(SearchOnChangedState());
  }


 Future<void> getCurrentLocation() async {

   emit(LoadingGettingLocationState());

   await mapRepo.getCurrentLocation().then((value) {


     emit(SuccessGettingLocationState());

   }).catchError((onError){


     emit(ErrorGettingLocationState());

   });

 }





 SearchedPlacesModel? searchedPlacesModel;

Future<void> getSearchedPlaceMethod({required String place}) async {

  emit(LoadingSearchedPlaceState());

   await mapRepo.getSearchedPlace(place: place).then((value) {

     searchedPlacesModel = SearchedPlacesModel.fromJson(value.data);

     emit(SuccessSearchedPlaceState());


   }).catchError((onError){

     emit(ErrorSearchedPlaceState());
   });

}








  PlaceDetailsModel? placeDetailsModel;

  Future<void> getPlaceDetailsMethod({required String placeId}) async {

    emit(LoadingPlaceDetailsState());

    await mapRepo.getPlaceDetails(placeId: placeId).then((value) {

      placeDetailsModel = PlaceDetailsModel.fromJson(value.data);

      emit(SuccessPlaceDetailsState());


    }).catchError((onError){

      emit(ErrorPlaceDetailsState());
    });

  }




  DirectionModel? directionModel;

  Future<void> getDirectionMethod({required dynamic origin, required dynamic destination}) async {

    emit(LoadingDirectionState());

    await mapRepo.getDirection(origin: origin , destination: destination).then((value) {

      directionModel = DirectionModel.fromJson(value.data);

      emit(SuccessDirectionState());


    }).catchError((onError){

      emit(ErrorDirectionState());
    });

  }





  void markersBox(Marker marker){

    markers.add(marker);
    emit(MarkersState());

  }



}
