import 'package:flutter/widgets.dart';
import 'package:pantry_plus/screens/pages/home/planner/planner_appbar.dart';

class PlannerScreen extends StatelessWidget {
  const PlannerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        PlannerAppbar(),
        Expanded(
          child: Center(
            child: Text("Planner Screen"),
          ),
        ),
      ],
    );
  }
}
