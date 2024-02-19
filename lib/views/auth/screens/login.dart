import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:whatsapp_clone/views/auth/controller/auth_controller.dart';

import '../../../utils/size/size_const.dart';
import '../../../utils/utils.dart';
import '../../landing/screen/landing.dart';

class LoginScreen extends StatelessWidget {
  static const routeName = '/login';
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: loginAppBar(context), body: const VerifyPhoneForm());
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
}

class VerifyPhoneForm extends ConsumerStatefulWidget {
  const VerifyPhoneForm({super.key});

  @override
  ConsumerState<VerifyPhoneForm> createState() => _VerifyPhoneFormState();
}

class _VerifyPhoneFormState extends ConsumerState<VerifyPhoneForm> {
  final phoneController = TextEditingController();
  Country? country;
  String? countryCode;

  void selectCountryCode() {
    showCountryPicker(
      context: context,
      showPhoneCode: true,
      onSelect: (Country myCountry) {
        setState(() {
          country = myCountry;
        });

        countryCode = myCountry.phoneCode;
      },
    );
  }

  void sendPhoneNumber() {
    final phoneNumber = phoneController.text.trim();
    if (country == null && phoneNumber.isEmpty) {
      //show snackbar error message
      showSnackBar(context: context, error: 'Enter a valid phone number.');
      return;
    }
    if (country != null && phoneNumber.isNotEmpty) {
      ref
          .read(authControllerProvider)
          .signInWithPhoneNumber(context, '+${country!.phoneCode}$phoneNumber');
    }
  }

  @override
  void dispose() {
    super.dispose();
    phoneController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
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
                          style:
                              Theme.of(context).textTheme.titleLarge!.copyWith(
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
              child: CustomButton(onPressed: sendPhoneNumber, text: 'NEXT'),
            )
          ],
        ),
      ),
    );
  }

  customTextStyle(BuildContext _) {
    return Theme.of(_).textTheme.titleLarge!.copyWith(
          fontSize: 17,
        );
  }
}
