import 'package:flutter/material.dart';

import '../../../../utils/size/size_const.dart';
import '../../../landing/screen/landing.dart';

class LoginScreen extends StatelessWidget {
  static const routeName = '/login';
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
          automaticallyImplyLeading: false),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18.0),
          child: Column(
            children: [
              SizeConst.addVerticalSpace(context, 0.05),
              Text.rich(
                  textAlign: TextAlign.center,
                  TextSpan(
                      text: 'Whatsapp will need to verify your phone number',
                      style: customTextStyle(context),
                      children: [
                        TextSpan(
                            text: 'What is my number?',
                            style: Theme.of(context)
                                .textTheme
                                .titleLarge!
                                .copyWith(
                                  color: Colors.blue,
                                  fontSize: 16,
                                )),
                      ])),
              SizeConst.addVerticalSpace(context, 0.04),
              TextButton(
                onPressed: () {},
                style: TextButton.styleFrom(
                  foregroundColor: Colors.blue,
                ),
                child: const Text('Pick country'),
              ),
              Row(
                children: [
                  Text(
                    '+234',
                    style: customTextStyle(context),
                  ),
                  SizeConst.addHorizontalSpace(context, 0.05),
                  SizedBox(
                    width: SizeConst.customWidth(context, 0.7),
                    child: TextFormField(
                      decoration: InputDecoration(
                          hintText: 'phone number',
                          hintStyle: Theme.of(context)
                              .textTheme
                              .titleLarge!
                              .copyWith(color: Colors.grey)),
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

  customTextStyle(BuildContext _) {
    return Theme.of(_).textTheme.titleLarge!.copyWith(
          fontSize: 16,
        );
  }
}
