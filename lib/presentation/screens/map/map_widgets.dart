import 'dart:async';

import 'package:flutter/material.dart';
import 'package:animation_search_bar/animation_search_bar.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps/business_logic/cubits/map_cubit/map_cubit.dart';
import 'package:google_maps/business_logic/cubits/map_cubit/map_state.dart';
import 'package:google_maps/data/repositories/map_repo.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

Completer<GoogleMapController> mapController = Completer();
var searchController = TextEditingController();

late int myIndex ;



Widget mainWidgetForMap (context , state) {

  return Scaffold(
          body: SafeArea(
            child: position != null
                ?

            Stack(
                alignment: AlignmentDirectional.topCenter,
                children: [

                  Stack(
                    alignment: AlignmentDirectional.bottomEnd,
                    children: [
                      buildMap(context),
                      Padding(
                          padding: const EdgeInsetsDirectional.all(15),
                          child: floatingActionButton()),
                    ],),

                  SizedBox(
                    height: MediaQuery.of(context).size.height/1.1,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Padding(
                            padding: const EdgeInsetsDirectional.all(15),
                            child: floatingSearchBar(context)),


                        if (MapCubit.get(context).directionModel?.status == 'OK' && searchController.text == '' )

                          Padding(
                          padding: const EdgeInsetsDirectional.only(top: 20 , start: 16 , end: 16 ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                            Container(
                              width: MediaQuery.of(context).size.width/3 ,
                              decoration: BoxDecoration(
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.5),
                                      spreadRadius: 2,
                                      blurRadius: 6,
                                      offset: const Offset(0, 3),
                                    )],
                                  color: Colors.white  , borderRadius: BorderRadius.circular(5)),
                              padding: const EdgeInsetsDirectional.all(15),
                              child: Center(child: Text( '${MapCubit.get(context).directionModel?.routes?[0].legs?[0].duration?.text}' , overflow: TextOverflow.ellipsis , maxLines: 1 , style: Theme.of(context).textTheme.bodyMedium!.copyWith(fontWeight: FontWeight.bold), )),
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width/3 ,
                              decoration: BoxDecoration(
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.5),
                                      spreadRadius: 2,
                                      blurRadius: 6,
                                      offset: const Offset(0, 3),
                                    )],
                                  color: Colors.white  , borderRadius: BorderRadius.circular(5)),
                              padding: const EdgeInsetsDirectional.all(15),
                              child: Center(child: Text('${MapCubit.get(context).directionModel?.routes?[0].legs?[0].distance?.text}' , overflow: TextOverflow.ellipsis , maxLines: 1 , style: Theme.of(context).textTheme.bodyMedium!.copyWith(fontWeight: FontWeight.bold), )),
                            ),
                          ],),
                        ) ,

                        const SizedBox(height: 20,),

                        ConditionalBuilder(
                            condition: searchController.text != '',
                            builder: (context) =>
                            MapCubit.get(context).searchedPlacesModel?.predictions?.length != null ? (state is LoadingPlaceDetailsState  || state is LoadingDirectionState ? const CircularProgressIndicator(): searchedPlacesList(context)): const CircularProgressIndicator(),
                            fallback: (context) => Container()
                        ),

                      ],),
                  )

                ])
                : const Center(
              child: CircularProgressIndicator() ,)  ,
          ),);


}




Widget searchedPlacesList(context) => Expanded(
  child: SingleChildScrollView(
    physics: const BouncingScrollPhysics(),
    child: SizedBox(
      height: MediaQuery.of(context).size.height/1.1,
      child: ListView.separated(
          physics: const BouncingScrollPhysics(),
          scrollDirection: Axis.vertical,
          itemBuilder: (context , index) =>
              InkWell(
                onTap: (){

                  MapCubit.get(context).getPlaceDetailsMethod(placeId: (MapCubit.get(context).searchedPlacesModel?.predictions?[index].placeId)!);

                  myIndex = index ;

                },
                child: Padding(
                  padding: const EdgeInsetsDirectional.symmetric(horizontal: 16),
                  child: Container(
                    width: MediaQuery.of(context).size.width/1.1 ,
                    height: 100,
                    decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 2,
                            blurRadius: 6,
                            offset: const Offset(0, 3),
                          )],
                        color: Colors.white  , borderRadius: BorderRadius.circular(12)),
                    padding: const EdgeInsetsDirectional.all(15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [

                      Expanded(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,

                          children: [

                          Expanded(child:

                          Text((MapCubit.get(context).searchedPlacesModel?.predictions?[index].description)!.split(',')[0],
                            maxLines: 1 , overflow: TextOverflow.ellipsis , style: Theme.of(context).textTheme.titleLarge!.copyWith(fontWeight: FontWeight.bold),),


                          ),
                          const SizedBox(height: 5,),
                          Expanded(child:

                          Text((MapCubit.get(context).searchedPlacesModel?.predictions?[index].description)!.split(',')[1],
                            maxLines: 1 , overflow: TextOverflow.ellipsis , style: Theme.of(context).textTheme.titleMedium!.copyWith(fontWeight: FontWeight.w500),),


                          ),

                        ],),
                      ),

                        const SizedBox(width: 7,),
                        const Icon(Icons.place)
                      ],),
                  ),
                ),
              ),
          separatorBuilder: (context , index) => const SizedBox(height: 10,),
          itemCount: MapCubit.get(context).searchedPlacesModel!.predictions!.length),),
  ),
) ;








