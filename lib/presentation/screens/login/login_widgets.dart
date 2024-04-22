import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps/business_logic/cubits/auth_cubit/auth_cubit.dart';
import 'package:google_maps/business_logic/cubits/auth_cubit/auth_state.dart';
import 'package:google_maps/shared/consts/colors.dart';
import 'package:google_maps/shared/consts/strings.dart';
import 'package:google_maps/shared/widgets/button.dart';
import 'package:google_maps/shared/widgets/snackbar.dart';
import 'package:google_maps/shared/widgets/text_form_field.dart';


var phoneController = TextEditingController();
var logInInFormKey = GlobalKey<FormState>();


Widget mainWidgetForLogin ({context}) => Scaffold(
  body: SafeArea(
    child: SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Padding(
        padding: const EdgeInsetsDirectional.only(top: 80 , end: 20, start: 20, bottom: 80),
        child: Form(
          key: logInInFormKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              Text('What\'s your phone number ?', style: Theme.of(context).textTheme.headlineSmall!.copyWith(fontWeight: FontWeight.w900),),

              const SizedBox(height: 30,),

              Text('Please enter your phone number to verify your account', style: Theme.of(context).textTheme.titleMedium!.copyWith(fontWeight: FontWeight.w500)),

              const SizedBox(height: 80,),

              Row(
                children: [

                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 13),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey[350]!),
                      borderRadius: const BorderRadius.all(Radius.circular(6)),
                    ),
                    child: Text(
                        '${generateCountryFlag()} +2', style: Theme.of(context).textTheme.titleMedium!.copyWith(letterSpacing: 2.0)

                    ),
                  ),

                  const SizedBox(width: 30,),

                  Expanded(
                      child: defaultTextFormField(
                          controller: phoneController,
                          inputType: TextInputType.number,
                          validator: (value){
                            if(value!.isEmpty){

                              return 'Please enter your phone number!' ;
                            }
                            else if(value.length < 11){

                              return 'Too short for a phone number!' ;

                            }

                            else if (!RegExp(r'^[0-9]+$').hasMatch(value)) {

                              return 'Please enter digits only!';
                            }

                          },
                          context: context)
                  ),



                ],),

              const SizedBox(height: 80,),

              BlocConsumer<AuthCubit , AuthState>(
                  listener: (context , state){
                    if(state is VerificationFailedState){
                      snackBar(text: 'Phone number is incorrect, Try Again', context: context);
                    }

                    if(state is CodeSentState){
                    Navigator.of(context).pushNamed(otpPage);
                    }
                  },
                  builder: (context , state){
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [

                        ConditionalBuilder(
                          condition: state is LoadingPhoneAuthState ,
                          builder: (context)=> const CircularProgressIndicator(color: Colors.black,),
                          fallback: (context)=>  customButton(
                              text: 'Next',
                              width: MediaQuery.of(context).size.width/3,
                              color: MyColors.primaryColor,
                              onPressed: (){

                                if(logInInFormKey.currentState!.validate()){

                                  AuthCubit.get(context).phoneAuthMethod(phone: phoneController.text);

                                }


                              }),),

                      ],);

                  }

              )



            ],),
        ),
      ),
    ),
  ),
);


String generateCountryFlag() {
  String countryCode = 'eg';

  String flag = countryCode.toUpperCase().replaceAllMapped(RegExp(r'[A-Z]'),
          (match) => String.fromCharCode(match.group(0)!.codeUnitAt(0) + 127397));

  return flag;
}