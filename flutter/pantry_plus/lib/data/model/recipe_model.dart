// ignore_for_file: constant_identifier_names

enum Complexity {
  Simple,
  Challenging,
  Hard,
}

enum Affordability {
  Affordable,
  Pricey,
  Luxurious,
}

enum FoodType {
  vegetarian,
  nonVegetarian,
  glutenFree,
  lactoseFree,
  indian,
  jain,
  vegan
}

String getRecipeCategory(FoodType category) {
  switch (category) {
    case FoodType.vegetarian:
      return 'vegetarian';
    case FoodType.nonVegetarian:
      return 'non-vegetarian';
    case FoodType.glutenFree:
      return 'gluten-free';
    case FoodType.indian:
      return 'indian';
    case FoodType.lactoseFree:
      return 'lactose-free';
    case FoodType.jain:
      return 'jain';
    case FoodType.vegan:
      return 'vegan';
  }
}

FoodType getRecipeCategoryEnum(String text) {
  switch (text) {
    case 'vegetarian':
      return FoodType.vegetarian;
    case 'non-vegetarian':
      return FoodType.nonVegetarian;
    case 'gluten-free':
      return FoodType.glutenFree;
    case 'lactose-free':
      return FoodType.lactoseFree;
    case 'jain':
      return FoodType.jain;
    case 'vegan':
      return FoodType.vegan;
    default:
      return FoodType.vegetarian;
  }
}

class Recipe {
  final String id;
  final String title;
  final List<String> directions;
  final String imgUrl;
  final String duration;
  final List<String> meals;
  final List<String> foodType;
  final List<String> ingredients;
  final Complexity complexity;
  final Affordability affordability;

  Recipe({
    required this.id,
    required this.duration,
    required this.complexity,
    required this.affordability,
    required this.title,
    required this.directions,
    required this.imgUrl,
    required this.meals,
    required this.foodType,
    required this.ingredients,
  });

  //JSON TO Recipe Object
  factory Recipe.fromJson(Map<String, dynamic> json) {
    return Recipe(
      title: json['title'],
      directions: List<String>.from(json['directions']),
      imgUrl: json['imgUrl'],
      duration: json['duration'],
      meals: List<String>.from(json['meals']),
      foodType: List<String>.from(json['foodType']),
      ingredients: List<String>.from(json['ingredients']),
      complexity: Complexity.values.firstWhere(
        (element) => element.toString() == 'Complexity.${json['complexity']}',
      ),
      affordability: Affordability.values.firstWhere(
        (element) =>
            element.toString() == 'Affordability.${json['affordability']}',
      ),
      id: json['id'],
    );
  }

  //generate hashcode and equals for Recipe object
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Recipe &&
        other.title == title &&
        other.directions == directions &&
        other.imgUrl == imgUrl &&
        other.duration == duration &&
        other.meals == meals &&
        other.foodType == foodType &&
        other.ingredients == ingredients &&
        other.complexity == complexity &&
        other.affordability == affordability;
  }

  @override
  int get hashCode =>
      title.hashCode ^
      directions.hashCode ^
      imgUrl.hashCode ^
      duration.hashCode ^
      meals.hashCode ^
      foodType.hashCode ^
      ingredients.hashCode ^
      complexity.hashCode ^
      affordability.hashCode;
}
