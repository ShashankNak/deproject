import 'package:flutter/material.dart';
import 'package:flutter_osm_plugin/flutter_osm_plugin.dart';
import 'package:get/get.dart';
import 'package:pantry_plus/screens/pages/home/dining/dining_appbar.dart';

import '../../../../controller/home/dining/dining_controller.dart';

class DiningScreen extends StatelessWidget {
  const DiningScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(DiningController());
    return GetBuilder(
        init: controller,
        builder: (context) {
          return Column(
            children: <Widget>[
              const DiningAppbar(),
              //rest of the body
              Expanded(
                  child: GestureDetector(
                child: OSMFlutter(
                  controller: controller.hCont.mapCont.value,
                  osmOption: OSMOption(
                    userTrackingOption: const UserTrackingOption(
                      enableTracking: true,
                      unFollowUser: false,
                    ),
                    zoomOption: const ZoomOption(
                      initZoom: 18,
                      minZoomLevel: 3,
                      maxZoomLevel: 19,
                      stepZoom: 1.0,
                    ),
                    userLocationMarker: UserLocationMaker(
                      personMarker: MarkerIcon(
                        icon: Icon(
                          Icons.location_history_rounded,
                          color: Colors.red,
                          size: Get.size.shortestSide / 5,
                        ),
                      ),
                      directionArrowMarker: const MarkerIcon(
                        icon: Icon(
                          Icons.double_arrow,
                          size: 48,
                        ),
                      ),
                    ),
                    roadConfiguration: const RoadOption(
                      roadColor: Colors.yellowAccent,
                    ),
                    showZoomController: true,
                    enableRotationByGesture: true,
                  ),
                ),
              ))
            ],
          );
        });
  }
}
