import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:settings_ui/settings_ui.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sid_workout/data_storage.dart';
import 'package:sid_workout/exercises_page.dart';
import 'package:sid_workout/utils.dart';
import 'package:sid_workout/workout_plans_page.dart';

import 'objects/workout_plan.dart';
import 'workout_days_page.dart';

class Settings extends StatefulWidget {
  const Settings({Key? key}) : super(key: key);

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  String? _workoutPlanName;
  List<WorkoutPlan> _workoutPlans = [];

  @override
  void initState() {
    super.initState();
    _getWorkoutPlanName();
    _getWorkoutPlans();
  }

  void _getWorkoutPlans() async {
    List<WorkoutPlan> plans = await DataStorage().readWorkoutPlans();
    setState(() {
      _workoutPlans = plans;
    });
  }

  void _getWorkoutPlanName() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _workoutPlanName = prefs.getString("workout_plan_name");
    });
  }

  void _setWorkoutPlanName() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString("workout_plan_name", _workoutPlanName ?? "");
  }

  _showCupertinoPicker(BuildContext context, Widget picker) {
    showCupertinoModalPopup(
      context: context,
      builder: (BuildContext context) => Container(
        height: 200,
        padding: const EdgeInsets.only(top: 6.0),
        // The Bottom margin is provided to align the popup above the system navigation bar.
        margin: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        // Provide a background color for the popup.
        color: CupertinoColors.systemBackground.resolveFrom(context),
        // Use a SafeArea widget to avoid system overlaps.
        child: Column(
          children: [
            CupertinoButton(
              child: Text("Save"),
              onPressed: () {
                Navigator.pop(context);
                if (_workoutPlanName == null) {
                  setState(() {
                    _workoutPlanName = _workoutPlans[0].name;
                  });
                }
                _setWorkoutPlanName();
              },
            ),
            SafeArea(
              top: false,
              child: picker,
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Container(
            margin: EdgeInsets.fromLTRB(8, 24, 8, 8),
            child: Center(
              child: Text(
                "Settings",
                style: Theme.of(context).textTheme.headline6,
              ),
            ),
          ),
          Expanded(
            child: SettingsList(
              lightTheme: SettingsThemeData(
                settingsListBackground:
                    ThemeData.light().scaffoldBackgroundColor,
              ),
              darkTheme: SettingsThemeData(
                settingsListBackground:
                    ThemeData.dark().scaffoldBackgroundColor,
              ),
              sections: [
                SettingsSection(
                  title: Text('Workout'),
                  tiles: <SettingsTile>[
                    SettingsTile.navigation(
                      title: Text('Exercises'),
                      onPressed: (context) {
                        Navigator.push(
                          context,
                          CupertinoPageRoute(
                            builder: (context) => const Exercises(),
                          ),
                        );
                      },
                    ),
                    SettingsTile.navigation(
                      title: Text("Workout Days"),
                      onPressed: (context) {
                        Navigator.push(
                          context,
                          CupertinoPageRoute(
                            builder: (context) => const WorkoutDays(),
                          ),
                        );
                      },
                    ),
                    SettingsTile.navigation(
                      title: Text("Workout Plans"),
                      onPressed: (context) {
                        Navigator.push(
                          context,
                          CupertinoPageRoute(
                            builder: (context) => const WorkoutPlans(),
                          ),
                        );
                      },
                    ),
                    SettingsTile.navigation(
                      title: Text("Current Plan"),
                      value: Text(_workoutPlanName ?? "None"),
                      onPressed: (context) async {
                        if (_workoutPlans.isNotEmpty) {
                          _showCupertinoPicker(
                            context,
                            CupertinoPicker(
                              itemExtent: 32.0,
                              onSelectedItemChanged: (index) {
                                setState(() {
                                  _workoutPlanName = _workoutPlans[index].name;
                                });
                              },
                              children: [
                                ..._workoutPlans
                                    .map((wPlan) => Text(wPlan.name)),
                              ],
                            ),
                          );
                        } else {
                          setState(() {
                            _workoutPlanName = null;
                          });
                          _setWorkoutPlanName();
                        }
                      },
                    ),
                  ],
                ),
                SettingsSection(
                  title: Text("Nutrition"),
                  tiles: [
                    SettingsTile.navigation(
                      title: Text("Target Calories"),
                      value: Text("2800 kCal"),
                      onPressed: (context) {
                        showTextDialog(context, "Enter Calories", (text) {
                          print("Clicked Submit");
                        });
                      },
                    ),
                  ],
                ),
                SettingsSection(
                  title: Text("Macros Split"),
                  tiles: [
                    SettingsTile.navigation(
                      title: Text("Carbohydrates"),
                      value: Text("200g"),
                      onPressed: (context) {
                        showTextDialog(context, "Enter Carbohydrates", (text) {
                          print("Clicked Submit");
                        });
                      },
                    ),
                    SettingsTile.navigation(
                      title: Text("Protein"),
                      value: Text("200g"),
                      onPressed: (context) {
                        print("Clicked Protein");
                      },
                    ),
                    SettingsTile.navigation(
                      title: Text("Fat"),
                      value: Text("200g"),
                      onPressed: (context) {
                        print("Clicked Fat");
                      },
                    ),
                  ],
                ),
                SettingsSection(
                  title: Text("Food"),
                  tiles: [
                    SettingsTile.navigation(
                      title: Text("Meals"),
                    ),
                    SettingsTile.navigation(
                      title: Text("Meal Plans"),
                    ),
                    SettingsTile.navigation(
                      title: Text("Current Plan"),
                      value: Text("Bulking"),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
