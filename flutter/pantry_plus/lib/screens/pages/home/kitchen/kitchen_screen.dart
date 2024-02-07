import 'package:flutter/material.dart';
import 'package:pantry_plus/screens/pages/home/kitchen/kitchen_appbar.dart';

class KitchenScreen extends StatelessWidget {
  const KitchenScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: <Widget>[
        KitchenAppbar(),
        //rest of the body
        Expanded(
          child: Center(
            child: Text("Kitchen Screen"),
          ),
        )
      ],
    );
  }
}
