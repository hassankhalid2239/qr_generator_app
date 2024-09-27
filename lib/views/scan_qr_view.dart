import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';


import '../controller/state_controller.dart';
import '../utils/utils.dart';
import '../widgets/custom_button.dart';
class ScanQrView extends StatelessWidget {
  final _stateController = Get.put(StateController());

  ScanQrView({super.key,});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: const BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                // stops: [0.50,0.50],
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
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              child: Text(
                'Scanned Result',
                textAlign: TextAlign.start,
                style: GoogleFonts.nunito(
                  fontSize: 24,
                ),
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            Padding(padding: const EdgeInsets.symmetric(horizontal: 25),child: Container(
             height: 200,
             padding: const EdgeInsets.all(15),
             decoration: BoxDecoration(
                 color: Colors.white,
                 borderRadius: BorderRadius.circular(8)
             ),
             child: SingleChildScrollView(
               child: Text(
                 _stateController.scannedResult.value,
                 style: GoogleFonts.nunito(
                 fontSize: 16,
               ),),
             ),
           ),),
            const SizedBox(height: 150,),
            CustomButton(title: 'Copy Text', onTap: (){
              Clipboard.setData(ClipboardData(text: _stateController.scannedResult.value));
              Utils().showToastMessage('Text copied');
            }, icon: Icons.copy)
          ],
        ),
      ),
    );
  }
}
