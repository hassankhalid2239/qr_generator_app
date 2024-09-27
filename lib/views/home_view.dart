import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../controller/state_controller.dart';
import '../widgets/custom_button.dart';
import 'generate_qr_view.dart';

class HomeView extends StatelessWidget {
  HomeView({super.key});

  final _stateController = Get.put(StateController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: const BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.center,
                colors: [
              Color(0xffB3D9E4),
              Color(0xffFFFFFF),
            ])),
        child: ListView(
          shrinkWrap: true,
          children: [
            const SizedBox(
              height: 46,
            ),
            const Image(image: AssetImage('lib/res/images/qrcode_icon.png')),
            Text(
              'Welcome to \nQR Code Scanner',
              textAlign: TextAlign.center,
              style: GoogleFonts.nunito(
                fontSize: 24,
              ),
            ),
            const SizedBox(
              height: 240,
            ),
            CustomButton(
              title: 'Scan Now',
              onTap: () {
                _stateController.startScan();
              },
              icon: Icons.qr_code_scanner_outlined,
            ),
            const SizedBox(
              height: 34,
            ),
            CustomButton(
              title: 'Generate Now',
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const GenerateQrView()));
              },
              icon: Icons.qr_code_outlined,
            ),
          ],
        ),
      ),
    );
  }
}
