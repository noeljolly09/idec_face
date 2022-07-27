import 'package:flutter/material.dart';
import 'package:idec_face/constants.dart';
import 'package:intl/intl.dart';

PreferredSizeWidget customAppBar(String title) {
  String currentDate = DateFormat.MMMMd().format(DateTime.now());
  String currentTime = DateFormat.jm().format(DateTime.now());

  const timestyle = TextStyle(fontSize: 10);

  return AppBar(
    backgroundColor: AppConstants.primaryColor,
    title: Text(title),
    actions: [
      Align(
          alignment: Alignment.bottomRight,
          child: Row(
            children: [
              const Text(
                "Updated on: ",
                style: timestyle,
              ),
              Text(
                currentDate,
                style: TextStyle(
                    fontFamily: AppConstants.forNumbersFont, fontSize: 10),
              ),
              const Text(
                ',',
                style: timestyle,
              ),
              Text(
                currentTime,
                style: TextStyle(
                    fontFamily: AppConstants.forNumbersFont, fontSize: 10),
              ),
            ],
          ))
    ],
  );
}
