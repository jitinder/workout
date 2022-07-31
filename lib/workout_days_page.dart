import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:sid_workout/objects/workout_plan.dart';
import 'package:swipeable_tile/swipeable_tile.dart';

import 'data_storage.dart';
import 'exercises_page.dart';
import 'new_workout_day.dart';

class WorkoutDays extends StatefulWidget {
  const WorkoutDays({Key? key}) : super(key: key);

  @override
  State<WorkoutDays> createState() => _WorkoutDaysState();
}

class _WorkoutDaysState extends State<WorkoutDays> {
  List<WorkoutDay> workoutDays = <WorkoutDay>[];

  @override
  void initState() {
    super.initState();
    _readFromFile();
  }

  _readFromFile() async {
    List<WorkoutDay> rWorkoutDay = await DataStorage().readWorkoutDays();
    setState(() {
      workoutDays = rWorkoutDay;
    });
  }

  _writeToFile() async {
    await DataStorage().writeWorkoutDays(workoutDays);
  }

  Widget _workoutPlanTile(WorkoutDay workoutDay, int index) {
    return SwipeableTile(
      color: CupertinoColors.white,
      swipeThreshold: 0.4,
      direction: SwipeDirection.horizontal,
      onSwiped: (direction) {
        setState(() {
          workoutDays.removeAt(index);
        });
        _writeToFile();
      },
      backgroundBuilder: (context, direction, progress) {
        return AnimatedBuilder(
          animation: progress,
          builder: (_, __) {
            return AnimatedContainer(
              duration: const Duration(milliseconds: 400),
              color: progress.value > 0.4 ? Colors.red : Colors.transparent,
            );
          },
        );
      },
      key: UniqueKey(),
      child: ListTile(
        title: Text(workoutDay.name),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Workout Days"),
        backgroundColor: Colors.deepOrange,
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        backgroundColor: Colors.deepOrange,
        onPressed: () async {
          final exercises = await Navigator.push(
            context,
            CupertinoPageRoute(
              builder: (context) => const Exercises(
                selecting: true,
              ),
            ),
          );
          final wDay = await showCupertinoModalBottomSheet(
            enableDrag: false,
            context: context,
            builder: (context) => NewWorkoutDay(
              workoutExercises: exercises,
            ),
          );
          if (wDay != null) {
            WorkoutDay workoutDay = wDay[0];
            setState(() {
              workoutDays.add(workoutDay);
            });
            _writeToFile();
          }
        },
      ),
      body: ListView.builder(
        itemCount: workoutDays.length,
        itemBuilder: (BuildContext context, int index) {
          return _workoutPlanTile(workoutDays[index], index);
        },
      ),
    );
  }
}
