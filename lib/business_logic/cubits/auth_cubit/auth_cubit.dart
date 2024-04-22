import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps/business_logic/cubits/auth_cubit/auth_state.dart';
import 'package:google_maps/data/repositories/auth_repo.dart';

class AuthCubit extends Cubit<AuthState> {

 final AuthRepo authRepo ;

  AuthCubit({required this.authRepo}) : super(AuthInitialState());

  static AuthCubit get(context) => BlocProvider.of(context);




Future<void> phoneAuthMethod ({required phone}) async{

  emit(LoadingPhoneAuthState());

  authRepo.phoneAuth(
      phone: phone ,
      verificationCompleted: verificationCompleted ,
      verificationFailed: verificationFailed ,
      codeSent: codeSent ,
      codeAutoRetrievalTimeout: codeAutoRetrievalTimeout  ).then((value) {

    emit(SuccessPhoneAuthState());

  }).catchError((value) {

    emit(ErrorPhoneAuthState());

  });
}








Future<void> verificationCompleted (PhoneAuthCredential credential) async {

authRepo.verificationCompleted(credential);

 emit(VerificationCompletedState());

}


  Future<void> verificationFailed (FirebaseAuthException error) async{

  authRepo.verificationFailed(error);

  emit(VerificationFailedState());

  }



  Future<void> codeSent (String verificationId, int? resendToken) async{


    authRepo.codeSent(verificationId, resendToken);

  emit(CodeSentState());

  }


  Future<void> submitCode ({required smsCode}) async{

  authRepo.submitCode(smsCode: smsCode).then((value) {

    emit(SuccessCodeSubmittedState());

  }).catchError((onError){

    emit(ErrorCodeSubmittedState());


  });



  }


  void codeAutoRetrievalTimeout(String verificationId) {

  authRepo.codeAutoRetrievalTimeout(verificationId);

    emit(TimeOutState());
  }





  Future<void> logIn({required credential}) async {

  emit(LoadingLoginState());

      authRepo.logIn(credential: credential).then((value) {

      emit(SuccessLoginState());

    }).catchError((onError){

      emit(ErrorLoginState());

    });
  }


  Future<void> logOut() async {

  authRepo.logOut();



  emit(LogOutState());
  }



}
