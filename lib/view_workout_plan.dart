import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'objects/workout_plan.dart';

class ViewWorkoutPlan extends StatefulWidget {
  final WorkoutPlan? workoutPlan;
  const ViewWorkoutPlan({Key? key, this.workoutPlan}) : super(key: key);

  @override
  State<ViewWorkoutPlan> createState() => _ViewWorkoutPlanState();
}

final List<String> days = [
  "monday",
  "tuesday",
  "wednesday",
  "thursday",
  "friday",
  "saturday",
  "sunday"
];

class _ViewWorkoutPlanState extends State<ViewWorkoutPlan> {
  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
        backgroundColor: CupertinoTheme.of(context).scaffoldBackgroundColor,
        navigationBar: CupertinoNavigationBar(
          backgroundColor: CupertinoTheme.of(context).barBackgroundColor,
          automaticallyImplyLeading: false,
          middle: Text(widget.workoutPlan?.name ?? ""),
          trailing: CupertinoButton(
            child: Text("Cancel"),
            onPressed: () {
              Navigator.pop(context);
            },
            padding: EdgeInsets.zero,
          ),
        ),
        child: Container(
          padding: EdgeInsets.symmetric(
            vertical: 16,
            horizontal: 8,
          ),
          child: ListView(
            children: [
              ...days.map(
                (day) {
                  return Card(
                    elevation: 0,
                    child: Row(
                      children: [
                        Expanded(
                          child: ListTile(
                            title: Text(day.substring(0, 1).toUpperCase() +
                                "" +
                                day.substring(1)),
                          ),
                        ),
                        Expanded(
                          child: CupertinoButton(
                            child: Text(
                              (widget.workoutPlan?.toJson()[day] as WorkoutDay?)
                                      ?.name ??
                                  "",
                              textScaleFactor: 0.9,
                            ),
                            onPressed: () {},
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ).toList(),
            ],
          ),
        ));
  }
}
