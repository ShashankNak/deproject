// class UserAuthModel {
//   final String fUid;
//   final String mUid;
//   final String email;

//   UserAuthModel({required this.email, required this.fUid, required this.mUid});

//   factory UserAuthModel.fromJson(Map<String, dynamic> json) {
//     return UserAuthModel(
//       email: json['email'],
//       fUid: json['fUid'],
//       mUid: json['mUid'],
//     );
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = <String, dynamic>{};
//     data['email'] = email;
//     data['fUid'] = fUid;
//     data['mUid'] = mUid;
//     return data;
//   }
// }
