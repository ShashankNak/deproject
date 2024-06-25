import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../controller/home/planner/meal_planner_controller.dart';

class PlannerAppbar extends StatelessWidget {
  const PlannerAppbar({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<MealPlannerController>();
    return GetBuilder(
        init: controller,
        builder: (context) {
          return AppBar(
            backgroundColor: Get.theme.colorScheme.primary,
            title: const Text('Planner'),
            actions: <Widget>[
              IconButton(
                icon: Icon(controller.isCalender.value
                    ? Icons.calendar_view_month
                    : Icons.calendar_month),
                tooltip: 'Calender View',
                onPressed: () => controller.toggleCalender(),
              ),
              IconButton(
                icon: const Icon(Icons.refresh),
                tooltip: 'Refresh Date',
                onPressed: () {
                  controller.date.value = DateTime.now();
                  controller.hCont.mealPlanDate.value = controller.date.value;
                  controller.update();
                },
              ),
            ],
          );
        });
  }
}
