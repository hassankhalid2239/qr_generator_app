import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:get/get.dart';
import 'package:google_ml_kit/google_ml_kit.dart';
import 'package:image_picker/image_picker.dart';

import '../views/scan_qr_view.dart';

class StateController extends GetxController {
  RxString scannedResult = ''.obs;

  Rx<XFile?> pickImage = Rx<XFile?>(null);
  Rx<TextEditingController> txtController = TextEditingController().obs;

  RxBool scanning = false.obs;

  final imagePicker = ImagePicker();

  // RxString imageText = ''.obs;

  getImage(ImageSource ourSource) async {
    XFile? result = await imagePicker.pickImage(source: ourSource);
    if (result != null) {
      pickImage.value = result;

      performTextRecognition();
    }
  }

  performTextRecognition() async {
    scanning.value = true;

    try {
      final inputImage = InputImage.fromFilePath(pickImage.value!.path);

      final textRecognizer = GoogleMlKit.vision.textRecognizer();

      final recognizedText = await textRecognizer.processImage(inputImage);

      txtController.value.text = recognizedText.text;
      // imageText.value= recognizedText.text;
      scanning.value = false;
    } catch (e) {
      Get.snackbar('Error', e.toString());
    }
  }

  Future<void> startScan() async {
    var result = '';
    try {
      result = await FlutterBarcodeScanner.scanBarcode(
        '#FFFFFF',
        'Cancel',
        true,
        ScanMode.QR,
      );
    } on PlatformException catch (e) {
      result = 'Failed to get platform version';
      Get.snackbar('Error', e.toString());
    } catch (error) {
      result = 'Error occurred';
      Get.snackbar('Error', error.toString());
    }

    // // Ensure the result is not null or "-1" (FlutterBarcodeScanner returns "-1" when cancelled)
    // if (!mounted) return;
    scannedResult.value = result != '-1' ? result : 'Scan Cancelled';
    if (scannedResult.value != 'Scan Cancelled') {
      Get.to(ScanQrView());
    }
  }
}
