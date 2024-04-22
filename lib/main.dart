import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_maps/business_logic/cubits/bloc_observer/bloc_observer.dart';
import 'package:google_maps/data/di/injection.dart';
import 'package:google_maps/shared/consts/strings.dart';
import 'package:google_maps/shared/widgets/app_router.dart';


late String initialRoute;


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp() ;
  diInit();
  Bloc.observer = MyBlocObserver();


  FirebaseAuth.instance.authStateChanges().listen((user) {
    if (user == null) {
      initialRoute = loginPage;
    } else {
      initialRoute = mapPage;
    }
  });



  runApp(const MyApp());
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      onGenerateRoute: AppRouter.onGenerateRoute ,
      initialRoute: initialRoute,
    );
  }
}

