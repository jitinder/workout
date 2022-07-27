import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sid_workout/data_storage.dart';
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
        onPressed: () {
          // Add logic here
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
