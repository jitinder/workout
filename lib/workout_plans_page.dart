import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:sid_workout/data_storage.dart';
import 'package:sid_workout/new_workout_plan.dart';
import 'package:sid_workout/view_workout_plan.dart';
import 'package:swipeable_tile/swipeable_tile.dart';

import 'objects/workout_plan.dart';

class WorkoutPlans extends StatefulWidget {
  const WorkoutPlans({Key? key}) : super(key: key);

  @override
  State<WorkoutPlans> createState() => _WorkoutPlansState();
}

class _WorkoutPlansState extends State<WorkoutPlans> {
  List<WorkoutPlan> workoutPlans = <WorkoutPlan>[];

  @override
  void initState() {
    super.initState();
    _readFromFile();
  }

  _readFromFile() async {
    List<WorkoutPlan> rWorkoutPlans = await DataStorage().readWorkoutPlans();
    setState(() {
      workoutPlans = rWorkoutPlans;
    });
  }

  _writeToFile() async {
    await DataStorage().writeWorkoutPlans(workoutPlans);
  }

  Widget _workoutPlanTile(WorkoutPlan workoutPlan, int index) {
    return SwipeableTile(
      color: CupertinoColors.white,
      swipeThreshold: 0.4,
      direction: SwipeDirection.horizontal,
      onSwiped: (direction) {
        setState(() {
          workoutPlans.removeAt(index);
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
        title: Text(workoutPlan.name),
        onTap: () {
          showCupertinoModalBottomSheet(
              context: context,
              builder: (context) => ViewWorkoutPlan(
                    workoutPlan: workoutPlan,
                  ));
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Workout Plans"),
        backgroundColor: Colors.deepOrange,
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        backgroundColor: Colors.deepOrange,
        onPressed: () async {
          dynamic rValue = await showCupertinoModalBottomSheet(
            enableDrag: false,
            context: context,
            builder: (BuildContext buildContext) => NewWorkoutPlan(),
          );
          if (rValue != null) {
            setState(() {
              workoutPlans.add(rValue[0]);
            });
            _writeToFile();
          }
        },
      ),
      body: ListView.builder(
        itemCount: workoutPlans.length,
        itemBuilder: (BuildContext context, int index) {
          return _workoutPlanTile(workoutPlans[index], index);
        },
      ),
    );
  }
}
