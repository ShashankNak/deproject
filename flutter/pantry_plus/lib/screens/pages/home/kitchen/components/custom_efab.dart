import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:get/get.dart';
import 'package:pantry_plus/controller/home/kitchen/kitchen_controller.dart';
import 'package:pantry_plus/screens/pages/home/kitchen/barcode_scanning.dart';
import '../../../../../utils/Theme/colors.dart';

class CustomEFAB extends StatelessWidget {
  const CustomEFAB({super.key});

  @override
  Widget build(BuildContext context) {
    final KitchenController controller = Get.find<KitchenController>();
    return Positioned(
        right: 10,
        bottom: 20,
        child: SpeedDial(
          animatedIcon: AnimatedIcons.menu_close,
          backgroundColor: CUSTOM_COLOR2,
          activeBackgroundColor: CUSTOM_COLOR1,
          overlayOpacity: 0.2,
          children: [
            SpeedDialChild(
              child: const Icon(Icons.add),
              label: 'Add Item',
              backgroundColor: CUSTOM_COLOR2,
              onTap: () {
                // handle the press
              },
            ),
            SpeedDialChild(
              child: const Icon(Icons.barcode_reader),
              label: 'Grocery List Scan',
              backgroundColor: CUSTOM_COLOR2,
              onTap: () => Get.to(() => const BarCodeScanning(),
                  transition: Transition.rightToLeftWithFade),
            ),
            SpeedDialChild(
              child: const Icon(Icons.camera),
              label: 'Scan Raw Item',
              backgroundColor: CUSTOM_COLOR2,
              onTap: controller.showBottomSheetForImage,
            ),
          ],
        ));
  }
}
