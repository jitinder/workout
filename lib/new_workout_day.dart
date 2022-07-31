import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sid_workout/objects/workout_plan.dart';

class NewWorkoutDay extends StatefulWidget {
  final List<String>? workoutExercises;
  const NewWorkoutDay({Key? key, this.workoutExercises}) : super(key: key);

  @override
  State<NewWorkoutDay> createState() => _NewWorkoutDayState();
}

class _NewWorkoutDayState extends State<NewWorkoutDay> {
  List<TextEditingController> _descControllers = [];
  List<TextEditingController> _setControllers = [];
  List<TextEditingController> _restControllers = [];
  TextEditingController dayNameCtrl = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    widget.workoutExercises?.forEach((element) {
      TextEditingController descController = TextEditingController();
      TextEditingController setController = TextEditingController();
      TextEditingController restController = TextEditingController();
      _descControllers.add(descController);
      _setControllers.add(setController);
      _restControllers.add(restController);
    });
  }

  BoxDecoration _textFieldDecoration() {
    return BoxDecoration(
      border: Border.all(
        color: Colors.black12,
      ),
      borderRadius: BorderRadius.circular(8.0),
    );
  }

  Widget _exerciseCard(String exercise, int index) {
    return Card(
      elevation: 0,
      child: ListTile(
        contentPadding: EdgeInsets.symmetric(vertical: 8, horizontal: 4),
        title: Text(exercise),
        subtitle: Column(
          children: [
            CupertinoTextFormFieldRow(
              placeholder: "Description",
              controller: _descControllers[index],
              decoration: _textFieldDecoration(),
              padding: EdgeInsets.symmetric(
                vertical: 4,
              ),
              expands: true,
              maxLines: null,
              validator: (String? value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter a value';
                }
                return null;
              },
            ),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Expanded(
                  child: CupertinoTextFormFieldRow(
                    placeholder: "Sets",
                    controller: _setControllers[index],
                    decoration: _textFieldDecoration(),
                    keyboardType: TextInputType.number,
                    padding: EdgeInsets.fromLTRB(0, 4, 4, 4),
                    validator: (String? value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a value';
                      }
                      int val = int.parse(value);
                      if (val < 0) {
                        return "Please enter a positive value";
                      }
                      return null;
                    },
                  ),
                ),
                Expanded(
                  child: CupertinoTextFormFieldRow(
                    placeholder: "Rest Time (s)",
                    controller: _restControllers[index],
                    decoration: _textFieldDecoration(),
                    keyboardType: TextInputType.number,
                    padding: EdgeInsets.fromLTRB(4, 4, 0, 4),
                    validator: (String? value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a value';
                      }
                      int val = int.parse(value);
                      if (val < 0) {
                        return "Please enter a positive value";
                      }
                      return null;
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
        trailing: CupertinoButton(
          child: Icon(
            CupertinoIcons.trash,
            color: CupertinoColors.destructiveRed,
          ),
          onPressed: () {
            setState(() {
              widget.workoutExercises?.remove(exercise);
              _descControllers.removeAt(index);
              _setControllers.removeAt(index);
              _restControllers.removeAt(index);
            });
          },
          padding: EdgeInsets.zero,
        ),
      ),
    );
  }

  WorkoutDay? _getWorkoutDay() {
    if (_formKey.currentState!.validate()) {
      String dayName = dayNameCtrl.text;
      List<WorkoutExercise> exercisesToSave = [];
      widget.workoutExercises?.asMap().forEach((index, exerciseName) {
        WorkoutExercise wExercise = WorkoutExercise(
            exerciseName,
            _descControllers[index].text,
            int.parse(_setControllers[index].text),
            int.parse(_restControllers[index].text));
        exercisesToSave.add(wExercise);
      });
      WorkoutDay wDay = WorkoutDay(dayName, exercisesToSave);
      return wDay;
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      backgroundColor: CupertinoTheme.of(context).scaffoldBackgroundColor,
      navigationBar: CupertinoNavigationBar(
        backgroundColor: CupertinoTheme.of(context).barBackgroundColor,
        automaticallyImplyLeading: false,
        middle: Text("New Workout Day"),
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
            dynamic wDay = _getWorkoutDay();
            Navigator.pop(context, [wDay]);
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
              child: Form(
                key: _formKey,
                onChanged: () {
                  Form.of(primaryFocus!.context!)?.save();
                },
                child: ListView(
                  children: [
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 4),
                      child: CupertinoTextFormFieldRow(
                        controller: dayNameCtrl,
                        placeholder: "Day Name",
                        padding: EdgeInsets.symmetric(vertical: 8),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter a name.';
                          }
                          return null;
                        },
                        decoration: _textFieldDecoration(),
                      ),
                    ),
                    ...?widget.workoutExercises?.map(
                      (e) {
                        int? index = widget.workoutExercises?.indexOf(e);
                        return _exerciseCard(e, index ?? 0);
                      },
                    ).toList(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
