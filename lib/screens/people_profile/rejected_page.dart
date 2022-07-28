import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:idec_face/custom_widgets/custom_appbar.dart';
import 'package:idec_face/custom_widgets/search_bar.dart';
import 'package:idec_face/dialogs/info_dialog/dialog_with_timer.dart';
import 'package:idec_face/dialogs/loader_dialog.dart';
import 'package:idec_face/models/people_profile/all_employees_request.dart';
import 'package:idec_face/models/people_profile/all_employees_response.dart';
import 'package:idec_face/network/core/service_constants/service_constants.dart';
import 'package:idec_face/network/core/service_response.dart';
import 'package:idec_face/repository/people_profile/providers/people_profile_notifier_provider.dart';
import 'package:idec_face/screens/people_profile/approval_page.dart';
import 'package:idec_face/screens/people_profile/notifiers/people_profile_notfier.dart';

import 'package:idec_face/screens/people_profile/widgets/people_profile/employee_profile_card.dart';

import 'package:idec_face/utility/connectivity/connectivity_constants.dart';
import 'package:idec_face/utility/connectivity/connectivity_notifier_provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../utility/shared_pref/provider/shared_pref_provider.dart';

class RejectedEmployeePage extends ConsumerStatefulWidget {
  const RejectedEmployeePage({Key? key}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends ConsumerState<RejectedEmployeePage> {
//

  TextEditingController employeeNameController = TextEditingController();

  final _refreshController = RefreshController();
  int _currentPage = 1;
  List<UserData> rejectedEmployeeDetails = [];
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
    final response =
        ref.read(sharedPrefUtilityProvider).getLoggedInPriviledgeUserDetails()!;
    final tenantId = response.response!.data!.first.tenants!.id;
    final allEmployeesListRequest = EmployeeRequest(
      tabType: "rejected",
      searchKey: employeeNameController.text.isEmpty
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

    List<UserData> _employeeList =
        ref.watch(peopleProfileNotifier).listOfRejectedEmployees;
    //
    return SafeArea(
      child: DefaultTabController(
        length: 3,
        child: WillPopScope(
          onWillPop: () async {
            _currentPage = 1;
            rejectedEmployeeDetails = [];
            ref
                .read(peopleProfileNotifier)
                .updatelistOfRejectedEmployees(value: []);
            return true;
          },
          child: Scaffold(
            resizeToAvoidBottomInset: false,
            appBar: customAppBar(context,"Rejected"),
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            body:
                // first tab bar view widget
                Column(
              children: [
                Container(
                  margin: const EdgeInsets.all(20),
                  color: Colors.white,
                  child: SearchInput(
                    labelText: 'Employee',
                    controller: employeeNameController,
                    onTap: () {
                      _currentPage = 1;
                      ref
                          .read(peopleProfileNotifier)
                          .updateEmpFilterStatus(value: true);
                      rejectedEmployeeDetails = [];
                      ref
                          .read(peopleProfileNotifier)
                          .updatelistOfRejectedEmployees(value: []);
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
                        rejectedEmployeeDetails = [];
                        ref
                            .read(peopleProfileNotifier)
                            .updatelistOfRejectedEmployees(value: []);
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
                                onTap: () async {
                                  bool? status = await Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            ProfileApprovalPage(
                                          empList: _employeeList,
                                          employeeIndex: index,
                                          state: "reject",
                                        ),
                                      ));
                                  if (status != null) {
                                    if (status) {
                                      showDialog(
                                        context: context,
                                        barrierDismissible: false,
                                        builder: (context) =>
                                            InfoDialogWithTimer(
                                          isTimerActivated: true,
                                          isCancelButtonVisible: false,
                                          afterSuccess: () {},
                                          onPressedBttn1: () {
                                            Navigator.of(context).pop();
                                          },
                                          title: "Success",
                                          message:
                                              "Profile updated successfully",
                                        ),
                                      );
                                      _currentPage = 1;
                                      _getAllEmployeesDetails();
                                      rejectedEmployeeDetails = [];
                                      ref
                                          .read(peopleProfileNotifier)
                                          .updatelistOfRejectedEmployees(
                                              value: []);
                                    }
                                  }
                                },
                                child: EmployeeCard(
                                  emailId: _employeeList[index].email,
                                  image: _employeeList[index].image,
                                  employeeName: _employeeList[index].name!,
                                  employeeId: _employeeList[index].empId,
                                  siteName:
                                      _employeeList[index].siteName != null
                                          ? _employeeList[index].siteName!
                                          : "",
                                  index: index,
                                  state: "reject",
                                ),
                              ),
                            );
                          }),
                    ),
                  ),
                ),
              ],
            ),
            // second tab bar viiew widget
          ),
        ),
      ),
    );
  }

  initPeopleProfileListeners(ConnectionStatus networkStatus) {
    ref.listen(peopleProfileNotifierProvider, (previous, next) {
      final peopleProfileInfoResponse =
          next as ServiceResponse<EmployeeResponse?>;

      if (peopleProfileInfoResponse.status == ServiceStatus.loading) {
        customLoaderDialog(context);
      } else if (peopleProfileInfoResponse.status == ServiceStatus.completed) {
        Navigator.pop(context);
        _refreshController.refreshCompleted();
        if (peopleProfileInfoResponse.data!.status!) {
          if (peopleProfileInfoResponse.data!.response!.data!.isNotEmpty) {
            _refreshController.loadComplete();
            _currentPage += 1;
            var responseData = peopleProfileInfoResponse.data!.response!.data!;
            for (var element in responseData) {
              rejectedEmployeeDetails.add(element);
            }

            ref
                .read(peopleProfileNotifier)
                .updatelistOfRejectedEmployees(value: rejectedEmployeeDetails);
          } else {
            _refreshController.loadNoData();
          }
        } else {
          _refreshController.loadFailed();
        }
      } else if (peopleProfileInfoResponse.status == ServiceStatus.error) {
        _refreshController.loadFailed();
        Navigator.of(context).pop(false);
        if (peopleProfileInfoResponse.errorCode ==
            ServiceErrorCode.unauthorized) {
          //
          ref.read(sharedPrefUtilityProvider).resetPreference();
          //
          showDialog(
            context: context,
            barrierDismissible: false,
            builder: (context) => InfoDialogWithTimer(
              isTimerActivated: true,
              isCancelButtonVisible: false,
              afterSuccess: () {
                Navigator.pushNamedAndRemoveUntil(
                    context, "/login", (route) => false);
              },
              onPressedBttn1: () {
                Navigator.pushNamedAndRemoveUntil(
                    context, "/login", (route) => false);
              },
              title: "Error",
              message: "Session Expired",
            ),
          );
        } else if (networkStatus == ConnectionStatus.offline) {
          showDialog(
            context: context,
            barrierDismissible: false,
            builder: (context) => InfoDialogWithTimer(
              isTimerActivated: true,
              isCancelButtonVisible: false,
              afterSuccess: () {},
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
              afterSuccess: () {},
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

  void showSnackBar(BuildContext context, String text) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(SnackBar(content: Text(text)));
  }
}
