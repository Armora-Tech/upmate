import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:upmatev2/themes/app_font.dart';
import 'package:upmatev2/utils/auth.dart';

import '../routes/route_name.dart';

class VerifyView extends StatelessWidget {
  const VerifyView({super.key});

  @override
  Widget build(BuildContext context) {
    final authControl = Auth();
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Container(
            width: Get.width,
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 40,
                ),
                Center(
                  child: SizedBox(
                      height: 200,
                      child: Image.asset(
                        "assets/images/verif.png",
                        fit: BoxFit.cover,
                      )),
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  "Verify your email",
                  style: AppFont.text23
                      .copyWith(fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 20,
                ),
                const Text(
                  "Please enter the 4 digit code sent to emaildituju@contoh.com",
                  overflow: TextOverflow.clip,
                  style: TextStyle(
                      fontWeight: FontWeight.w500, color: Colors.grey),
                ),
                const SizedBox(
                  height: 20,
                ),
                Form(
                    child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      height: 68,
                      width: 64,
                      child: TextFormField(
                        onSaved: (pin1) {},
                        onChanged: (value) {
                          if (value.length == 1) {
                            FocusScope.of(context).nextFocus();
                          }
                        },
                        keyboardType: TextInputType.number,
                        textAlign: TextAlign.center,
                        inputFormatters: [
                          LengthLimitingTextInputFormatter(1),
                          FilteringTextInputFormatter.digitsOnly
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 68,
                      width: 64,
                      child: TextFormField(
                        onSaved: (pin2) {},
                        onChanged: (value) {
                          if (value.length == 1) {
                            FocusScope.of(context).nextFocus();
                          } else {
                            FocusScope.of(context).previousFocus();
                          }
                        },
                        keyboardType: TextInputType.number,
                        textAlign: TextAlign.center,
                        inputFormatters: [
                          LengthLimitingTextInputFormatter(1),
                          FilteringTextInputFormatter.digitsOnly
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 68,
                      width: 64,
                      child: TextFormField(
                        onSaved: (pin3) {},
                        onChanged: (value) {
                          if (value.length == 1) {
                            FocusScope.of(context).nextFocus();
                          } else {
                            FocusScope.of(context).previousFocus();
                          }
                        },
                        keyboardType: TextInputType.number,
                        textAlign: TextAlign.center,
                        inputFormatters: [
                          LengthLimitingTextInputFormatter(1),
                          FilteringTextInputFormatter.digitsOnly
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 68,
                      width: 64,
                      child: TextFormField(
                        onSaved: (pin4) {},
                        onChanged: (value) {
                          if (value.isEmpty) {
                            FocusScope.of(context).previousFocus();
                          }
                        },
                        keyboardType: TextInputType.number,
                        textAlign: TextAlign.center,
                        inputFormatters: [
                          LengthLimitingTextInputFormatter(1),
                          FilteringTextInputFormatter.digitsOnly
                        ],
                      ),
                    ),
                  ],
                )),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Tidak menerima email?",
                      style: TextStyle(color: Color(0xFF505050)),
                    ),
                    const SizedBox(
                      width: 2,
                    ),
                    GestureDetector(
                        onTap: () {},
                        child: const Text(
                          "Kirim ulang email",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        )),
                  ],
                ),
                const SizedBox(
                  height: 40,
                ),
                ElevatedButton(
                    onPressed: () async {
                      // final isOK = await authControl.checkOTP("123");
                      // print("CECK: $isOK");

                      // if(authControl.checkOTP(string)){
                      //
                      // }
                      // Get.toNamed(RouteName.takeSurvey)
                    },
                    child: Center(
                      child: Text(
                        "Verify",
                        style: AppFont.text16.copyWith(
                            color: Colors.white, fontWeight: FontWeight.w500),
                      ),
                    ))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
