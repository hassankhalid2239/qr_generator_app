// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:qr_flutter/qr_flutter.dart';

import '../controller/state_controller.dart';
import '../widgets/custom_button.dart';

class GenerateQrView extends StatefulWidget {
  const GenerateQrView({super.key});

  @override
  State<GenerateQrView> createState() => _GenerateQrViewState();
}

class _GenerateQrViewState extends State<GenerateQrView> {
  final _stateController = Get.put(StateController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xffB3D9E4),
        foregroundColor: Colors.black,
        title: Text(
          'Generate QR Code',
          style: GoogleFonts.nunito(),
        ),
        elevation: 0,
        scrolledUnderElevation: 0,
      ),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: const BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
              Color(0xffB3D9E4),
              Color(0xffFFFFFF),
            ])),
        child: ListView(
          shrinkWrap: true,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: 300,
                  child: TextFormField(
                    maxLines: 8,
                    minLines: 1,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter Text!';
                      } else {
                        return null;
                      }
                    },
                    style: GoogleFonts.montserrat(
                        color: Theme.of(context).colorScheme.scrim),
                    controller: _stateController.txtController.value,
                    cursorColor: Theme.of(context).colorScheme.scrim,
                    decoration: InputDecoration(
                      hintText: 'Enter Text',
                      filled: true,
                      fillColor: Theme.of(context).colorScheme.surfaceBright,
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide:
                              const BorderSide(color: Color(0xff2879F1))),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide:
                              const BorderSide(color: Color(0xff2879F1))),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                SizedBox(
                  height: 55,
                  width: 55,
                  child: ElevatedButton(
                      style: ButtonStyle(
                          padding:
                              const WidgetStatePropertyAll(EdgeInsets.zero),
                          shape: WidgetStatePropertyAll(RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8))),
                          side: const WidgetStatePropertyAll(
                              BorderSide(color: Color(0xff2879F1)))),
                      onPressed: () {
                        showModalBottomSheet(
                            backgroundColor: const Color(0xff2879F1),
                            context: context,
                            builder: (BuildContext context) {
                              return Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  ElevatedButton(
                                    onPressed: () {
                                      _stateController
                                          .getImage(ImageSource.camera);
                                      Navigator.pop(context);
                                    },
                                    style: ButtonStyle(
                                      backgroundColor: MaterialStatePropertyAll(
                                          Theme.of(context)
                                              .colorScheme
                                              .background),
                                      padding: const MaterialStatePropertyAll(
                                          EdgeInsets.zero),
                                      shape: const MaterialStatePropertyAll(
                                          BeveledRectangleBorder(
                                              borderRadius: BorderRadius.zero)),
                                      splashFactory: InkSparkle.splashFactory,
                                      overlayColor:
                                          const MaterialStatePropertyAll(
                                              Color(0x4d5800ff)),
                                    ),
                                    child: ListTile(
                                      leading: Icon(
                                        Icons.camera_alt,
                                        color: Theme.of(context)
                                            .colorScheme
                                            .outline,
                                      ),
                                      title: Text(
                                        'Take profile picture',
                                        style: GoogleFonts.nunito(
                                            fontSize: 16,
                                            color: Colors.black,
                                            fontWeight: FontWeight.w600),
                                      ),
                                    ),
                                  ),
                                  ElevatedButton(
                                    onPressed: () {
                                      _stateController
                                          .getImage(ImageSource.gallery);
                                      // txtController.text=_stateController.imageText.value;
                                      Navigator.pop(context);
                                    },
                                    style: ButtonStyle(
                                      backgroundColor: MaterialStatePropertyAll(
                                          Theme.of(context)
                                              .colorScheme
                                              .background),
                                      padding: const MaterialStatePropertyAll(
                                          EdgeInsets.zero),
                                      shape: const MaterialStatePropertyAll(
                                          BeveledRectangleBorder(
                                              borderRadius: BorderRadius.zero)),
                                      // splashFactory: InkSplash.splashFactory,
                                      splashFactory: InkSparkle.splashFactory,
                                      overlayColor:
                                          const MaterialStatePropertyAll(
                                              Color(0x4d5800ff)),
                                    ),
                                    child: ListTile(
                                      leading: Icon(Icons.photo_library,
                                          color: Theme.of(context)
                                              .colorScheme
                                              .outline),
                                      title: Text(
                                        'Select profile picture',
                                        style: GoogleFonts.nunito(
                                            fontSize: 16,
                                            color: Colors.black,
                                            fontWeight: FontWeight.w600),
                                      ),
                                    ),
                                  ),
                                ],
                              );
                            });
                      },
                      child: const Icon(Icons.document_scanner_outlined)),
                )
              ],
            ),
            const SizedBox(
              height: 24,
            ),
            CustomButton(
              title: 'Generate Now',
              onTap: () {
                setState(() {});
              },
              icon: Icons.qr_code_outlined,
            ),
            const SizedBox(
              height: 15,
            ),
            _stateController.txtController.value.text.isEmpty
                ? const SizedBox()
                : Align(
                    alignment: Alignment.center,
                    child: QrImageView(
                      data: _stateController.txtController.value.text,
                      version: QrVersions.auto,
                      size: 300,
                      embeddedImage:
                          const AssetImage('lib/res/images/dash.png'),
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
