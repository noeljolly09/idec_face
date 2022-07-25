import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:idec_face/constants.dart';
import 'package:idec_face/custom_widgets/custom_appbar.dart';
import 'package:idec_face/custom_widgets/search_bar.dart';
import 'package:idec_face/dialogs/info_dialog/dialog_with_timer.dart';
import 'package:idec_face/dialogs/profile_dialog.dart';
import 'package:idec_face/models/people_profile/all_employees_request.dart';
import 'package:idec_face/models/people_profile/all_employees_response.dart';
import 'package:idec_face/network/core/service_constants/service_constants.dart';
import 'package:idec_face/network/core/service_response.dart';
import 'package:idec_face/repository/people_profile/providers/people_profile_notifier_provider.dart';

import 'package:idec_face/screens/people_profile/detail_profile_page.dart';
import 'package:idec_face/screens/people_profile/notifiers/people_profile_notfier.dart';

import 'package:idec_face/screens/people_profile/widgets/people_profile/employee_profile_card.dart';

import 'package:idec_face/utility/connectivity/connectivity_constants.dart';
import 'package:idec_face/utility/connectivity/connectivity_notifier_provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import '../../models/password_reset/password_reset_request.dart';
import '../../models/password_reset/password_reset_response.dart';
import '../../repository/password_reset_repository/providers/password_reset_notifier_provider.dart';
import '../../utility/shared_pref/provider/shared_pref_provider.dart';

class EnrolledEmployeePage extends ConsumerStatefulWidget {
  const EnrolledEmployeePage({Key? key}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends ConsumerState<EnrolledEmployeePage> {
  //
  TextEditingController employeeNameController = TextEditingController();
  //
  final _refreshController = RefreshController();
  //
  int _currentPage = 1;
  //
  List<UserData> employeeDetails = [];
  //
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
      tabType: "accept",
    );
    ref.read(peopleProfileNotifierProvider.notifier).allEmployeesListAttributes(
          allEmployeesListRequest,
          tenantId!,
          pageNumber: _currentPage,
        );
  }

  void _getPasswordResetAttributes({String? username}) {
    var passwordResetRequest = PasswordResetRequest();
    final response =
        ref.read(sharedPrefUtilityProvider).getLoggedInPriviledgeUserDetails()!;
    passwordResetRequest = PasswordResetRequest(
      userName: username,
    );

    ref.read(passwordResetNotifierProvider.notifier).getPasswordResetAttributes(
          passwordResetRequest,
          response.response!.data!.first.tenants!.id,
        );
  }

