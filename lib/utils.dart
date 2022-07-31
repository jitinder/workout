import 'package:flutter/cupertino.dart';

showTextDialog(BuildContext context, String title, Function(String) onSubmit) {
  showCupertinoDialog(
      context: context,
      builder: (BuildContext context) {
        TextEditingController textController = TextEditingController();
        return CupertinoAlertDialog(
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
        );
      });
}
