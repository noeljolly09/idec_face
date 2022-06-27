import 'package:drop_down_list/drop_down_list.dart';
import 'package:flutter/material.dart';
import 'package:idec_face/custom_widgets/custom_selection.dart';
import 'package:idec_face/dialogs/info_dialog/dialog_with_timer.dart';
import 'package:idec_face/screens/people_profile/custom_widgets/people_profile/employee_profile_card.dart';
import 'package:idec_face/screens/people_profile/detail_profile_page.dart';

class EnrolledPage extends StatefulWidget {
  const EnrolledPage({Key? key}) : super(key: key);

  @override
  State<EnrolledPage> createState() => _EnrolledPageState();
}

class _EnrolledPageState extends State<EnrolledPage> {
  final List<SelectedListItem> _listOfEmployees = [
    SelectedListItem(true, "A"),
    SelectedListItem(false, "B"),
    SelectedListItem(false, "C"),
    SelectedListItem(false, "D"),
    SelectedListItem(false, "E"),
    SelectedListItem(false, "F"),
    SelectedListItem(false, "G"),
    SelectedListItem(false, "H"),
  ];

  final TextEditingController _storetextController = TextEditingController();

  final TextEditingController _searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            margin: const EdgeInsets.all(5),
            child: CustomSelectionBar(
              isConfigreceived: false,
              isCircleSuffixIcon: true,
              isCircleSearchIcon: true,
              isSvg: false,
              svgAsset: "",
              width: MediaQuery.of(context).size.width,
              list: _listOfEmployees,
              hinttext: "Search Employee",
              searchhinttext: "Search Employee",
              sheetTitle: "Search Employee",
              controller: _storetextController,
              searchController: _searchController,
            ),
          ),
          Expanded(
            child: Scrollbar(
              thickness: 10,
              interactive: true,
              child: ListView.builder(
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  // itemCount:_addCard,
                  // itemCount: items.length,
                  itemCount: 20,
                  itemBuilder: (context, index) {
                    return SingleChildScrollView(
                      child: InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    const DetailedProfileScreen(),
                              ));
                        },
                        child: Dismissible(
                          key: ValueKey(index),
                          background: Container(
                            color: Colors.greenAccent,
                            child: const Align(
                                alignment: Alignment.centerRight,
                                child: Text("Generate  User \n Credentials ",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold))),
                          ),
                          direction: DismissDirection.endToStart,
                          confirmDismiss: (DismissDirection direction) {
                            return showDialog(
                              context: context,
                              barrierDismissible: false,
                              builder: (context) => InfoDialogWithTimer(
                                title: "Generate User Credentials",
                                message:
                                    "Email is Mandatory for user credentials creation.",
                                isTimerActivated: true,
                                isCancelButtonVisible: false,
                                onPressedBttn1: () {
                                  Navigator.of(context).pop(false);
                                },
                              ),
                            );
                          },
                          child: EmployeeCard(
                            index: index,
                          ),
                        ),
                      ),
                    );
                  }),
            ),
          ),
        ],
      ),
    );
  }
}
