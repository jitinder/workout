import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

showTextDialog(BuildContext context, String title, Function(String) onSubmit) {
  TextEditingController textController = TextEditingController();
  showDialog(
    context: context,
    builder: (BuildContext context) => CupertinoAlertDialog(
      title: Text(title),
      content: CupertinoTextField(
        autofocus: true,
        controller: textController,
      ),
      actions: [
        CupertinoDialogAction(
          child: Text("Cancel"),
          isDestructiveAction: true,
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        CupertinoDialogAction(
          child: Text("Submit"),
          onPressed: () {
            onSubmit(textController.text.toString());
            Navigator.pop(context);
          },
        ),
      ],
    ),
  );
}
