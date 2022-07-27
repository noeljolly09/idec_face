import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:idec_face/custom_widgets/chart/line_chart.dart';

import '../../../constants.dart';
import '../../../custom_widgets/drawer/drawer.dart';
import '../../../custom_widgets/ticket/detail_ticket_text.dart';
import '../../../custom_widgets/ticket/ticket_text.dart';

class DetailedAlertScreen extends StatefulWidget {
  const DetailedAlertScreen({Key? key}) : super(key: key);

  @override
  State<DetailedAlertScreen> createState() => _DetailedAlertScreenState();
}

class _DetailedAlertScreenState extends State<DetailedAlertScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const MyDrawer(),
      appBar: AppBar(
        backgroundColor: AppConstants.primaryColor,
        centerTitle: true,
        title: const Text("Alerts"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          const SizedBox(height: 30),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
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
                    icon: SvgPicture.asset('assets/svg/clock.svg', height: 20),
                    label: " Active Since:",
                    value: "17 Min",
                    valueStyle: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).primaryColor),
                  ),
                  Container(
                    height: 35,
                    width: MediaQuery.of(context).size.width / 1.4,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(18),
                        color: Colors.greenAccent),
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
            ],
          ),
          const SizedBox(height: 10),
          Container(
            margin: const EdgeInsets.all(10),
            child: const CustomLineChart(),
          ),
          const SizedBox(height: 10),
          Column(
            children: [
              DetailedTicketText(
                color: Colors.grey.shade200,
                label: "Asset ID:",
                value: "HF567234",
              ),
              const DetailedTicketText(
                label: "Type:",
                value: "Horizontal Freezer",
              ),
              DetailedTicketText(
                color: Colors.grey.shade200,
                label: "Triggered By:",
                value: "Group G1",
              ),
              const DetailedTicketText(
                label: "Floor Supervisor:",
                value: "Jeffery",
              ),
              DetailedTicketText(
                color: Colors.grey.shade200,
                label: "Alert Status:",
                value: "Active",
              ),
            ],
          )
        ],
      ),
    );
  }
}
