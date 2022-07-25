import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sid_workout/workout_page.dart';

class Workout extends StatefulWidget {
  const Workout({Key? key}) : super(key: key);

  @override
  State<Workout> createState() => _WorkoutState();
}

Widget _showWorkoutCard(
  BuildContext context,
  String imageName,
  String title, {
  String? subtitle,
}) {
  return Card(
    elevation: 0,
    margin: EdgeInsets.symmetric(horizontal: 8),
    shape: RoundedRectangleBorder(),
    child: InkWell(
      onTap: () {
        Navigator.push(
          context,
          CupertinoPageRoute(
            builder: (context) => WorkoutPage(
              title: title,
              date: subtitle,
            ),
          ),
        );
      },
      child: Container(
        width: double.maxFinite,
        height: 80,
        child: Center(
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Image.asset(imageName),
                flex: 1,
              ),
              Expanded(
                child: ListTile(
                  title: Text(title),
                  subtitle: subtitle == null ? null : Text(subtitle),
                ),
                flex: 2,
              ),
            ],
          ),
        ),
      ),
    ),
  );
}

class _WorkoutState extends State<Workout> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Container(
            margin: EdgeInsets.fromLTRB(8, 24, 8, 8),
            child: Center(
              child: Text(
                "Today's Workout",
                style: Theme.of(context).textTheme.headline6,
              ),
            ),
          ),
          Container(
            width: double.maxFinite,
            height: 80,
            decoration: BoxDecoration(
              color: Colors.blue.shade100,
              borderRadius: BorderRadius.circular(16),
            ),
            margin: EdgeInsets.all(8),
            padding: EdgeInsets.all(8),
            child: Center(
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Image.asset("assets/apple-juice.png"),
                    flex: 1,
                  ),
                  Expanded(
                    child: ListTile(
                      title: Text("Rest Day"),
                    ),
                    flex: 2,
                  ),
                ],
              ),
            ),
          ),
          _showWorkoutCard(context, "assets/chest.png", "Chest Bicep"),
          Container(
            margin: EdgeInsets.fromLTRB(8, 16, 8, 16),
            child: Text(
              "Past Workouts",
              style: Theme.of(context).textTheme.headline6,
            ),
          ),
          Expanded(
            child: ListView(
              children: [
                _showWorkoutCard(context, "assets/chest.png", "Chest Bicep",
                    subtitle: "Date"),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
