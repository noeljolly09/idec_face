import 'package:flutter/material.dart';

import 'button.dart';

void messageDialog(BuildContext context, TextEditingController domain,
    String title, String description) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      Future.delayed(const Duration(seconds: 4), () {
        Navigator.of(context).pop(true);
      });
      return AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        elevation: 100,
        titleTextStyle: const TextStyle(
            fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black),
        title: Align(
          alignment: Alignment.center,
          child: Text(
            title,
          ),
        ),
        content: Text(description),
        actionsAlignment: MainAxisAlignment.center,
        actions: <Widget>[
          SizedBox(
            width: MediaQuery.of(context).size.width / 5,
            child: CustomButton(
              height: 40,
              function: () {
                Navigator.pop(context);
              },
              buttonColor: Theme.of(context).primaryColor,
              buttonBorderRadius: BorderRadius.circular(05),
              iconColor: Colors.white,
              data: 'OK',
            ),
          ),
        ],
      );
    },
  );
}
