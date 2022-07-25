import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:settings_ui/settings_ui.dart';
import 'package:sid_workout/exercises_page.dart';
import 'package:sid_workout/utils.dart';

class Settings extends StatefulWidget {
  const Settings({Key? key}) : super(key: key);

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
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
        child: SafeArea(
          top: false,
          child: picker,
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
                      title: Text("Workout Plans"),
                      onPressed: (context) {
                        print("Clicked Workout Plans");
                      },
                    ),
                    SettingsTile.navigation(
                      title: Text("Current Plan"),
                      value: Text("Bulking"),
                      onPressed: (context) {
                        _showCupertinoPicker(
                          context,
                          CupertinoPicker(
                            itemExtent: 32.0,
                            onSelectedItemChanged: (item) {},
                            children: [
                              Text("Test1"),
                              Text("Test2"),
                              Text("Test3"),
                              Text("Test4"),
                            ],
                          ),
                        );
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