  @override
  Widget build(BuildContext context) {
    final networkStatus = ref.read(connectivityNotifierProvider).status;
    initPeopleProfileListeners(networkStatus);
    initResetPasswordListeners(networkStatus);
    List<UserData> _employeeList =
        ref.watch(peopleProfileNotifier).listOfAllEmployees;

    return SafeArea(
      child: DefaultTabController(
        length: 3,
        child: WillPopScope(
          onWillPop: () async {
            _currentPage = 1;
            employeeDetails = [];
            ref.read(peopleProfileNotifier).updatelistOfAllEmployees(value: []);
            return true;
          },
          child: Scaffold(
            resizeToAvoidBottomInset: false,
            appBar: customAppBar("Enrolled"),
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
                      employeeDetails = [];
                      ref
                          .read(peopleProfileNotifier)
                          .updatelistOfAllEmployees(value: []);
                      ref
                          .read(peopleProfileNotifier)
                          .updateEmpFilterStatus(value: true);
                      FocusScope.of(context).unfocus();
                      _getAllEmployeesDetails();
                    },
                    onClear: () {
                      _currentPage = 1;
                      employeeDetails = [];
                      ref
                          .read(peopleProfileNotifier)
                          .updatelistOfAllEmployees(value: []);
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
                        employeeDetails = [];
                        _getAllEmployeesDetails();
                        ref
                            .read(peopleProfileNotifier)
                            .updatelistOfAllEmployees(value: []);
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
                                                employeeStatus: "enrolled",
                                                employeeIndex: index),
                                      ));
                                },
                                child: Slidable(
                                  key: ValueKey(index),
                                  endActionPane: ActionPane(
                                    extentRatio: 0.35,
                                    motion: const ScrollMotion(),
                                    children: [
                                      _employeeList[index].credentials!.isEmpty
                                          ? SlidableAction(
                                              flex: 2,
                                              onPressed: (context) {
                                                openMappingDialog(context,
                                                    "Generate User Credentials",
                                                    isAvailableNeeded: false);
                                              },
                                              backgroundColor:
                                                  Colors.greenAccent,
                                              foregroundColor: Colors.black,
                                              label:
                                                  'Generate \n User\n Credentials',
                                            )
                                          : SlidableAction(
                                              flex: 2,
                                              onPressed: (context) {
                                                showDialog(
                                                  context: context,
                                                  barrierDismissible: false,
                                                  builder: (context) =>
                                                      InfoDialogWithTimer(
                                                    isTimerActivated: true,
                                                    isCancelButtonVisible: true,
                                                    bttnText1: "Yes",
                                                    bttnText2: "No",
                                                    afterSuccess: () {},
                                                    onPressedBttn2: () {
                                                      Navigator.pop(context);
                                                    },
                                                    onPressedBttn1: () {
                                                      _getPasswordResetAttributes(
                                                          username:
                                                              _employeeList[
                                                                      index]
                                                                  .credentials!
                                                                  .first
                                                                  .userName);
                                                    },
                                                    title: "Reset password",
                                                    message:
                                                        "Do you want to reset password",
                                                  ),
                                                );
                                              },
                                              backgroundColor:
                                                  Colors.greenAccent,
                                              foregroundColor: Colors.black,
                                              label: 'Reset password',
                                            ),
                                    ],
                                  ),
                                  child: EmployeeCard(
                                    image: _employeeList[index].image,
                                    employeeName:
                                        _employeeList[index].fullName!,
                                    employeeId: _employeeList[index].empId,
                                    siteName:
                                        _employeeList[index].siteName != null
                                            ? _employeeList[index].siteName!
                                            : "Trivandrum",
                                    index: index,
                                    state: "accept",
                                  ),
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

  initResetPasswordListeners(ConnectionStatus networkStatus) {
    ref.listen(passwordResetNotifierProvider, (previous, next) {
      final passwordResetResponse =
          next as ServiceResponse<PasswordResetResponse?>;
      if (passwordResetResponse.status == ServiceStatus.loading) {
        showDialog(
            context: context,
            builder: (context) => const Center(
                  child: SpinKitCircle(
                    color: AppConstants.primaryColor,
                  ),
                ));
      } else if (passwordResetResponse.status == ServiceStatus.completed) {
        Navigator.pop(context);
        if (passwordResetResponse.data!.status == true) {
          showDialog(
            context: context,
            barrierDismissible: false,
            builder: (context) => InfoDialogWithTimer(
              isTimerActivated: true,
              isCancelButtonVisible: false,
              title: "Password Reset",
              afterSuccess: () {
                Navigator.pushNamedAndRemoveUntil(
                    context, '/login', (route) => false);
              },
              onPressedBttn1: () {
                Navigator.pushNamedAndRemoveUntil(
                    context, '/login', (route) => false);
              },
              message: passwordResetResponse.data!.response!.message.toString(),
            ),
          );
        } else {
          showDialog(
            context: context,
            barrierDismissible: false,
            builder: (context) => InfoDialogWithTimer(
              isTimerActivated: true,
              isCancelButtonVisible: false,
              title: "Password Reset Error",
              afterSuccess: () {},
              onPressedBttn1: () {
                Navigator.pop(context);
              },
              message: passwordResetResponse.data!.response!.message.toString(),
            ),
          );
        }
      }
    });
  }

  initPeopleProfileListeners(ConnectionStatus networkStatus) {
    ref.listen(peopleProfileNotifierProvider, (previous, next) {
      final peopleProfileInfoResponse =
          next as ServiceResponse<EmployeeResponse?>;

      if (peopleProfileInfoResponse.status == ServiceStatus.loading) {
        showDialog(
            context: context,
            builder: (context) => const SpinKitCircle(
                  color: AppConstants.primaryColor,
                ));
      } else if (peopleProfileInfoResponse.status == ServiceStatus.completed) {
        Navigator.pop(context);
        _refreshController.refreshCompleted();
        if (peopleProfileInfoResponse.data!.status!) {
          if (peopleProfileInfoResponse.data!.response!.data!.isNotEmpty) {
            _refreshController.loadComplete();
            _currentPage += 1;
            var responseData = peopleProfileInfoResponse.data!.response!.data!;
            for (var element in responseData) {
              employeeDetails.add(element);
            }

            ref
                .read(peopleProfileNotifier)
                .updatelistOfAllEmployees(value: employeeDetails);
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
              message: "Something went wrong",
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
}

void showSnackBar(BuildContext context, String text) {
  ScaffoldMessenger.of(context)
    ..hideCurrentSnackBar()
    ..showSnackBar(SnackBar(content: Text(text)));
}
