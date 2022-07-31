import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NewWorkoutPlan extends StatefulWidget {
  const NewWorkoutPlan({Key? key}) : super(key: key);

  @override
  State<NewWorkoutPlan> createState() => _NewWorkoutPlanState();
}

class _NewWorkoutPlanState extends State<NewWorkoutPlan> {
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
        ),
        child: Container(
          padding: EdgeInsets.symmetric(
            vertical: 16,
            horizontal: 8,
          ),
          child: ListView(
            children: [
              Container(
                margin: EdgeInsets.symmetric(horizontal: 4),
                child: CupertinoTextField(
                  placeholder: "Workout Plan Name",
                ),
              ),
              Card(
                elevation: 0,
                child: ListTile(
                  title: Text("Test"),
                ),
              ),
            ],
          ),
        ));
  }
}
