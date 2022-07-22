import 'package:drop_down_list/drop_down_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:idec_face/constants.dart';
import 'package:idec_face/custom_widgets/custom_appbar.dart';
import 'package:idec_face/custom_widgets/custom_selection.dart';
import 'package:idec_face/custom_widgets/textfields/custom_pending_approval_textfield.dart';
import 'package:idec_face/dialogs/info_dialog/dialog_with_timer.dart';
import 'package:idec_face/models/config/config_request.dart';
import 'package:idec_face/models/config/config_response.dart';
import 'package:idec_face/models/people_profile/check_availabilty_request.dart';
import 'package:idec_face/models/people_profile/check_availabilty_response.dart';
import 'package:idec_face/models/people_profile/role_list_response.dart';
import 'package:idec_face/models/people_profile/trade_response.dart';
import 'package:idec_face/network/core/service_response.dart';
import 'package:idec_face/repository/check_username_availabilty/providers/check_username_availability_notifier_provider.dart';
import 'package:idec_face/repository/config_info_repository/providers/config_info_notifier_provider.dart';
import 'package:idec_face/repository/people_profile/providers/people_profile_notifier_provider.dart';
import 'package:idec_face/screens/people_profile/models/employee_data_model.dart';
import 'package:idec_face/screens/people_profile/notifiers/people_profile_notfier.dart';
import 'package:idec_face/screens/registration/notifiers/registration_notifiers.dart';
import 'package:idec_face/utility/connectivity/connectivity_constants.dart';
import 'package:idec_face/utility/connectivity/connectivity_notifier_provider.dart';
import 'package:idec_face/utility/extensions/date_utility.dart';
import 'package:idec_face/utility/extensions/string_utility.dart';
import 'package:intl/intl.dart';

class PendingApprovalPage extends ConsumerStatefulWidget {
  final int employeeIndex;
  final List<EmployeeDetailsFetchedFromApi> pendingList;
  const PendingApprovalPage({
    Key? key,
    required this.pendingList,
    required this.employeeIndex,
  }) : super(key: key);

  @override
  _PendingApprovalPageState createState() => _PendingApprovalPageState();
}

class _PendingApprovalPageState extends ConsumerState<PendingApprovalPage> {
  // text controllers
  TextEditingController dateinput = TextEditingController();
  TextEditingController firstNameController = TextEditingController();
  TextEditingController middleNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController employeeIdController = TextEditingController();
  TextEditingController bloodgroupController = TextEditingController();
  TextEditingController roleController = TextEditingController();
  TextEditingController tradeController = TextEditingController();
  TextEditingController contractorController = TextEditingController();
  TextEditingController genderController = TextEditingController();
  TextEditingController nationalityController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController usernameController = TextEditingController();
  TextEditingController priviledgesController = TextEditingController();
  TextEditingController remarksController = TextEditingController();

  //searchControllers
  TextEditingController genderSearchController = TextEditingController();

  //list
  List<SelectedListItem> _listOfgender = [];
  List<SelectedListItem> _listOfnationality = [];
  List<SelectedListItem> _listOfbloodgroups = [];
  List<SelectedListItem> _listOftrade = [];
  List<SelectedListItem> _listofRoles = [];

  List<SelectedListItem> listofPrivildges = [
    SelectedListItem(false, "Admin L2")
  ];

