import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:idec_face/constants.dart';
import 'package:idec_face/custom_widgets/ticket/ticket_text.dart';

class TicketCard extends StatelessWidget {
  final int index;
  const TicketCard({
    Key? key,
    required this.index,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(1),
      child: Container(
        height: screenHeight(context, dividedBy: 5.5),
        color: Colors.white,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Icon(
              Icons.arrow_left,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const TicketText(
                  islabelrequired: true,
                  isSameAsLabelStyle: true,
                  label: "Ticket No :",
                  value: "1100224",
                  withlabelStyle:
                      TextStyle(fontSize: 23, fontWeight: FontWeight.bold),
                ),
                const TicketText(
                  islabelrequired: false,
                  label: "",
                  value: "10:00, 23March 2022",
                ),
                TicketText(
                  islabelrequired: true,
                  isSameAsLabelStyle: false,
                  isIconNeeded: true,
                  icon: SvgPicture.asset(
                    'assets/svg/clock.svg',
                    height: 20,
                  ),
                  label: " Active Since:",
                  value: "17 Min",
                  valueStyle: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).primaryColor),
                ),
                Container(
                  height: screenHeight(context, dividedBy: 23.44),
                  width: screenWidth(context, dividedBy: 1.4),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(18),
                      color: (index % 2 == 0)
                          ? AppConstants.severityMinor
                          : (index % 3 == 0)
                              ? AppConstants.severityMajor
                              : AppConstants.severityCritical),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      TicketText(
                        islabelrequired: false,
                        label: "",
                        valueStyle: TextStyle(fontSize: 19),
                        value: "Beverages",
                      ),
                      Text(
                        ',',
                        style: TextStyle(fontSize: 19),
                      ),
                      TicketText(
                        islabelrequired: false,
                        label: "",
                        valueStyle: TextStyle(fontSize: 19),
                        value: "Hudson Square",
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const Icon(Icons.arrow_right),
          ],
        ),
      ),
    );
  }
}
