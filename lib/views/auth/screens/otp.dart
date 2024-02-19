import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:whatsapp_clone/views/auth/controller/auth_controller.dart';

import '../../../utils/size/size_const.dart';
import '../../landing/screen/landing.dart';

class OtpScreen extends StatelessWidget {
  static const routeName = '/otp';
  const OtpScreen({super.key, required this.verificationId});

  final String? verificationId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: otpAppBar(context),
        body: OtpForm(
          verificationId: verificationId,
        ));
  }

  PreferredSizeWidget otpAppBar(BuildContext context) {
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

class OtpForm extends ConsumerStatefulWidget {
  const OtpForm({
    super.key,
    required this.verificationId,
  });

  final String? verificationId;

  @override
  ConsumerState<OtpForm> createState() => _OtpFormState();
}

class _OtpFormState extends ConsumerState<OtpForm> {
  TextEditingController otpController = TextEditingController();

  verifyOtp(String userOtp) {
    ref.read(authControllerProvider).verifyOtp(
        context: context,
        verificationId: widget.verificationId,
        userOtp: userOtp);
  }

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: Column(
        children: [
          SizeConst.addVerticalSpace(context, 0.05),
          Text(
            'We have sent an SMS with a code.',
            style: Theme.of(context)
                .textTheme
                .titleLarge!
                .copyWith(fontSize: 18, fontWeight: FontWeight.w400),
          ),
          SizedBox(
            width: SizeConst.customWidth(context, 0.5),
            child: TextFormField(
              textAlign: TextAlign.center,
              style: customTextStyle(),
              controller: otpController,
              keyboardType: TextInputType.number,
              onChanged: (value) {
                if (widget.verificationId != null && value.length == 6) {
                  final userOtp = value;
                  verifyOtp(userOtp);
                } else {
                  return;
                }
              },
              decoration: InputDecoration(
                  hintText: '- - - - - -',
                  hintStyle: Theme.of(context)
                      .textTheme
                      .titleLarge!
                      .copyWith(color: Colors.grey, fontSize: 40)),
            ),
          )
        ],
      ),
    );
  }

  customTextStyle() {
    return Theme.of(context).textTheme.titleLarge!.copyWith(
          fontSize: 25,
          fontWeight: FontWeight.w400,
        );
  }
}
