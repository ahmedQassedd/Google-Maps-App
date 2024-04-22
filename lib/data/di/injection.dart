import 'package:get_it/get_it.dart';
import 'package:google_maps/business_logic/cubits/auth_cubit/auth_cubit.dart';
import 'package:google_maps/business_logic/cubits/map_cubit/map_cubit.dart';
import 'package:google_maps/data/repositories/auth_repo.dart';
import 'package:google_maps/data/repositories/map_repo.dart';
import 'package:google_maps/data/web_services/remote/dio_helper.dart';

final sl = GetIt.instance;

Future<void> diInit() async {

  sl.registerFactory(() => AuthCubit(authRepo: sl()));

  sl.registerFactory(() => MapCubit(mapRepo: sl()));

  sl.registerLazySingleton<MapRepo>(() => MapRepoImpl(dioHelper: sl())   );

  sl.registerLazySingleton<DioHelper>(() => DioHelperImpl() );

  sl.registerLazySingleton<AuthRepo>(() => AuthRepoImpl() );


}
