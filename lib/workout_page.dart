import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class WorkoutPage extends StatefulWidget {
  const WorkoutPage({
    Key? key,
    this.title,
    this.date,
  }) : super(key: key);

  final String? title;
  final String? date;

  @override
  State<WorkoutPage> createState() => _WorkoutPageState();
}

class _WorkoutPageState extends State<WorkoutPage> {
  TableRow _setEntryRow() {
    return TableRow(
      children: [
        Container(
          margin: EdgeInsets.all(4),
          child: CupertinoTextField(),
        ),
        Container(margin: EdgeInsets.all(4), child: CupertinoTextField()),
      ],
    );
  }

  Widget _exerciseCard(
    String name,
    String description,
    int numSets,
  ) {
    var tableRows = List.filled(numSets, _setEntryRow());
    return Card(
      elevation: 0,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: ListTile(
              title: Text(
                name,
              ),
              subtitle: Text(description),
              trailing: IconButton(
                icon: const Icon(Icons.history),
                onPressed: () {},
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Table(
              children: [
                TableRow(
                  children: [
                    Container(
                      margin: EdgeInsets.all(4),
                      child: Text("Weight"),
                    ),
                    Container(
                      margin: EdgeInsets.all(4),
                      child: Text("Reps"),
                    ),
                  ],
                ),
                ...tableRows,
              ],
            ),
          ),
          const Text(
            "Additional Notes",
            textAlign: TextAlign.left,
          ),
          Container(
            margin: EdgeInsets.all(16),
            child: CupertinoTextField(),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CupertinoColors.secondarySystemBackground,
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(widget.title ?? "Page Title"),
            Text(widget.date ?? "Today")
          ],
        ),
        backgroundColor: Colors.deepOrange,
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {},
        backgroundColor: CupertinoColors.activeGreen,
        icon: Icon(Icons.check),
        label: Text("Save"),
      ),
      body: ListView(
        children: [
          Card(
            elevation: 0,
            child: ListTile(
              title: Text(
                "Warm-up",
                textAlign: TextAlign.center,
              ),
            ),
          ),
          _exerciseCard(
            "Exercise Name",
            "description",
            3,
          ),
          _exerciseCard(
            "Exercise Name",
            "description",
            4,
          ),
          _exerciseCard(
            "Exercise Name",
            "description",
            2,
          ),
          _exerciseCard(
            "Exercise Name",
            "description",
            4,
          ),
          SizedBox(
            height: 75,
          ),
        ],
      ),
    );
  }
}
