import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pantry_plus/api/firebase/firebase_database.dart';
import 'package:pantry_plus/controller/home/home_controller.dart';
import 'package:pantry_plus/data/model/meal_model.dart';

import '../../../data/model/recipe_model.dart';

String getMonth(int month) {
  switch (month) {
    case 1:
      return 'January';
    case 2:
      return 'February';
    case 3:
      return 'March';
    case 4:
      return 'April';
    case 5:
      return 'May';
    case 6:
      return 'June';
    case 7:
      return 'July';
    case 8:
      return 'August';
    case 9:
      return 'September';
    case 10:
      return 'October';
    case 11:
      return 'November';
    case 12:
      return 'December';
    default:
      return "";
  }
}

String getWeek(int week) {
  switch (week) {
    case 1:
      return 'Monday';
    case 2:
      return 'Tuesday';
    case 3:
      return 'Wednesday';
    case 4:
      return 'Thursday';
    case 5:
      return 'Friday';
    case 6:
      return 'Saturday';
    case 7:
      return 'Sunday';
    default:
      return "";
  }
}

class MealPlannerController extends GetxController {
  var isLoading = false.obs;
  final hCont = Get.find<HomeController>();
  late Rx<DateTime> date;
  var isCalender = false.obs;
  var recipeList = <Recipe>[].obs;
  var mealList = <MealPlanningModel>[].obs;
  var selectedTime = <TimeOfDay>[].obs;
  var databaseMeals = <int>[].obs;

  @override
  void onInit() {
    super.onInit();
    recipeList = hCont.recipeList;
    date = DateTime(
      hCont.mealPlanDate.value.year,
      hCont.mealPlanDate.value.month,
      hCont.mealPlanDate.value.day,
      0,
      0,
      0,
      0,
      0,
    ).obs;

    date.value = hCont.mealPlanDate.value;
    update();
  }

  Future<void> selectTime(int index) async {
    final TimeOfDay? picked = await showTimePicker(
      context: Get.context!,
      initialTime: selectedTime[index],
      builder: (BuildContext context, Widget? child) {
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: false),
          child: child!,
        );
      },
    );
    if (picked != null && picked != selectedTime[index]) {
      selectedTime[index] = picked;
      update();
    }
    final time = (selectedTime[index].hour.hours.inMilliseconds +
            selectedTime[index].minute.minutes.inMilliseconds)
        .toString();

    log("New Time: $time");
    storeMealToDatabase(time, index);
  }

  void toggleCalender() {
    isCalender.value = !isCalender.value;
    update();
  }

  void previousDate() {
    date.value = date.value.subtract(const Duration(days: 1));
    hCont.mealPlanDate.value = date.value;
    log(date.value.hour.toString());
    update();
  }

  void nextDate() {
    date.value = date.value.add(const Duration(days: 1));
    hCont.mealPlanDate.value = date.value;
    log(date.value.millisecondsSinceEpoch.toString());
    update();
  }

  String showDate() {
    //show da
    return '${getWeek(date.value.weekday)}, ${date.value.day}${date.value.day == 1 ? "st" : date.value.day == 2 ? "nd" : date.value.day == 3 ? "rd" : "th"}  ${getMonth(date.value.month)} ${date.value.year}';
  }

  void addMeal() {
    //maximum 6 meals only notify user by snackbar
    if (mealList.length >= 6) {
      Get.snackbar(
        'Maximum meals reached',
        'You can only add 6 meals',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: const Color.fromARGB(71, 213, 0, 0),
        colorText: Colors.white,
        margin: const EdgeInsets.all(20),
      );
      return;
    }

    selectedTime.add(const TimeOfDay(hour: 0, minute: 0));
    final time = (selectedTime[mealList.length].hour.hours.inMilliseconds +
            selectedTime[mealList.length].minute.minutes.inMilliseconds)
        .toString();

    mealList.add(MealPlanningModel(
      id: '${FirebaseDatabase.firebaseAuth.currentUser!.uid}_${DateTime.now().millisecondsSinceEpoch.toString()}',
      title: 'Meal ${mealList.length + 1}',
      recipeId: [],
      time: time,
      day: date.value.millisecondsSinceEpoch.toString(),
    ));
    log("Date: ${date.value.millisecondsSinceEpoch.toString()}");

    updateTitle();
    storeMealToDatabase(time, mealList.length - 1);
    update();
  }

  void storeMealToDatabase(String time, int index) async {
    isLoading.value = true;
    update();

    log("Storing meal");
    mealList[index].time = time;
    selectedTime[index] = TimeOfDay.fromDateTime(
        DateTime.fromMillisecondsSinceEpoch(
            int.parse(mealList[index].day) + int.parse(time)));
    update();
    await FirebaseDatabase.storeMealDetails(mealList[index]);

    isLoading.value = false;
    update();
  }

  void deleteMeal(int index) async {
    isLoading.value = true;
    update();

    log("deleting meal");

    await FirebaseDatabase.deleteMeal(mealList[index].day, mealList[index].id);
    isLoading.value = false;
    updateTitle();
    update();
  }

  //update title based on index
  void updateTitle() {
    for (var i in databaseMeals) {
      mealList[i].title = 'Meal ${i + 1}';
      //update the database
      FirebaseDatabase.updateMealDetails(mealList[i], mealList[i].day);
    }
    update();
  }

  void deleteRecipeFromMeal(String recipeId, int index) {
    isLoading(true);
    update();

    mealList[index].recipeId.remove(recipeId);
    FirebaseDatabase.updateMealDetails(mealList[index], mealList[index].day);

    isLoading(false);
    update();
  }
}
