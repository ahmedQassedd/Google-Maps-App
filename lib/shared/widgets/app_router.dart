import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps/business_logic/cubits/auth_cubit/auth_cubit.dart';
import 'package:google_maps/business_logic/cubits/map_cubit/map_cubit.dart';
import 'package:google_maps/data/di/injection.dart';
import 'package:google_maps/presentation/screens/login/login_page.dart';
import 'package:google_maps/presentation/screens/map/map_page.dart';
import 'package:google_maps/presentation/screens/otp/otp_page.dart';
import 'package:google_maps/shared/consts/strings.dart';



class AppRouter {

  static final AuthCubit authCubit = sl<AuthCubit>();


static Route? onGenerateRoute(RouteSettings settings){

  switch(settings.name){

    case loginPage:
      return MaterialPageRoute(
          builder: (_) => BlocProvider<AuthCubit>.value(
            value: authCubit ,
            child: const LoginPage(),

          )

      );

    case otpPage :
      return MaterialPageRoute(
          builder: (_) => BlocProvider<AuthCubit>.value(
            value: authCubit,
            child: const OtpPage(),
          )

      );

    case mapPage:
      return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => sl<MapCubit>()..getCurrentLocation(),
            child: const MapPage(),

          )

      );

    default:

      return null;

  }

}


}


