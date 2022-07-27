import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sid_workout/data_storage.dart';
import 'package:sid_workout/utils.dart';
import 'package:swipeable_tile/swipeable_tile.dart';

class Exercises extends StatefulWidget {
  const Exercises({Key? key}) : super(key: key);

  @override
  State<Exercises> createState() => _ExercisesState();
}

class _ExercisesState extends State<Exercises> {
  List<String> exercises = <String>[];

  @override
  void initState() {
    super.initState();
    _readFromFile();
  }

  _readFromFile() async {
    List<String> rExercises = await DataStorage().readExercises();
    setState(() {
      exercises = rExercises;
    });
  }

  _writeToFile() async {
    await DataStorage().writeExercises(exercises);
  }

  Widget _exerciseTile(String title, int index) {
    return SwipeableTile(
      color: CupertinoColors.white,
      swipeThreshold: 0.4,
      direction: SwipeDirection.horizontal,
      onSwiped: (direction) {
        setState(() {
          exercises.removeAt(index);
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
        title: Text(title),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Exercises"),
        backgroundColor: Colors.deepOrange,
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        backgroundColor: Colors.deepOrange,
        onPressed: () {
          showTextDialog(context, "Enter Exercise Name", (text) {
            setState(() {
              exercises.add((text).toString());
            });
            _writeToFile();
          });
        },
      ),
      body: ListView.builder(
        itemCount: exercises.length,
        itemBuilder: (BuildContext context, int index) {
          return _exerciseTile(exercises[index], index);
        },
      ),
    );
  }
}
