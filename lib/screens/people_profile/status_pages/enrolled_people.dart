import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:idec_face/dialogs/info_dialog/dialog_with_timer.dart';
import 'package:idec_face/screens/people_profile/models/employee_data_model.dart';
import 'package:idec_face/screens/people_profile/notifiers/people_profile_notfier.dart';
import 'package:idec_face/screens/people_profile/widgets/people_profile/employee_profile_card.dart';
import 'package:idec_face/screens/people_profile/detail_profile_page.dart';

import '../../../custom_widgets/search_bar.dart';

class EnrolledPage extends ConsumerStatefulWidget {
  const EnrolledPage({Key? key}) : super(key: key);

  @override
  _EnrolledPageState createState() => _EnrolledPageState();
}

class _EnrolledPageState extends ConsumerState<EnrolledPage> {
  @override
  Widget build(BuildContext context) {
    //

    List<EmployeeDetailsFetchedFromApi> _employeeList =
        ref.watch(peopleProfileNotifier).listOfEmployeeNames;

    return Column(
      children: [
        Container(
          margin: const EdgeInsets.all(5),
          color: Colors.white,
          child: const SearchInput(labelText: 'Employee'),
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
                itemCount: _employeeList.length,
                itemBuilder: (context, index) {
                  return SingleChildScrollView(
                    child: InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  DetailedProfileScreen(employeeIndex: index),
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
                                  style:
                                      TextStyle(fontWeight: FontWeight.bold))),
                        ),
                        direction: DismissDirection.endToStart,
                        confirmDismiss: (DismissDirection direction) {
                          return showDialog(
                            context: context,
                            barrierDismissible: false,
                            builder: (context) => InfoDialogWithTimer(
                              title: "Generate User \n Credentials",
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
                          employeeName: _employeeList[index].fullName!,
                          employeeId: _employeeList[index].empId!,
                          index: index,
                        ),
                      ),
                    ),
                  );
                }),
          ),
        ),
      ],
    );
  }
}
