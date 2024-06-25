import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pantry_plus/api/firebase/firebase_database.dart';
import 'package:pantry_plus/controller/home/home_controller.dart';
import 'package:pantry_plus/data/model/meal_model.dart';
import 'package:pantry_plus/data/model/recipe_model.dart';

class RecipeController extends GetxController {
  RxList<Recipe> recipeList = <Recipe>[].obs;
  var isLoading = true.obs;
  RxList<Recipe> top5RecipesList = <Recipe>[].obs;
  var currentIndex = 0.obs;
  var isSearching = false.obs;
  var filteredList = <Recipe>[].obs;
  var searchText = ''.obs;
  var searchController = TextEditingController().obs;
  var hCont = Get.find<HomeController>();

  var selectedMealPlan = "".obs;
  var mealList = <MealPlanningModel>[].obs;
  var selectedDate = DateTime(DateTime.now().year, DateTime.now().month,
          DateTime.now().day, 0, 0, 0)
      .obs;

  @override
  void onInit() {
    fetchRecipes();
    super.onInit();
  }

  void updateMealPlan(Recipe recipe, MealPlanningModel option) async {
    isLoading(true);
    update();
    var newMeal = option.recipeId;
    if (selectedMealPlan.value == option.id) {
      selectedMealPlan.value = "";
      newMeal.remove(recipe.id);
      update();
    } else {
      final prev = selectedMealPlan.value;
      if (prev != "") {
        final prevMeal = mealList.firstWhere((element) => element.id == prev);
        prevMeal.recipeId.remove(recipe.id);
        FirebaseDatabase.updateMealDetails(
            MealPlanningModel(
                id: prevMeal.id,
                recipeId: prevMeal.recipeId,
                time: prevMeal.time,
                day: prevMeal.day,
                title: prevMeal.title),
            prevMeal.day);
      }
      newMeal.add(recipe.id);
      selectedMealPlan(option.id);
      update();
    }
    FirebaseDatabase.updateMealDetails(
        MealPlanningModel(
            id: option.id,
            recipeId: newMeal,
            time: option.time,
            day: option.day,
            title: option.title),
        option.day);

    isLoading(false);
    update();
  }

  Future<void> selectDate(BuildContext context, String id) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate.value,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != selectedDate.value) {
      selectedDate.value = selectedDate.value.copyWith(
          day: picked.day,
          month: picked.month,
          year: picked.year,
          hour: 0,
          minute: 0,
          second: 0,
          millisecond: 0,
          microsecond: 0);
    }
    update();
  }

  void fetchRecipes() async {
    try {
      isLoading(true);
      update();

      recipeList.clear();
      top5RecipesList.clear();
      update();

      recipeList = hCont.recipeList;
      //random the recipes
      recipeList.shuffle();
      if (recipeList.isEmpty) {
        isLoading(false);
        update();
        return;
      }

      //get the top 5 recipes
      top5RecipesList.addAll(recipeList.sublist(0, 5));

      update();
    } finally {
      isLoading(false);
      update();
    }
  }

  void searchItem(String text) {
    searchText(text);
    filteredList.clear();

    if (text.isNotEmpty) {
      isSearching(true);
      //search for the recipe title
      filteredList.addAll(recipeList.where((element) =>
          element.title.toLowerCase().contains(text.toLowerCase())));

      //search for ingredients
      filteredList.addAll(recipeList.where((element) => element.ingredients
          .any((ingredient) => ingredient.contains(text.toLowerCase()))));

      //search for meals
      filteredList.addAll(recipeList.where((element) => element.meals
          .any((category) => category.contains(text.toLowerCase()))));

      //search for food type
      filteredList.addAll(recipeList.where((element) => element.foodType
          .any((category) => category.contains(text.toLowerCase()))));
    }

    if (searchText.value.isEmpty) {
      isSearching(false);
      fetchRecipes();
    }
    update();
  }
}
