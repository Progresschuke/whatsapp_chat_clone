import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';

import '../../../../utils/size/size_const.dart';
import '../../../landing/screen/landing.dart';

class LoginScreen extends StatefulWidget {
  static const routeName = '/login';
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final phoneController = TextEditingController();
  Country? country;
  String? countryCode;

  void selectCountryCode() {
    showCountryPicker(
      context: context,
      showPhoneCode:
          true, // optional. Shows phone code before the country name.
      onSelect: (Country myCountry) {
        print('Select country: ${myCountry.phoneCode}');
        setState(() {
          country = myCountry;
        });

        countryCode = myCountry.phoneCode;
      },
    );
  }

  @override
  void dispose() {
    super.dispose();
    phoneController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: loginAppBar(context),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18.0),
          child: Column(
            children: [
              SizeConst.addVerticalSpace(context, 0.05),
              Text.rich(
                  textAlign: TextAlign.center,
                  TextSpan(
                      text: 'Whatsapp will need to verify your phone number. ',
                      style: customTextStyle(context),
                      children: [
                        TextSpan(
                            text: 'What is my number?',
                            style: Theme.of(context)
                                .textTheme
                                .titleLarge!
                                .copyWith(
                                  color: Colors.blue,
                                  fontSize: 17,
                                )),
                      ])),
              SizeConst.addVerticalSpace(context, 0.04),
              TextButton(
                onPressed: selectCountryCode,
                style: TextButton.styleFrom(
                  foregroundColor: Colors.blue,
                ),
                child: const Text(
                  'Pick country',
                  style: TextStyle(fontSize: 17),
                ),
              ),
              Row(
                children: [
                  if (country != null)
                    Text(
                      '+${country!.phoneCode}',
                      style: customTextStyle(context),
                    ),
                  SizeConst.addHorizontalSpace(context, 0.05),
                  SizedBox(
                    width: SizeConst.customWidth(context, 0.7),
                    child: TextFormField(
                      style: customTextStyle(context),
                      controller: phoneController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                          hintText: 'phone number',
                          hintStyle: Theme.of(context)
                              .textTheme
                              .titleLarge!
                              .copyWith(color: Colors.grey, fontSize: 18)),
                    ),
                  ),
                ],
              ),
              SizeConst.addVerticalSpace(context, 0.5),
              SizedBox(
                width: 90,
                child: CustomButton(onPressed: () {}, text: 'NEXT'),
              )
            ],
          ),
        ),
      ),
    );
  }

  PreferredSizeWidget loginAppBar(BuildContext context) {
    return AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.arrow_back_ios)),
        title: const CustomText(
          text: 'Enter your phone number',
          fontSize: 22,
          color: Colors.white,
        ),
        automaticallyImplyLeading: false);
  }

  customTextStyle(BuildContext _) {
    return Theme.of(_).textTheme.titleLarge!.copyWith(
          fontSize: 17,
        );
  }
}
