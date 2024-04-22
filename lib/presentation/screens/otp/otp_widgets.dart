import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps/business_logic/cubits/auth_cubit/auth_cubit.dart';
import 'package:google_maps/business_logic/cubits/auth_cubit/auth_state.dart';
import 'package:google_maps/shared/consts/colors.dart';
import 'package:google_maps/shared/consts/strings.dart';
import 'package:google_maps/shared/widgets/snackbar.dart';
import 'package:pin_code_fields/pin_code_fields.dart';



Widget mainWidgetForOtp (context) => Scaffold(
  backgroundColor: Colors.white,
  body: SafeArea(
    child: SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Padding(
        padding: const EdgeInsetsDirectional.only(top: 50 , end: 20, start: 20, bottom: 80),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            Text('Verify your phone number', style: Theme.of(context).textTheme.headlineSmall!.copyWith(fontWeight: FontWeight.w900),),

            const SizedBox(height: 30,),

            Text('Enter your 6 digit code numbers', style: Theme.of(context).textTheme.titleMedium!.copyWith(fontWeight: FontWeight.w500)),

            const SizedBox(height: 80,),

            buildPinCodeFields(context),

            const SizedBox(height: 80,),


            BlocListener<AuthCubit, AuthState>(
              listener: (context , state){
                if(state is ErrorCodeSubmittedState){
                  snackBar(text: 'The code you entered is incorrect, Try Again', context: context);
                }

                if(state is SuccessCodeSubmittedState){
                  Navigator.of(context).pushReplacementNamed(mapPage);
                }
              },
              child: Container(),
            ),




          ],),
      ),
    ),
  ),
);

Widget buildPinCodeFields(context) {
  return PinCodeTextField(
    appContext: context,
    autoFocus: true,
    cursorColor: Colors.black,
    keyboardType: TextInputType.number,
    length: 6,
    obscureText: false,
    animationType: AnimationType.scale,
    pinTheme: PinTheme(
      shape: PinCodeFieldShape.box,
      borderRadius: BorderRadius.circular(5),
      fieldHeight: 50,
      fieldWidth: 40,
      borderWidth: 1,
      activeColor: MyColors.primaryColor,
      inactiveColor: Colors.black,
      inactiveFillColor: Colors.white,
      activeFillColor: Colors.white,
      selectedColor: Colors.lightBlueAccent,
      selectedFillColor: Colors.white,
    ),
    animationDuration: const Duration(milliseconds: 300),
    backgroundColor: Colors.white,
    enableActiveFill: true,
    onCompleted: (submittedCode) {
      AuthCubit.get(context).submitCode(smsCode: submittedCode);
    },
    onChanged: (value) {
      print(value);
    },
  );
}