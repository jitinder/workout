import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sid_workout/objects/workout_plan.dart';

class ViewWorkoutDay extends StatefulWidget {
  final WorkoutDay? workoutDay;
  const ViewWorkoutDay({Key? key, this.workoutDay}) : super(key: key);

  @override
  State<ViewWorkoutDay> createState() => _ViewWorkoutDayState();
}

class _ViewWorkoutDayState extends State<ViewWorkoutDay> {
  @override
  void initState() {
    super.initState();
  }

  Widget _exerciseCard(WorkoutExercise exercise) {
    return Card(
      elevation: 0,
      child: ListTile(
        title: Text(exercise.name),
        subtitle: Column(
          children: [
            Container(
              child: Text(exercise.description),
              padding: EdgeInsets.symmetric(
                vertical: 8,
              ),
              alignment: Alignment.centerLeft,
            ),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Expanded(
                  child: Text(
                    "Sets: " + exercise.sets.toString(),
                  ),
                ),
                Expanded(
                  child: Text("Rest: " + exercise.restTime.toString() + 's'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      backgroundColor: CupertinoTheme.of(context).scaffoldBackgroundColor,
      navigationBar: CupertinoNavigationBar(
        backgroundColor: CupertinoTheme.of(context).barBackgroundColor,
        automaticallyImplyLeading: false,
        middle: Text(widget.workoutDay?.name ?? ""),
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
        child: Column(
          children: [
            Expanded(
              flex: 14,
              child: ListView(
                children: [
                  ...?widget.workoutDay?.exercises.map(
                    (e) {
                      return _exerciseCard(e);
                    },
                  ).toList(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
