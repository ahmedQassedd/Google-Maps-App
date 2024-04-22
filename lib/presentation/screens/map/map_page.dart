import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps/business_logic/cubits/map_cubit/map_cubit.dart';
import 'package:google_maps/business_logic/cubits/map_cubit/map_state.dart';
import 'package:google_maps/data/repositories/map_repo.dart';
import 'package:google_maps/presentation/screens/map/map_widgets.dart';
import 'package:google_maps/shared/widgets/snackbar.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';


class MapPage extends StatelessWidget {
  const MapPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MapCubit, MapState>(
      listener: (context , state){
        if (state is SuccessPlaceDetailsState && MapCubit.get(context).placeDetailsModel?.status == 'OK') {

          searchController.clear();

          MapCubit.get(context).getDirectionMethod(
              origin: '${position!.latitude}, ${position!.longitude}' ,
              destination:  '${(MapCubit.get(context).placeDetailsModel?.result?.geometry?.location?.lat)!}, ${(MapCubit.get(context).placeDetailsModel?.result?.geometry?.location?.lng)!}' );

            goToSelectedLocation(context);

        }

        else if (state is ErrorPlaceDetailsState || MapCubit.get(context).placeDetailsModel?.status == 'INVALID_REQUEST') {
          snackBar(text: 'Try Again!', context: context);
        }

      },
      builder: (context , state){
        return mainWidgetForMap(context , state );
      },
    );




  }
}