  //bools
  bool isConfigreceived = false;
  bool isSelected = false;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _getConfigAttributes();
      _getTradeAttributes();
      _getRoleAttributes();
    });
    var data = widget.pendingList[widget.employeeIndex];
    firstNameController.text = data.firstName!;
    middleNameController.text = data.middleName == null ? "" : data.middleName!;
    lastNameController.text = data.lastName!;
    employeeIdController.text = data.empId == null ? "" : data.empId!;
    dateinput.text = data.dob == null ? "" : data.dob!.formatDateWithoutTime;

    emailController.text = data.email == null ? "" : data.email!;

    super.initState();
  }

  @override
  void dispose() {
    firstNameController.dispose();
    middleNameController.dispose();
    lastNameController.dispose();
    employeeIdController.dispose();
    dateinput.dispose();
    bloodgroupController.dispose();
    roleController.dispose();
    tradeController.dispose();
    contractorController.dispose();
    genderController.dispose();
    nationalityController.dispose();
    emailController.dispose();
    usernameController.dispose();
    priviledgesController.dispose();
    remarksController.dispose();

    super.dispose();
  }

  void _getConfigAttributes() {
    final configInfoRequest = ConfigInfoRequest(
        configAttributes: ["gender", "nationality", "bloodGroup"]);
    ref
        .read(configInfoNotifierProvider.notifier)
        .getConfigAttributes(configInfoRequest);
  }

  void _getTradeAttributes() {
    ref.read(tradeInfoNotifierProvider.notifier).getTradeAttributes();
  }

  void _getRoleAttributes() {
    ref.read(roleInfoNotifierProvider.notifier).getroleAttributes();
  }

  void _getCheckAvailabilityAttributes() {
    final request = CheckAvailabiltyRequest(username: usernameController.text);
    ref
        .read(checkAvailabitlityInfoNotifierProvider.notifier)
        .getavailabiltyattributes(request);
  }

  @override
  Widget build(BuildContext context) {
    _listOfgender = ref.watch(registrationNotifier).listOfgender;
    _listOfbloodgroups = ref.watch(registrationNotifier).listOfbloodgroups;
    _listOfnationality = ref.watch(registrationNotifier).listOfnationality;
    _listOftrade = ref.watch(peopleProfileNotifier).listofTrade;
    _listofRoles = ref.watch(peopleProfileNotifier).listofRole;
    isConfigreceived = ref.watch(registrationNotifier).isConfigreceived;
    String availablityButtonText =
        ref.watch(peopleProfileNotifier).checkAvailability;
    bool availablityButton =
        ref.watch(peopleProfileNotifier).checkAvailabilityButton;

    final networkStatus = ref.read(connectivityNotifierProvider).status;

    //config api
    initConfigListeners(networkStatus);
    //trade api
    initTradeListeners(networkStatus);
    //role api
    initRoleListeners(networkStatus);
    //username availability
    initCheckUsernameAvailabilityListeners(networkStatus);

    //
    return Scaffold(
      appBar: customAppBar("Validate Profile"),
      body: SingleChildScrollView(
          child: Column(
        children: [
          const SizedBox(height: 30),
          widget.pendingList[widget.employeeIndex].image == null
              ? Center(
                  child: SvgPicture.asset(
                    'assets/svg/User_big.svg',
                    height: 90,
                  ),
                )
              : widget.pendingList[widget.employeeIndex].image!.isEmpty
                  ? Center(
                      child: SvgPicture.asset(
                        'assets/svg/User_big.svg',
                        height: 80,
                      ),
                    )
                  : Image.network(
                      widget.pendingList[widget.employeeIndex].image!,
                      height: 80,
                      width: 80, errorBuilder: (context, object, value) {
                      return SvgPicture.asset(
                        'assets/svg/User_big.svg',
                        height: 80,
                      );
                    }),
          CustomPendingApprovalTextField(
            controller: firstNameController,
            label: "First Name*",
            assetName: "assets/svg/user.svg",
          ),
          CustomPendingApprovalTextField(
            controller: middleNameController,
            label: "Middle Name",
            assetName: "assets/svg/user.svg",
          ),
          CustomPendingApprovalTextField(
            controller: lastNameController,
            label: "Last Name*",
            assetName: "assets/svg/user.svg",
          ),
          CustomPendingApprovalTextField(
            controller: employeeIdController,
            isreadOnly: true,
            label: "Employee Id*",
            assetName: "assets/svg/useriD.svg",
          ),
          Container(
            margin: const EdgeInsets.only(left: 20, right: 20, top: 15),
            child: TextFormField(
              controller: dateinput,
              decoration: InputDecoration(
                enabledBorder: const UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey.shade400),
                ),
                contentPadding: const EdgeInsets.all(10),
                labelText: "DOB",
                labelStyle: TextStyle(color: AppConstants.labeltextgrey),
                floatingLabelStyle:
                    const TextStyle(color: AppConstants.customblack),
                prefixIconConstraints:
                    const BoxConstraints(maxHeight: 50, maxWidth: 50),
                prefixIcon: Container(
                  margin: const EdgeInsets.only(right: 20),
                  child: SvgPicture.asset(
                    "assets/svg/calendar.svg",
                    color: AppConstants.customblack,
                    alignment: Alignment.center,
                    height: 30,
                  ),
                ),
              ),
              readOnly: true,
              onTap: () async {
                DateTime? pickedDate = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime(1950),
                  lastDate: DateTime.now(),
                );

                if (pickedDate != null) {
                  String formattedDate =
                      DateFormat('yyyy-MM-dd').format(pickedDate);

                  setState(() {
                    dateinput.text = formattedDate;
                  });
                }
              },
            ),
          ),
          Container(
            margin: const EdgeInsets.only(left: 20, right: 20, top: 15),
            child: CustomSelectionBar(
              isCircleSuffixIcon: false,
              isSvg: true,
              svgAsset: "assets/svg/blood.svg",
              width: MediaQuery.of(context).size.width,
              list: _listOfbloodgroups,
              hinttext: "BloodGroup",
              searchhinttext: "Select your bloodGroup",
              sheetTitle: "BloodGroup",
              controller: bloodgroupController,
              searchController: genderSearchController,
              isConfigreceived: isConfigreceived,
            ),
          ),
          Container(
            margin: const EdgeInsets.only(left: 20, right: 20, top: 15),
            child: CustomSelectionBar(
              isCircleSuffixIcon: false,
              isSvg: true,
              svgAsset: "assets/svg/gender.svg",
              width: MediaQuery.of(context).size.width,
              list: _listofRoles,
              hinttext: "Role*",
              searchhinttext: "Select your role",
              sheetTitle: "Roles",
              controller: roleController,
              searchController: genderSearchController,
              isConfigreceived: isConfigreceived,
            ),
          ),
          Container(
            margin: const EdgeInsets.only(left: 20, right: 20, top: 15),
            child: CustomSelectionBar(
              isCircleSuffixIcon: false,
              isSvg: true,
              svgAsset: "assets/svg/gender.svg",
              width: MediaQuery.of(context).size.width,
              list: _listOftrade,
              hinttext: "Trade*",
              searchhinttext: "Select your Trade",
              sheetTitle: "Trade",
              controller: tradeController,
              searchController: genderSearchController,
              isConfigreceived: isConfigreceived,
            ),
          ),
          Container(
            margin: const EdgeInsets.only(left: 20, right: 20, top: 15),
            child: CustomSelectionBar(
              isCircleSuffixIcon: false,
              isSvg: true,
              svgAsset: "assets/svg/gender.svg",
              width: MediaQuery.of(context).size.width,
              list: _listOfgender,
              hinttext: "Gender",
              searchhinttext: "Select your gender",
              sheetTitle: "Gender",
              controller: genderController,
              searchController: genderSearchController,
              isConfigreceived: isConfigreceived,
            ),
          ),
          Container(
            margin: const EdgeInsets.only(left: 20, right: 20, top: 15),
            child: CustomSelectionBar(
              isCircleSuffixIcon: false,
              isSvg: true,
              svgAsset: "assets/svg/nationality.svg",
              width: MediaQuery.of(context).size.width,
              list: _listOfnationality,
              hinttext: "Nationality",
              searchhinttext: "Select your Nationality",
              sheetTitle: "Nationality",
              controller: nationalityController,
              searchController: genderSearchController,
              isConfigreceived: isConfigreceived,
            ),
          ),
          CustomPendingApprovalTextField(
            controller: emailController,
            label: "Email",
            assetName: "assets/svg/useriD.svg",
          ),
          Container(
            margin: const EdgeInsets.only(right: 20, top: 15),
            child: CheckboxListTile(
              title: const Text("Generate User Credentials"),
              value: isSelected,
              onChanged: (value) {
                setState(() {
                  isSelected = value!;
                });
              },
              controlAffinity: ListTileControlAffinity.leading,
            ),
          ),
          isSelected == true
              ? Column(
                  children: [
                    Row(
                      children: [
                        const Expanded(
                          flex: 3,
                          child: CustomPendingApprovalTextField(
                            label: "Username",
                            assetName: "assets/svg/useriD.svg",
                          ),
                        ),
                        Flexible(
                          child: ElevatedButton(
                            onPressed: () {
                              _getCheckAvailabilityAttributes();
                            },
                            child: Text(availablityButtonText),
                            style: availablityButton == true
                                ? ElevatedButton.styleFrom(
                                    onPrimary: Colors.white,
                                    primary: Colors.green,
                                  )
                                : ElevatedButton.styleFrom(
                                    onPrimary: Colors.white,
                                    primary: AppConstants.primaryColor,
                                  ),
                          ),
                        ),
                      ],
                    ),
                    Container(
                      margin:
                          const EdgeInsets.only(left: 20, right: 20, top: 15),
                      child: CustomSelectionBar(
                        isCircleSuffixIcon: false,
                        isSvg: true,
                        svgAsset: "assets/svg/nationality.svg",
                        width: MediaQuery.of(context).size.width,
                        list: listofPrivildges,
                        hinttext: "Priviledges",
                        searchhinttext: "Select your Priviledges",
                        sheetTitle: "Priviledges",
                        controller: genderController,
                        searchController: genderSearchController,
                        isConfigreceived: isConfigreceived,
                      ),
                    ),
                    Container(
                      margin:
                          const EdgeInsets.only(left: 20, right: 20, top: 10),
                      child: TextFormField(
                        style: TextStyle(
                          fontSize: AppConstants.formtextsize,
                          fontStyle: FontStyle.normal,
                        ),
                        controller: genderController,
                        decoration: InputDecoration(
                            label: const Text("Remarks"),
                            labelStyle:
                                TextStyle(color: AppConstants.labeltextgrey),
                            floatingLabelStyle: const TextStyle(
                                color: AppConstants.customblack),
                            contentPadding: const EdgeInsets.only(bottom: 5),
                            prefixIconConstraints: const BoxConstraints(
                                maxHeight: 30, maxWidth: 30),
                            prefixIcon: Container(
                              margin: const EdgeInsets.all(2),
                              child: SvgPicture.asset(
                                "assets/svg/comments.svg",
                                color: AppConstants.customblack,
                                alignment: Alignment.center,
                              ),
                            ),
                            enabledBorder: const UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.grey),
                            ),
                            focusedBorder: const UnderlineInputBorder(
                              borderSide: BorderSide(
                                  color: AppConstants.secondaryColor),
                            )),
                        keyboardType: TextInputType.multiline,
                        textInputAction: TextInputAction.done,
                        textAlign: TextAlign.start,
                        maxLines: 3,
                      ),
                    ),
                  ],
                )
              : const SizedBox(),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('Close')),
              const SizedBox(width: 30),
              ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('Reject')),
              const SizedBox(width: 30),
              ElevatedButton(
                onPressed: () {},
                child: const Text('Approve'),
                style: ElevatedButton.styleFrom(
                  onPrimary: Colors.white,
                  primary: AppConstants.primaryColor,
                ),
              )
            ],
          ),
          const SizedBox(height: 30)
        ],
      )),
    );
  }

  initRoleListeners(ConnectionStatus networkStatus) {
    ref.listen(roleInfoNotifierProvider, ((previous, next) {
      final roleInfoResponse = next as ServiceResponse<RoleListResponse?>;

      if (roleInfoResponse.status == ServiceStatus.loading) {
      } else if (roleInfoResponse.status == ServiceStatus.completed) {
        List<SelectedListItem> _listOfRole = [];

        if (roleInfoResponse.data!.response!.data!.isNotEmpty) {
          for (var element in roleInfoResponse.data!.response!.data!) {
            //role
            _listOfRole
                .add(SelectedListItem(false, element.roleName!.capitalize));
          }
          ref.read(peopleProfileNotifier).updatelistofRole(value: _listOfRole);
        }
      } else if (roleInfoResponse.status == ServiceStatus.error) {
        Navigator.pop(context);
        if (networkStatus == ConnectionStatus.offline) {
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
    }));
  }

  initCheckUsernameAvailabilityListeners(ConnectionStatus networkStatus) {
    ref.listen(checkAvailabitlityInfoNotifierProvider, ((previous, next) {
      final availabiltiyInfoResponse =
          next as ServiceResponse<CheckAvailabiltyResponse?>;

      if (availabiltiyInfoResponse.status == ServiceStatus.loading) {
      } else if (availabiltiyInfoResponse.status == ServiceStatus.completed) {
        if (availabiltiyInfoResponse.data!.status == false) {
          ref
              .read(peopleProfileNotifier)
              .updatecheckavailabilityState(value: "Already in Use");
          ref
              .read(peopleProfileNotifier)
              .updatecheckavailabilityButtonState(value: false);
        } else {
          ref
              .read(peopleProfileNotifier)
              .updatecheckavailabilityState(value: "Available");
          ref
              .read(peopleProfileNotifier)
              .updatecheckavailabilityButtonState(value: true);
        }
      } else if (availabiltiyInfoResponse.status == ServiceStatus.error) {
        Navigator.pop(context);
        if (networkStatus == ConnectionStatus.offline) {
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
    }));
  }

  initTradeListeners(ConnectionStatus networkStatus) {
    ref.listen(tradeInfoNotifierProvider, ((previous, next) {
      final tradeInfoResponse = next as ServiceResponse<TradeListResponse?>;

      if (tradeInfoResponse.status == ServiceStatus.loading) {
      } else if (tradeInfoResponse.status == ServiceStatus.completed) {
        List<SelectedListItem> _listOftrade = [];

        if (tradeInfoResponse.data!.response!.data!.isNotEmpty) {
          for (var element in tradeInfoResponse.data!.response!.data!) {
            //gender
            _listOftrade
                .add(SelectedListItem(false, element.tradeName!.capitalize));
          }
          ref
              .read(peopleProfileNotifier)
              .updatelistofTrade(value: _listOftrade);
        }
      } else if (tradeInfoResponse.status == ServiceStatus.error) {
        Navigator.pop(context);
        if (networkStatus == ConnectionStatus.offline) {
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
    }));
  }

  initConfigListeners(ConnectionStatus networkStatus) {
    ref.listen(configInfoNotifierProvider, ((previous, next) {
      final configInfoResponse = next as ServiceResponse<ConfigResponse?>;

      if (configInfoResponse.status == ServiceStatus.loading) {
      } else if (configInfoResponse.status == ServiceStatus.completed) {
        List<SelectedListItem> _listOfgender = [];
        List<SelectedListItem> _listOfnationality = [];
        List<SelectedListItem> _listOfbloodgroups = [];
        if (configInfoResponse.data!.response!.isNotEmpty) {
          for (var element in configInfoResponse.data!.response!) {
            //gender
            if (element.value!.genderResponse != null) {
              for (var item in element.value!.genderResponse!) {
                _listOfgender
                    .add(SelectedListItem(false, item.name!.capitalize));
              }
            }
            //blood group
            if (element.value!.bloodGrpResponse != null) {
              for (var item in element.value!.bloodGrpResponse!) {
                _listOfbloodgroups
                    .add(SelectedListItem(false, item.value!.capitalize));
              }
            }
            //nationality
            if (element.value!.nationalityResponse != null) {
              for (var item in element.value!.nationalityResponse!) {
                _listOfnationality
                    .add(SelectedListItem(false, item.name!.capitalize));
              }
            }
          }
          ref.read(registrationNotifier).updateConfigState(value: true);
          ref
              .read(registrationNotifier)
              .updatelistOfbloodgroupsState(value: _listOfbloodgroups);
          ref
              .read(registrationNotifier)
              .updatelistOfgenderState(value: _listOfgender);
          ref
              .read(registrationNotifier)
              .updatelistOfnationalityState(value: _listOfnationality);
        }
      } else if (configInfoResponse.status == ServiceStatus.error) {
        Navigator.pop(context);
        ref.read(registrationNotifier).updateConfigState(value: false);
        if (networkStatus == ConnectionStatus.offline) {
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
    }));
  }
}
