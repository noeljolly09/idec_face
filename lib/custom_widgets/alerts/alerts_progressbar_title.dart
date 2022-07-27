import 'package:flutter/material.dart';
import 'package:idec_face/constants.dart';

class AlertProgressBarTitle extends StatelessWidget {
  const AlertProgressBarTitle({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment:
          MainAxisAlignment.spaceEvenly,
      children: [
        Row(
          children: [
            Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppConstants
                    .severityCritical,
              ),
              height: 10,
              width: 10,
            ),
            const SizedBox(width: 5),
            const Padding(
              padding: EdgeInsets.only(
                  left: 3.0),
              child: Text(
                'Critical',
                style: TextStyle(
                  fontSize: 18,
                ),
              ),
            )
          ],
        ),
        Row(
          children: [
            Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppConstants
                    .severityMajor,
              ),
              height: 10,
              width: 10,
            ),
            const SizedBox(width: 5),
            const Padding(
              padding: EdgeInsets.only(
                  left: 3.0),
              child: Text(
                'Major',
                style: TextStyle(
                  fontSize: 18,
                ),
              ),
            )
          ],
        ),
        Row(
          children: [
            Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppConstants
                    .severityMinor,
              ),
              height: 10,
              width: 10,
            ),
            const SizedBox(width: 5),
            const Padding(
              padding: EdgeInsets.only(
                  left: 3.0),
              child: Text(
                'Minor',
                style: TextStyle(
                  fontSize: 18,
                ),
              ),
            )
          ],
        ),
      ],
    );
  }
}