FloatingActionButton floatingActionButton () => FloatingActionButton(onPressed: (){ goToMyCurrentLocation();} , child: const Icon(Icons.place_outlined), );



  Widget floatingSearchBar(context) {
return Container(
  width: MediaQuery.of(context).size.width/1.1 ,
  decoration: BoxDecoration(
    color: Colors.white,
      borderRadius: BorderRadius.circular(5),
      boxShadow: [
  BoxShadow(
  color: Colors.grey.withOpacity(0.6),
  spreadRadius: 4,
  blurRadius: 5,
  offset: const Offset(0, 3),
  )]
  ),
  child: AnimationSearchBar(

  onChanged: (text) {
    MapCubit.get(context).searchControlValue = searchController.text ;

    MapCubit.get(context).getSearchedPlaceMethod(place: text);
    MapCubit.get(context).searchOnChangedMethod( control: searchController.text);


  },
  searchTextEditingController: searchController,
  centerTitle: 'Find a place...',
  hintText: 'Search here...',
  centerTitleStyle: const TextStyle(
      fontWeight: FontWeight.bold,color:  Colors.black, fontSize: 20),

  hintStyle: const TextStyle(
      color:  Colors.black38, fontWeight: FontWeight.w500),
      isBackButtonVisible: false ,

  textStyle: const TextStyle(
      color:  Colors.black, fontWeight: FontWeight.w500),

  duration: const Duration(milliseconds: 500),
  searchFieldHeight: 40,
  searchBarHeight: 60,
    searchBarWidth: MediaQuery.of(context).size.width/1.2,
    horizontalPadding: 5,
  verticalPadding: 5,
  searchIconColor: Colors.black,
  searchFieldDecoration: BoxDecoration(
      color: Colors.white,
      border: Border.all(color: Colors.black.withOpacity(.2), width: 1),
      borderRadius: BorderRadius.circular(12)),
),);
    }




Widget buildMap(context) {
  return GoogleMap(
    markers: MapCubit.get(context).markers,
    mapType: MapType.normal,
    myLocationEnabled: true,
    zoomControlsEnabled: false,
    myLocationButtonEnabled: false,
    initialCameraPosition: myCameraPosition(),
    onMapCreated: (GoogleMapController controller) {
      mapController.complete(controller);
    },
    polylines: MapCubit.get(context).directionModel?.status == 'OK'
        ? {
      Polyline(
        polylineId: const PolylineId('my_polyline'),
        color: Colors.black,
        width: 2,
        points: polylineMethod(context)
      ),}
        : {},


  );
}


CameraPosition myCameraPosition () {
  CameraPosition myCameraPosition = CameraPosition(
    bearing: 0.0,
    target: LatLng(position!.latitude, position!.longitude),
    tilt: 0.0,
    zoom: 17,
  );

  return myCameraPosition ;
}

CameraPosition searchedPlaceCameraPosition ({required context}) {
  CameraPosition cameraPosition = CameraPosition(
    bearing: 0.0,
    target: LatLng((MapCubit.get(context).placeDetailsModel?.result?.geometry?.location?.lat)!,
        (MapCubit.get(context).placeDetailsModel?.result?.geometry?.location?.lng)!),
    tilt: 0.0,
    zoom: 14,
  );

  return cameraPosition ;
}



Future<void> goToMyCurrentLocation() async {
  final GoogleMapController controller = await mapController.future;
  controller.animateCamera(
      CameraUpdate.newCameraPosition(myCameraPosition()));
}

Future<void> goToSelectedLocation(context) async {
  final GoogleMapController controller = await mapController.future;
  controller.animateCamera(
      CameraUpdate.newCameraPosition(searchedPlaceCameraPosition(context: context)));

  addMarkerToSelectedLocation (context);
  addMarkerToMyCurrentLocation (context);
}


void addMarkerToSelectedLocation (context){

     Marker selectedLocationMarker = Marker(
      position: searchedPlaceCameraPosition(context: context).target ,
        markerId: const MarkerId('1'),
        onTap: (){},
        infoWindow: InfoWindow(title: MapCubit.get(context).searchedPlacesModel?.predictions![myIndex].description),
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
     );

     MapCubit.get(context).markersBox(selectedLocationMarker);
}



void addMarkerToMyCurrentLocation (context){

  Marker myCurrentLocationMarker = Marker(
    position: myCameraPosition().target ,
    markerId: const MarkerId('2'),
    infoWindow: const InfoWindow(title: 'Your Current Location'),
    icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
  );
  MapCubit.get(context).markersBox(myCurrentLocationMarker);
}


List<LatLng> polylineMethod(context){



  return PolylinePoints().decodePolyline('${MapCubit.get(context).directionModel?.routes?[0].overviewPolyline?.points}').map((e) => LatLng(e.latitude, e.longitude))
      .toList();
}
