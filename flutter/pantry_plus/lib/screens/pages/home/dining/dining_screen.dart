import 'package:flutter/widgets.dart';
import 'package:pantry_plus/screens/pages/home/dining/dining_appbar.dart';

class DiningScreen extends StatelessWidget {
  const DiningScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: <Widget>[
        DiningAppbar(),
        //rest of the body
        Expanded(
          child: Center(
            child: Text("Dining Screen"),
          ),
        )
      ],
    );
  }
}
