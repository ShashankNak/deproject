import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:pantry_plus/screens/pages/home/profile/profile_appbar.dart';
import 'package:pantry_plus/screens/pages/home/profile/profile_body.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: <Widget>[
        ProfileAppbar(),
        Expanded(child: ProfileBody()),
      ],
    );
  }
}
