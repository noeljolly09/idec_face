import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:idec_face/constants.dart';
import 'package:idec_face/custom_widgets/search_bar.dart';
import 'package:idec_face/dialogs/info_dialog/dialog_with_timer.dart';
import 'package:idec_face/models/people_profile/all_employees_request.dart';
import 'package:idec_face/models/people_profile/all_employees_response.dart';
import 'package:idec_face/network/core/service_response.dart';
import 'package:idec_face/repository/people_profile/providers/people_profile_notifier_provider.dart';
import 'package:idec_face/screens/login/notifier/login_notifiers.dart';
import 'package:idec_face/screens/people_profile/detail_profile_page.dart';
import 'package:idec_face/screens/people_profile/models/employee_data_model.dart';
import 'package:idec_face/screens/people_profile/notifiers/people_profile_notfier.dart';

import 'package:idec_face/screens/people_profile/widgets/people_profile/employee_profile_card.dart';

import 'package:idec_face/utility/connectivity/connectivity_constants.dart';
import 'package:idec_face/utility/connectivity/connectivity_notifier_provider.dart';
import 'package:intl/intl.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../utility/shared_pref/provider/shared_pref_provider.dart';

class PendingEmployeePage extends ConsumerStatefulWidget {
  const PendingEmployeePage({Key? key}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends ConsumerState<PendingEmployeePage> {
  String currentDate = DateFormat.MMMMd().format(DateTime.now());
  String currentTime = DateFormat.jm().format(DateTime.now());

  TextEditingController employeeNameController = TextEditingController();
  static const timestyle = TextStyle(fontSize: 10);
  final _refreshController = RefreshController();
  int _currentPage = 1;
  List<EmployeeDetailsFetchedFromApi> pendingEmployeeDetails = [];
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      ref.read(peopleProfileNotifier).updateEmpFilterStatus(value: false);
      _getAllEmployeesDetails();
    });
  }

  @override
  void dispose() {
    employeeNameController.dispose();
    _refreshController.dispose();
    super.dispose();
  }

  void _getAllEmployeesDetails() {
    final response = ref.read(sharedPrefUtilityProvider).getLoggedInUser()!;

    final tenantId = response.response!.first.tenants!.id;
    final allEmployeesListRequest = AllEmployeesListRequest(
      siteId: null,
      gamificationStatus: false,
      contractorId: null,
      tradeId: null,
      roleId: null,
      unallocated: null,
      direct: false,
      tabType: "pending",
      liveVideoStream: false,
      empName: employeeNameController.text.isEmpty
          ? null
          : employeeNameController.text,
    );

    ref.read(peopleProfileNotifierProvider.notifier).allEmployeesListAttributes(
          allEmployeesListRequest,
          tenantId!,
          pageNumber: _currentPage,
        );
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
        child: WillPopScope(
          onWillPop: () async {
            _currentPage = 1;
            pendingEmployeeDetails = [];
            ref
                .read(peopleProfileNotifier)
                .updatelistOfPendingEmployees(value: []);
            return true;
          },
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
                  child: SearchInput(
                    labelText: 'Employee',
                    controller: employeeNameController,
                    onTap: () {
                      _currentPage = 1;
                      ref
                          .read(peopleProfileNotifier)
                          .updateEmpFilterStatus(value: true);
                      pendingEmployeeDetails = [];
                      ref
                          .read(peopleProfileNotifier)
                          .updatelistOfPendingEmployees(value: []);
                      FocusScope.of(context).unfocus();
                      _getAllEmployeesDetails();
                    },
                    onClear: () {
                      _currentPage = 1;
                      ref
                          .read(peopleProfileNotifier)
                          .updateEmpFilterStatus(value: false);
                      employeeNameController.clear();
                      FocusScope.of(context).unfocus();
                      _getAllEmployeesDetails();
                    },
                  ),
                ),
                Expanded(
                  flex: 5,
                  child: Scrollbar(
                    thickness: 10,
                    interactive: true,
                    child: SmartRefresher(
                      controller: _refreshController,
                      enablePullDown: true,
                      enablePullUp: true,
                      onRefresh: () {
                        _currentPage = 1;
                        _getAllEmployeesDetails();
                        pendingEmployeeDetails = [];
                        ref
                            .read(peopleProfileNotifier)
                            .updatelistOfPendingEmployees(value: []);
                      },
                      onLoading: () {
                        _getAllEmployeesDetails();
                      },
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
                                      builder: (context) =>
                                          DetailedProfileScreen(
                                              employeeStatus: "pending",
                                              employeeIndex: index),
                                    ));
                              },
                              child: Slidable(
                                key: ValueKey(index),
                                endActionPane: ActionPane(
                                  extentRatio: 0.35,
                                  motion: const ScrollMotion(),
                                  children: [
                                    SlidableAction(
                                      // An action can be bigger than the others.
                                      flex: 2,
                                      onPressed: (context) {
                                        doNothing(context,
                                            "Approval Procedure on Progress");
                                      },
                                      backgroundColor: Colors.greenAccent,
                                      foregroundColor: Colors.black,

                                      label: 'Approve \nEmployee',
                                    ),
                                  ],
                                ),
                                child: EmployeeCard(
                                  image: _employeeList[index].image,
                                  employeeName: _employeeList[index].fullName!,
                                  employeeId: _employeeList[index].empId!,
                                  siteName:
                                      _employeeList[index].siteName != null
                                          ? _employeeList[index].siteName!
                                          : "Trivandrum",
                                  index: index,
                                ),
                              ),
                            ));
                          }),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  initPeopleProfileListeners(ConnectionStatus networkStatus) {
    ref.listen(peopleProfileNotifierProvider, (previous, next) {
      final peopleProfileInfoResponse =
          next as ServiceResponse<AllEmployeesListResponse?>;
      if (peopleProfileInfoResponse.status == ServiceStatus.completed) {
        _refreshController.refreshCompleted();

        if (peopleProfileInfoResponse.data!.status) {
          if (peopleProfileInfoResponse.data!.response!.isNotEmpty) {
            _refreshController.loadComplete();
            _currentPage += 1;
            for (var element in peopleProfileInfoResponse.data!.response!) {
              pendingEmployeeDetails.add(EmployeeDetailsFetchedFromApi(
                empId: element.empId,
                email: element.email,
                image: element.image,
                fullName: element.fullName,
                bloodGroup: element.personal == null
                    ? null
                    : element.personal!.bloodGroup,
                countryCode: element.phone!.countryCode,
                dob: element.personal == null ? null : element.personal!.dob,
                gender:
                    element.personal == null ? null : element.personal!.gender,
                nationality: element.personal == null
                    ? null
                    : element.personal!.nationality,
                phoneNumber:
                    element.phone == null ? null : element.phone!.number,
                siteName: element.siteName,
              ));
            }
            ref
                .read(peopleProfileNotifier)
                .updatelistOfPendingEmployees(value: pendingEmployeeDetails);
          } else {
            _refreshController.loadNoData();
          }
        } else {
          _refreshController.loadFailed();
        }
      } else if (peopleProfileInfoResponse.status == ServiceStatus.error) {
        _refreshController.loadFailed();
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

  void doNothing(BuildContext context, String text) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(SnackBar(content: Text(text)));
  }
}

void showSnackBar(BuildContext context, String text) {
  ScaffoldMessenger.of(context)
    ..hideCurrentSnackBar()
    ..showSnackBar(SnackBar(content: Text(text)));
}
