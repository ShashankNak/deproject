class RecipeModel {
  late String recipeId;
  late String recipeName;
  late String recipeImage;
  late List<String> recipeCategory;
  late List<String> recipeIngredients;
  late List<String> recipeInstructions;
  late String recipeTime;
  late bool isGlutenFree;
  late bool isVegan;
  late bool isVegetarian;
  late bool isLactoseFree;
  late bool isJain;

  RecipeModel(
      {required this.recipeId,
      required this.recipeName,
      required this.recipeImage,
      required this.recipeCategory,
      required this.recipeIngredients,
      required this.recipeInstructions,
      required this.recipeTime,
      required this.isGlutenFree,
      required this.isVegan,
      required this.isVegetarian,
      required this.isLactoseFree,
      required this.isJain});

  RecipeModel.fromJson(Map<String, dynamic> json) {
    recipeId = json['recipeId'];
    recipeName = json['recipeName'];
    recipeImage = json['recipeImage'];
    recipeCategory = json['recipeCategory'].split("<->");
    recipeIngredients = json['recipeIngredients'].split("<->");
    recipeInstructions = json['recipeInstructions'].split("<->");
    recipeTime = json['recipeTime'];
    isGlutenFree = json['isGlutenFree'] == '1' ? true : false;
    isVegan = json['isVegan'] == '1' ? true : false;
    isVegetarian = json['isVegetarian'] == '1' ? true : false;
    isLactoseFree = json['isLactoseFree'] == '1' ? true : false;
    isJain = json['isJain'] == '1' ? true : false;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['recipeId'] = recipeId;
    data['recipeName'] = recipeName;
    data['recipeImage'] = recipeImage;
    data['recipeCategory'] = recipeCategory.join("<->");
    data['recipeIngredients'] = recipeIngredients.join("<->");
    data['recipeInstructions'] = recipeInstructions.join("<->");
    data['recipeTime'] = recipeTime;
    data['isGlutenFree'] = isGlutenFree ? '1' : '0';
    data['isVegan'] = isVegan ? '1' : '0';
    data['isVegetarian'] = isVegetarian ? '1' : '0';
    data['isLactoseFree'] = isLactoseFree ? '1' : '0';
    data['isJain'] = isJain ? '1' : '0';
    return data;
  }
}
