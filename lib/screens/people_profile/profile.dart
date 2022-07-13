import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:idec_face/constants.dart';
import 'package:idec_face/dialogs/info_dialog/dialog_with_timer.dart';
import 'package:idec_face/models/people_profile/all_employees_request.dart';
import 'package:idec_face/models/people_profile/all_employees_response.dart';
import 'package:idec_face/network/core/service_response.dart';
import 'package:idec_face/repositary/people_profile/providers/people_profile_notifier_provider.dart';
import 'package:idec_face/screens/people_profile/models/employee_data_model.dart';
import 'package:idec_face/screens/people_profile/notifiers/people_profile_notfier.dart';
import 'package:idec_face/screens/people_profile/status_pages/declined_page.dart';
import 'package:idec_face/screens/people_profile/status_pages/enrolled_people.dart';
import 'package:idec_face/screens/people_profile/status_pages/pending_people.dart';
import 'package:idec_face/utility/connectivity/connectivity_constants.dart';
import 'package:idec_face/utility/connectivity/connectivity_notifier_provider.dart';
import 'package:intl/intl.dart';

class ProfilePage extends ConsumerStatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends ConsumerState<ProfilePage> {
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
        tabType: "active",
        liveVideoStream: false);

    ref.read(peopleProfileNotifierProvider.notifier).allEmployeesListAttributes(
        allEmployeesListRequest, "5df380f38baa86fc4ae24264");
  }

  @override
  Widget build(BuildContext context) {
    //
    final networkStatus = ref.read(connectivityNotifierProvider).status;
    initPeopleProfileListeners(networkStatus);
    //
    return SafeArea(
      child: DefaultTabController(
        length: 3,
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          appBar: AppBar(
            backgroundColor: AppConstants.primaryColor,
            title: const Text('Employees'),
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
                        style: timestyle,
                      ),
                      const Text(
                        ',',
                        style: timestyle,
                      ),
                      Text(
                        currentTime,
                        style: timestyle,
                      ),
                    ],
                  ))
            ],
          ),
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          body: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: TabBar(
                  unselectedLabelColor: Colors.black,
                  labelColor: AppConstants.primaryColor,
                  tabs: [
                    Tab(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SvgPicture.asset(
                            'assets/svg/enrolled.svg',
                            height: 20,
                          ),
                          const SizedBox(width: 5),
                          const Text(
                            "Enrolled",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 17),
                          ),
                        ],
                      ),
                    ),
                    Tab(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SvgPicture.asset(
                            'assets/svg/pending.svg',
                            height: 20,
                          ),
                          const SizedBox(width: 5),
                          const Text(
                            "Pending",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 17),
                          ),
                        ],
                      ),
                    ),
                    Tab(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SvgPicture.asset(
                            'assets/svg/rejected.svg',
                            height: 20,
                          ),
                          const SizedBox(width: 5),
                          const Text(
                            "Declined",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 17),
                          ),
                        ],
                      ),
                    ),
                  ],
                  indicatorSize: TabBarIndicatorSize.tab,
                ),
              ),
              const Expanded(
                flex: 12,
                child: TabBarView(
                  children: [
                    // first tab bar view widget
                    EnrolledPage(),
                    // second tab bar viiew widget
                    PendingPage(),
                    //third tab
                    DeclinedPage(),
                  ],
                ),
              ),
            ],
          ),
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
        List<EmployeeDetailsFetchedFromApi> employeeDetails = [];
        if (peopleProfileInfoResponse.data!.response.isNotEmpty) {
          for (var element in peopleProfileInfoResponse.data!.response) {
            employeeDetails.add(EmployeeDetailsFetchedFromApi(
              empId: element.empId,
              email: element.email,
              fullName: element.fullName,
              bloodGroup: element.personal!.bloodGroup,
              countryCode: element.phone!.countryCode,
              dob: element.personal!.dob,
              gender: element.personal!.gender,
              nationality: element.personal!.nationality,
              phoneNumber: element.phone!.number,
              siteName: element.siteName,
            ));
          }
          //
          ref
              .read(peopleProfileNotifier)
              .updatelistOfemployeenames(value: employeeDetails);
        }
      } else if (peopleProfileInfoResponse.status == ServiceStatus.error) {
        if (networkStatus == ConnectionStatus.offline) {
          showDialog(
            context: context,
            barrierDismissible: false,
            builder: (context) => InfoDialogWithTimer(
              isTimerActivated: true,
              isCancelButtonVisible: false,
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
