import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:idec_face/constants.dart';
import 'package:idec_face/custom_widgets/search_bar.dart';
import 'package:idec_face/dialogs/info_dialog/dialog_with_timer.dart';
import 'package:idec_face/dialogs/profile_dialog.dart';
import 'package:idec_face/models/people_profile/all_employees_request.dart';
import 'package:idec_face/models/people_profile/all_employees_response.dart';
import 'package:idec_face/network/core/service_response.dart';
import 'package:idec_face/repositary/people_profile/providers/people_profile_notifier_provider.dart';
import 'package:idec_face/screens/login/notifier/login_notifiers.dart';
import 'package:idec_face/screens/people_profile/detail_profile_page.dart';
import 'package:idec_face/screens/people_profile/models/employee_data_model.dart';
import 'package:idec_face/screens/people_profile/notifiers/people_profile_notfier.dart';

import 'package:idec_face/screens/people_profile/widgets/people_profile/employee_profile_card.dart';

import 'package:idec_face/utility/connectivity/connectivity_constants.dart';
import 'package:idec_face/utility/connectivity/connectivity_notifier_provider.dart';
import 'package:intl/intl.dart';

class PendingEmployeePage extends ConsumerStatefulWidget {
  const PendingEmployeePage({Key? key}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends ConsumerState<PendingEmployeePage> {
  String currentDate = DateFormat.MMMMd().format(DateTime.now());
  String currentTime = DateFormat.jm().format(DateTime.now());

  static const timestyle = TextStyle(fontSize: 10);

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _getAllEmployeesDetails();
    });
  }

  void _getAllEmployeesDetails() {
    final allEmployeesListRequest = AllEmployeesListRequest(
        siteId: null,
        gamificationStatus: false,
        contractorId: null,
        tradeId: null,
        roleId: null,
        unallocated: null,
        direct: false,
        tabType: "pending",
        liveVideoStream: false);

    ref.read(peopleProfileNotifierProvider.notifier).allEmployeesListAttributes(
        allEmployeesListRequest, ref.watch(loginNotifier).tenantId.toString());
  }

  @override
  Widget build(BuildContext context) {
    //
    final networkStatus = ref.read(connectivityNotifierProvider).status;
    initPeopleProfileListeners(networkStatus);

    List<EmployeeDetailsFetchedFromApi> _employeeList =
        ref.watch(peopleProfileNotifier).listOfPendingEmployees;
    //
    return SafeArea(
      child: DefaultTabController(
        length: 3,
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          appBar: AppBar(
            backgroundColor: AppConstants.primaryColor,
            title: const Text('Pending Employees'),
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
                            fontFamily: AppConstants.forNumbersFont,
                            fontSize: 10),
                      ),
                      const Text(
                        ',',
                        style: timestyle,
                      ),
                      Text(
                        currentTime,
                        style: TextStyle(
                            fontFamily: AppConstants.forNumbersFont,
                            fontSize: 10),
                      ),
                    ],
                  ))
            ],
          ),
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          body:
              // first tab bar view widget
              Column(
            children: [
              Container(
                margin: const EdgeInsets.all(15),
                color: Colors.white,
                child: const SearchInput(labelText: 'Employee'),
              ),
              Expanded(
                flex: 5,
                child: Scrollbar(
                  thickness: 10,
                  interactive: true,
                  child: ListView.builder(
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      itemCount: _employeeList.length,
                      itemBuilder: (context, index) {
                        return SingleChildScrollView(
                          child: InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => DetailedProfileScreen(
                                        employeeIndex: index),
                                  ));
                            },
                            child: Slidable(
                              key: ValueKey(index),
                              // startActionPane: ActionPane(
                              //   // A motion is a widget used to control how the pane animates.
                              //   motion: const ScrollMotion(),

                              //   // A pane can dismiss the Slidable.
                              //   dismissible:
                              //       DismissiblePane(onDismissed: () {}),

                              //   // All actions are defined in the children parameter.
                              //   children: [
                              //     // A SlidableAction can have an icon and/or a label.
                              //     SlidableAction(
                              //       onPressed: openMappingDialog(
                              //           context, "Generate User Credentials"),
                              //       backgroundColor: const Color(0xFFFE4A49),
                              //       foregroundColor: Colors.white,
                              //       icon: Icons.delete,
                              //       label: 'Delete',
                              //     ),
                              //   ],
                              // ),
                              endActionPane: ActionPane(
                                extentRatio: 0.35,
                                motion: const ScrollMotion(),
                                children: [
                                  SlidableAction(
                                    // An action can be bigger than the others.
                                    flex: 2,
                                    onPressed: (context) {
                                      openMappingDialog(
                                          context, "Generate User Credentials",
                                          isAvailableNeeded: false);
                                    },
                                    backgroundColor: Colors.greenAccent,
                                    foregroundColor: Colors.black,

                                    label: 'Generate \n User\n Credentials',
                                  ),
                                ],
                              ),

                              child: EmployeeCard(
                                employeeName: _employeeList[index].fullName!,
                                employeeId: _employeeList[index].empId!,
                                siteName: _employeeList[index].siteName != null
                                    ? _employeeList[index].siteName!
                                    : "Trivandrum",
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
          // second tab bar viiew widget
        ),
      ),
    );
  }

  initPeopleProfileListeners(ConnectionStatus networkStatus) {
    ref.listen(peopleProfileNotifierProvider, (previous, next) {
      final peopleProfileInfoResponse =
          next as ServiceResponse<AllEmployeesListResponse?>;
      if (peopleProfileInfoResponse.status == ServiceStatus.loading) {
        showDialog(
            context: context,
            builder: (context) => const Center(
                  child: SpinKitCircle(
                    color: AppConstants.primaryColor,
                  ),
                ));
      } else if (peopleProfileInfoResponse.status == ServiceStatus.completed) {
        Navigator.pop(context);

        List<EmployeeDetailsFetchedFromApi> pendingEmployeeDetails = [];

        if (peopleProfileInfoResponse.data!.response!.isNotEmpty) {
          for (var element in peopleProfileInfoResponse.data!.response!) {
            pendingEmployeeDetails.add(EmployeeDetailsFetchedFromApi(
              empId: element.empId,
              email: element.email,
              fullName: element.fullName,
              // bloodGroup: element.personal!.bloodGroup,
              countryCode: element.phone!.countryCode,
              // dob: element.personal!.dob,
              // gender: element.personal!.gender,
              // nationality: element.personal!.nationality,
              phoneNumber: element.phone!.number,
              siteName: element.siteName,
            ));
          }

          ref
              .read(peopleProfileNotifier)
              .updatelistOfPendingEmployees(value: pendingEmployeeDetails);
        }
      } else if (peopleProfileInfoResponse.status == ServiceStatus.error) {
        Navigator.pop(context);
        if (networkStatus == ConnectionStatus.offline) {
          showDialog(
            context: context,
            barrierDismissible: false,
            builder: (context) => InfoDialogWithTimer(
              isTimerActivated: true,
              isCancelButtonVisible: false,
              afterSuccess: () {
                Navigator.pop(context);
              },
              onPressedBttn1: () {
                Navigator.of(context).pop(false);
              },
              title: "Error",
              message: "No Internet Connectivity",
            ),
          );
        } else {
          showDialog(
            context: context,
            barrierDismissible: false,
            builder: (context) => InfoDialogWithTimer(
              isTimerActivated: true,
              isCancelButtonVisible: false,
              afterSuccess: () {
                Navigator.pop(context);
              },
              onPressedBttn1: () {
                Navigator.of(context).pop(false);
              },
              title: "Error",
              message: "Something went wrong",
            ),
          );
        }
      }
    });
  }

  void doNothing(BuildContext context) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(const SnackBar(content: Text('hello')));
  }
}

void showSnackBar(BuildContext context, String text) {
  ScaffoldMessenger.of(context)
    ..hideCurrentSnackBar()
    ..showSnackBar(SnackBar(content: Text(text)));
}
