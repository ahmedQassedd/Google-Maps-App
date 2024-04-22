import 'package:firebase_auth/firebase_auth.dart';

abstract class AuthRepo {

  Future<void> phoneAuth({required phone ,  verificationCompleted  ,  verificationFailed , codeSent , codeAutoRetrievalTimeout});

  Future<void> verificationCompleted (PhoneAuthCredential credential);

  Future<void> verificationFailed (FirebaseAuthException error) ;

  Future<void> codeSent (String verificationId, int? resendToken) ;

  Future<void> submitCode ({required smsCode}) ;

  Future<void> codeAutoRetrievalTimeout(String verificationId) ;

  Future<void> logIn({required credential}) ;

  Future<void> logOut() ;

}







class AuthRepoImpl extends AuthRepo {

  FirebaseAuth auth = FirebaseAuth.instance;
  late String verificationId ;

  @override
  Future<void> phoneAuth({required phone ,  verificationCompleted  ,  verificationFailed , codeSent , codeAutoRetrievalTimeout}) async {

    await auth.verifyPhoneNumber(
      phoneNumber: '+2$phone',
      verificationCompleted: verificationCompleted ,
      verificationFailed: verificationFailed,
      codeSent: codeSent,
      codeAutoRetrievalTimeout: codeAutoRetrievalTimeout,
    );
  }


  @override
  Future<void> verificationCompleted (PhoneAuthCredential credential) async {

    print(verificationCompleted);

    await logIn(credential: credential);

  }



  @override
  Future<void> verificationFailed(FirebaseAuthException error) async {

    print(error.toString());
  }



  @override
  Future<void> codeSent(String verificationId, int? resendToken) async {

    print('codeSent');

    this.verificationId = verificationId ;
  }




  @override
  Future<void> submitCode ({required smsCode}) async{

    print('submitCode');

    PhoneAuthCredential credential = PhoneAuthProvider.credential( verificationId: verificationId, smsCode: smsCode);

    await logIn(credential: credential);
  }






  @override
  Future<void> codeAutoRetrievalTimeout(String verificationId) async {
    print('codeAutoRetrievalTimeout');

  }


  @override
  Future<void> logIn({required credential}) async {

    await auth.signInWithCredential(credential) ;
  }


  @override
  Future<void> logOut() async {
    await FirebaseAuth.instance.signOut();
  }




}