class MealPlanningModel {
  //contains time
  late String id;
  late String time;
  late String day;
  late String title;
  late List<String> recipeId;

  MealPlanningModel({
    required this.id,
    required this.recipeId,
    required this.time,
    required this.day,
    required this.title,
  });

  //json to model conversion
  factory MealPlanningModel.fromJson(Map<String, dynamic> json) {
    return MealPlanningModel(
      id: json['id'],
      time: json['time'],
      day: json['day'],
      title: json['title'],
      recipeId: List<String>.from(json['recipeId']),
    );
  }

//model to json conversion
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'time': time,
      'day': day,
      'title': title,
      'recipeId': recipeId,
    };
  }
}
