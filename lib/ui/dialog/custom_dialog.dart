import 'package:flutter/material.dart';

Future<bool> customDialog(BuildContext context, String title, String body,
    IconData iconData, Color color) async {
  bool op = false;
  await showDialog(
      barrierDismissible: true,
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(20.0))),
          title: Text(title),
          content: Text(
            body,
          ),
          actions: [
            TextButton(
                style: ButtonStyle(backgroundColor:
                    MaterialStateProperty.resolveWith<Color>(
                        (Set<MaterialState> states) {
                  if (states.contains(MaterialState.hovered))
                    return Colors.greenAccent;
                  return Colors.transparent;
                })),
                onPressed: () {
                  op = true;
                  Navigator.of(context).pop();
                },
                child: Text('Aceptar')),
          ],
        );
      });
  return op;
}
