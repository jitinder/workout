import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sid_workout/workout_days_page.dart';

import 'objects/workout_plan.dart';

class NewWorkoutPlan extends StatefulWidget {
  const NewWorkoutPlan({Key? key}) : super(key: key);

  @override
  State<NewWorkoutPlan> createState() => _NewWorkoutPlanState();
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

class _NewWorkoutPlanState extends State<NewWorkoutPlan> {
  TextEditingController _nameController = TextEditingController();
  List<WorkoutDay?> wDays = List.filled(7, null);
  bool? _isValid = null;

  Future<WorkoutDay?> _pickWorkoutDay(BuildContext context) async {
    dynamic rValue = await showCupertinoModalPopup(
      context: context,
      builder: (context) => const WorkoutDays(
        picking: true,
      ),
    );
    return rValue?[0];
  }

  bool? _validateInput() {
    if (_nameController.text.isNotEmpty) {
      for (WorkoutDay? day in wDays) {
        if (day == null) {
          return false;
        }
      }
      return null;
    }
    return false;
  }

  WorkoutPlan _makeWorkoutPlan() {
    String name = _nameController.text;
    WorkoutDay mon = wDays[0] ?? WorkoutDay("", []);
    WorkoutDay tue = wDays[0] ?? WorkoutDay("", []);
    WorkoutDay wed = wDays[0] ?? WorkoutDay("", []);
    WorkoutDay thu = wDays[0] ?? WorkoutDay("", []);
    WorkoutDay fri = wDays[0] ?? WorkoutDay("", []);
    WorkoutDay sat = wDays[0] ?? WorkoutDay("", []);
    WorkoutDay sun = wDays[0] ?? WorkoutDay("", []);
    return WorkoutPlan(name, mon, tue, wed, thu, fri, sat, sun);
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
        backgroundColor: CupertinoTheme.of(context).scaffoldBackgroundColor,
        navigationBar: CupertinoNavigationBar(
          backgroundColor: CupertinoTheme.of(context).barBackgroundColor,
          automaticallyImplyLeading: false,
          middle: Text("New Workout Plan"),
          trailing: CupertinoButton(
            child: Text("Cancel"),
            onPressed: () {
              Navigator.pop(context);
            },
            padding: EdgeInsets.zero,
          ),
          leading: CupertinoButton(
            child: Text("Save"),
            onPressed: () {
              setState(() {
                _isValid = _validateInput();
              });
              if (_isValid == null) {
                WorkoutPlan workoutPlan = _makeWorkoutPlan();
                Navigator.pop(context, [workoutPlan]);
              }
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
              _isValid == null
                  ? Container()
                  : CupertinoButton(
                      child: Text("Invalid Input"),
                      onPressed: null,
                      color: CupertinoColors.destructiveRed,
                      disabledColor: CupertinoColors.destructiveRed,
                    ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 4, vertical: 8),
                child: CupertinoTextField(
                  placeholder: "Workout Plan Name",
                  controller: _nameController,
                ),
              ),
              ...days.map(
                (day) {
                  int index = days.indexOf(day);
                  WorkoutDay? wDay = wDays[index];
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
                              wDay?.name ?? "Select",
                              textScaleFactor: 0.9,
                            ),
                            onPressed: () async {
                              WorkoutDay? newWDay =
                                  await _pickWorkoutDay(context);
                              setState(() {
                                wDays[index] = newWDay;
                              });
                            },
                            padding: EdgeInsets.zero,
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
