import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pantry_plus/api/firebase/firebase_database.dart';
import 'package:pantry_plus/screens/pages/home/planner/planner_appbar.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../../../controller/home/planner/meal_planner_controller.dart';
import '../../../../data/model/meal_model.dart';
import 'components/meal_grid.dart';

class PlannerScreen extends StatefulWidget {
  const PlannerScreen({super.key});

  @override
  State<PlannerScreen> createState() => _PlannerScreenState();
}

class _PlannerScreenState extends State<PlannerScreen> {
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(MealPlannerController());
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: GetBuilder(
          init: controller,
          builder: (context) {
            return Column(
              children: [
                const PlannerAppbar(),
                Expanded(
                  child: Stack(
                    children: [
                      SingleChildScrollView(
                        child: Column(
                          children: [
                            if (!controller.isCalender.value)
                              Container(
                                color: Get.theme.colorScheme.primaryContainer
                                    .withOpacity(0.4),
                                width: Get.size.width,
                                height: Get.size.height / 10,
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    IconButton(
                                      icon: const Icon(Icons.arrow_back_ios),
                                      onPressed: () =>
                                          controller.previousDate(),
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        controller.isCalender(true);
                                        controller.update();
                                      },
                                      child: Text(
                                        controller.showDate(),
                                      ),
                                    ),
                                    IconButton(
                                        icon:
                                            const Icon(Icons.arrow_forward_ios),
                                        onPressed: () => controller.nextDate()),
                                  ],
                                ),
                              ),
                            if (controller.isCalender.value)
                              SizedBox(
                                  height: Get.size.height / 1.5,
                                  child: TableCalendar(
                                      onHeaderTapped: (focusedDay) =>
                                          controller.toggleCalender(),
                                      onDaySelected: (selectedDay, focusedDay) {
                                        controller.date(selectedDay);
                                        controller.update();
                                        controller.toggleCalender();
                                      },
                                      focusedDay: controller.date.value,
                                      firstDay: DateTime(
                                        DateTime.now().year,
                                        DateTime.now().month,
                                        DateTime.now().day - 10,
                                      ),
                                      lastDay: DateTime.now()
                                          .add(const Duration(days: 365)))),
                            if (!controller.isCalender.value)
                              StreamBuilder(
                                  stream: FirebaseDatabase.getMeals(controller
                                      .date.value.millisecondsSinceEpoch
                                      .toString()),
                                  builder: (context, snapshot) {
                                    if (snapshot.connectionState ==
                                        ConnectionState.waiting) {
                                      return const Center(
                                        child: CircularProgressIndicator(),
                                      );
                                    }
                                    if (snapshot.hasError ||
                                        snapshot.data == null) {
                                      return const Center(
                                        child: Text("Error"),
                                      );
                                    }
                                    final meals = snapshot.data!.docs
                                        .map((e) => MealPlanningModel.fromJson(
                                            e.data()))
                                        .toList();

                                    controller.mealList.value = meals;

                                    //update databasemeals index list
                                    controller.databaseMeals.value =
                                        List.generate(meals.length, (index) {
                                      return index;
                                    });

                                    controller.selectedTime.value =
                                        List.generate(meals.length, (index) {
                                      final date = TimeOfDay.fromDateTime(
                                          DateTime.fromMillisecondsSinceEpoch(
                                              int.parse(controller
                                                      .mealList[index].day) +
                                                  int.parse(
                                                      meals[index].time)));
                                      log("Time:${date.toString()}");
                                      return date;
                                    });
                                    return SizedBox(
                                      height: Get.size.height / 1.5,
                                      child: Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal:
                                                Get.size.shortestSide / 30),
                                        child: Stack(
                                          children: [
                                            controller.mealList.isEmpty
                                                ? Center(
                                                    child: Text(
                                                      "No meals planned for the day",
                                                      style: TextStyle(
                                                        fontSize: Get.size
                                                                .shortestSide /
                                                            20,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                    ),
                                                  )
                                                : GridView.builder(
                                                    itemCount: controller
                                                        .mealList.length,
                                                    gridDelegate:
                                                        SliverGridDelegateWithMaxCrossAxisExtent(
                                                      maxCrossAxisExtent: Get
                                                              .size
                                                              .shortestSide /
                                                          2,
                                                      mainAxisExtent:
                                                          Get.size.longestSide /
                                                              3.5,
                                                      childAspectRatio: 3 / 2,
                                                      crossAxisSpacing: Get.size
                                                              .shortestSide /
                                                          20,
                                                      mainAxisSpacing:
                                                          Get.size.longestSide /
                                                              80,
                                                    ),
                                                    itemBuilder:
                                                        (context, index) =>
                                                            MealGrid(
                                                      title: controller
                                                          .mealList[index]
                                                          .title,
                                                      index: index,
                                                    ),
                                                    shrinkWrap: true,
                                                  ),
                                            //a rounded button that will add a new recipe
                                            Positioned(
                                              bottom: 0,
                                              right: Get.size.shortestSide / 40,
                                              child: FloatingActionButton(
                                                onPressed: controller.addMeal,
                                                child: const Icon(Icons.add),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                                  }),
                          ],
                        ),
                      ),
                      if (controller.isLoading.value)
                        if (controller.isLoading.value)
                          const Center(
                            child: CircularProgressIndicator(),
                          ),
                    ],
                  ),
                ),
              ],
            );
          }),
    );
  }
}
