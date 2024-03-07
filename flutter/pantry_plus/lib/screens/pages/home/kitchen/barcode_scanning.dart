import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:pantry_plus/controller/home/kitchen/kitchen_controller.dart';
import 'package:pantry_plus/screens/pages/home/kitchen/components/barcode_scanner/container_with_hole.dart';

class BarCodeScanning extends StatefulWidget {
  const BarCodeScanning({super.key});

  @override
  State<BarCodeScanning> createState() => _BarCodeScanningState();
}

class _BarCodeScanningState extends State<BarCodeScanning> {
  late MobileScannerController cameraController;
  @override
  void initState() {
    super.initState();
    cameraController = MobileScannerController(
      detectionSpeed: DetectionSpeed.noDuplicates,
      returnImage: true,
      autoStart: true,
    );
  }

  @override
  Widget build(BuildContext context) {
    final bCont = Get.find<KitchenController>();
    return Scaffold(
      body: Stack(
        children: [
          MobileScanner(
            controller: cameraController,
            overlay: const ContainerWithHole(),
            errorBuilder: (p0, p1, p2) {
              return p2 ??
                  Center(
                    child: Text(p1.errorDetails.toString()),
                  );
            },
            scanWindow: Rect.fromCenter(
                center: Offset(Get.size.width / 2, Get.size.height / 2),
                width: Get.size.width,
                height: Get.size.height / 2),
            onDetect: bCont.openBarcodeScanner,
          ),
          AppBar(
            backgroundColor: Colors.transparent,
            leading: IconButton(
              icon: const Icon(Icons.cancel, color: Colors.white),
              onPressed: () {
                Get.back();
              },
            ),
            actions: [
              IconButton(
                color: Colors.white,
                icon: ValueListenableBuilder(
                  valueListenable: cameraController.torchState,
                  builder: (context, state, child) {
                    switch (state) {
                      case TorchState.off:
                        return const Icon(Icons.flash_off, color: Colors.grey);
                      case TorchState.on:
                        return const Icon(Icons.flash_on, color: Colors.yellow);
                    }
                  },
                ),
                iconSize: 32.0,
                onPressed: () => cameraController.toggleTorch(),
              ),
              IconButton(
                color: Colors.white,
                icon: ValueListenableBuilder(
                  valueListenable: cameraController.cameraFacingState,
                  builder: (context, state, child) {
                    switch (state) {
                      case CameraFacing.front:
                        return const Icon(Icons.camera_front);
                      case CameraFacing.back:
                        return const Icon(Icons.camera_rear);
                    }
                  },
                ),
                iconSize: 32.0,
                onPressed: () => cameraController.switchCamera(),
              ),
            ],
          ),
          Positioned(
            bottom: Get.size.height / 30,
            right: Get.size.width / 30,
            child: FloatingActionButton(
                onPressed: () {},
                child: const Icon(Icons.photo_size_select_actual)),
          ),
        ],
      ),
    );
  }
}
