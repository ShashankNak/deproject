enum Gender { male, female, other, none }

class UserDetailsModel {
  late String mId;
  late String fId;
  late String name;
  late String email;
  late String imageUrl;
  late String birthdate;
  late Gender gender;
  late String height;
  late String weight;
  late String preference;

  UserDetailsModel(
      {required this.mId,
      required this.fId,
      required this.name,
      required this.email,
      required this.imageUrl,
      required this.birthdate,
      required this.gender,
      required this.height,
      required this.weight,
      required this.preference});

  UserDetailsModel.fromJson(Map<String, dynamic> json) {
    mId = json['mId'];
    fId = json['fId'];
    name = json['name'];
    email = json['email'];
    imageUrl = json['imageUrl'];
    birthdate = json['birthdate'];
    gender = json['gender'] == "male"
        ? Gender.male
        : json['gender'] == "female"
            ? Gender.female
            : json['gender'] == "none"
                ? Gender.none
                : Gender.other;
    height = json['height'];
    weight = json['weight'];
    preference = json['preference'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['mId'] = mId;
    data['fId'] = fId;
    data['name'] = name;
    data['email'] = email;
    data['imageUrl'] = imageUrl;
    data['birthdate'] = birthdate;
    data['gender'] = gender.toString().split(".").last;
    data['height'] = height;
    data['weight'] = weight;
    data['preference'] = preference;
    return data;
  }
}
