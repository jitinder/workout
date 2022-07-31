import 'dart:convert';
import 'dart:io';

import 'package:path_provider/path_provider.dart';

import 'objects/workout_plan.dart';

class DataStorage {
  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  Future<File> get _workoutDaysFile async {
    final path = await _localPath;
    return File('$path/workoutDays.json');
  }

  Future<List<WorkoutDay>> readWorkoutDays() async {
    try {
      final file = await _workoutDaysFile;
      final contents = await file.readAsString();
      Iterable l = json.decode(contents);
      List<WorkoutDay> workoutDays = List<WorkoutDay>.from(
        l.map(
          (model) => WorkoutDay.fromJson(model),
        ),
      );
      return workoutDays;
    } catch (e) {
      return [];
    }
  }

  Future<File> writeWorkoutDays(List<WorkoutDay> workoutDays) async {
    final file = await _workoutDaysFile;
    return file.writeAsString(
      json.encode(workoutDays),
    );
  }

  Future<File> get _workoutPlansFile async {
    final path = await _localPath;
    return File('$path/workoutPlans.json');
  }

  Future<List<WorkoutPlan>> readWorkoutPlans() async {
    try {
      final file = await _workoutPlansFile;
      final contents = await file.readAsString();
      Iterable l = json.decode(contents);
      List<WorkoutPlan> workoutPlans = List<WorkoutPlan>.from(
        l.map(
          (model) => WorkoutPlan.fromJson(model),
        ),
      );
      return workoutPlans;
    } catch (e) {
      return [];
    }
  }

  Future<File> writeWorkoutPlans(List<WorkoutPlan> workoutPlans) async {
    final file = await _workoutPlansFile;
    return file.writeAsString(
      json.encode(workoutPlans),
    );
  }

  Future<File> get _exerciseFile async {
    final path = await _localPath;
    return File('$path/exercises.txt');
  }

  Future<List<String>> readExercises() async {
    try {
      final file = await _exerciseFile;
      final contents = await file.readAsString();

      return contents.split(", ");
    } catch (e) {
      // If encountering an error, return empty string
      return [];
    }
  }

  Future<File> writeExercises(List<String> exercises) async {
    final file = await _exerciseFile;
    return file.writeAsString(exercises.join(", "));
  }
}
