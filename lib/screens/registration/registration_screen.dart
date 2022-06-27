import 'package:country_list_pick/country_list_pick.dart';
import 'package:drop_down_list/drop_down_list.dart';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:idec_face/models/config/config_request.dart';
import 'package:idec_face/models/config/config_response.dart';
import 'package:idec_face/models/registration/client_details_response.dart';
//
import 'package:idec_face/models/registration/registration_request.dart'
    as registrationrequest;
import 'package:idec_face/models/registration/registration_response.dart';

import 'package:idec_face/repositary/config_info_repository/providers/config_info_notifier_provider.dart';
import 'package:idec_face/screens/registration/widgets/domain_data.dart';
import 'package:idec_face/screens/registration/widgets/name_data.dart';
import 'package:idec_face/screens/registration/widgets/preview_dialog.dart';
import 'package:idec_face/utility/extensions/string_utility.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../../constants.dart';
import '../../custom_widgets/button.dart';
import '../../custom_widgets/text.dart';
import '../../dialogs/info_dialog/dialog_with_timer.dart';
import '../../network/service_umbrella.dart';
import '../../repositary/registration_info_repositary/providers/registration_info_notifier_provider.dart';
import '../../utility/app_info.dart';
import '../../utility/connectivity/connectivity_constants.dart';
import '../../utility/connectivity/connectivity_notifier_provider.dart';
import '../../utility/privacy_policy.dart';
import 'notifiers/registration_notifiers.dart';
import 'widgets/contact_data.dart';
import 'widgets/personal_data.dart';
import 'widgets/validation/validation_dialog.dart';

class RegistrationPage extends ConsumerStatefulWidget {
  const RegistrationPage({
    Key? key,
  }) : super(key: key);

  @override
  _RegistrationPageState createState() => _RegistrationPageState();
}

class _RegistrationPageState extends ConsumerState<RegistrationPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  bool isPreviewButtonActive = false;
  bool isSubmitButtonActive = false;
  int isPageChanged = 0;

  final controller = PageController();
  final TextEditingController _domainController = TextEditingController();
  final TextEditingController _fnameController = TextEditingController();
  final TextEditingController _mnameController = TextEditingController();
  final TextEditingController _lnameController = TextEditingController();
  final TextEditingController _idController = TextEditingController();

  final TextEditingController _dateinput = TextEditingController();

  String? tenantId;
  String? hello = '5e142d628f7356e52ff0df75';

  CountryCode? code = CountryCode(
      dialCode: "+91", name: "India", code: "IN", flagUri: "flags/in.png");
  final TextEditingController _genderController = TextEditingController();
  final TextEditingController _nationalityController = TextEditingController();
  final TextEditingController _bloodController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _commentsController = TextEditingController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _getConfigAttributes();
      _getClientDetails();
    });
  }

  @override
  void dispose() {
    controller.dispose();
    _domainController.dispose();
    _fnameController.dispose();
    _mnameController.dispose();
    _lnameController.dispose();
    _idController.dispose();
    _dateinput.dispose();
    _genderController.dispose();
    _nationalityController.dispose();
    _bloodController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  void _getClientDetails() {
    ref.read(clientInfoNotifierProvider.notifier).getClientInfo();
  }

  void _getConfigAttributes() {
    final configInfoRequest =
        ConfigInfoRequest(configAttributes: ["GNDR", "BG", "NTY"]);
    ref
        .read(configInfoNotifierProvider.notifier)
        .getConfigAttributes(configInfoRequest);
  }

  void _registerUserAttributes() {
    final registrationInfoRequest = registrationrequest.RegistrationInfoRequest(
        employeeDetails: registrationrequest.EmployeeDetails(
            organisation: _domainController.text,
            phone: registrationrequest.Phone(
              countryCode: code.toString(),
              number: _phoneController.text,
            ),
            email: _emailController.text,
            empId: _idController.text,
            name: registrationrequest.Name(
                first: _fnameController.text,
                middle: _mnameController.text,
                last: _lnameController.text)));
    ref
        .read(registrationInfoNotifierProvider.notifier)
        .getregistrationattributes(registrationInfoRequest, hello);
  }

  String? customValidator(String? fieldContent) =>
      fieldContent!.isEmpty ? 'This is required field' : null;

  @override
  Widget build(BuildContext context) {
    double height20 = MediaQuery.of(context).size.height / 42.02;
    double height78 = MediaQuery.of(context).size.height / 10.25;

    final networkStatus = ref.read(connectivityNotifierProvider).status;

    //config api
    initConfigListeners(networkStatus);

    //client Info
    initClientDetailsListeners(networkStatus);

    // registration api
    initRegistrationListeners(networkStatus);

    return SafeArea(
      child: Form(
        key: _formKey,
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(height: AppConstants.abovecoldtruthheight),
              SvgPicture.asset(
                "assets/svg/logo.svg",
                height: 50,
              ),
              SizedBox(height: height20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  const SizedBox(
                    width: 40,
                  ),
                  Center(
                    child: CustomTextWidget(
                      color: AppConstants.customblack,
                      size: AppConstants.authtitlesize,
                      text: 'REGISTRATION',
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      if (_domainController.text.isEmptyValidate.isNotEmpty ||
                          _fnameController.text.isEmptyValidate.isNotEmpty ||
                          _lnameController.text.isEmptyValidate.isNotEmpty ||
                          _phoneController.text.isValidPhone.isNotEmpty ||
                          _emailController.text.isValidEmail.isNotEmpty) {
                        openValidationDialogWindow(
                            context,
                            code,
                            _domainController,
                            _fnameController,
                            _mnameController,
                            _lnameController,
                            _idController,
                            _dateinput,
                            _genderController,
                            _nationalityController,
                            _bloodController,
                            _phoneController,
                            _emailController,
                            _commentsController,
                            formHeader: "Preview Page");
                      } else {
                        openDialogWindow(
                            context,
                            code,
                            _domainController,
                            _fnameController,
                            _mnameController,
                            _lnameController,
                            _idController,
                            _dateinput,
                            _genderController,
                            _nationalityController,
                            _bloodController,
                            _phoneController,
                            _emailController,
                            _commentsController);
                      }
                    },
                    icon: SvgPicture.asset(
                      "assets/svg/eye.svg",
                      color: Theme.of(context).primaryColor,
                    ),
                  )
                ],
              ),
              Flexible(
                flex: 3,
                child: PageView(
                  controller: controller,
                  onPageChanged: (index) {
                    setState(() {
                      isPageChanged = index;
                    });
                  },
                  children: [
                    DomainPageRegistration(
                      onValidate: customValidator,
                      domainController: _domainController,
                    ),
                    NamePageRegistration(
                      onValidate: customValidator,
                      firstnameController: _fnameController,
                      middlenameController: _mnameController,
                      lastnameController: _lnameController,
                      employeeIdController: _idController,
                    ),
                    GenderPageRegistration(
                        onValidate: customValidator,
                        dateinput: _dateinput,
                        nationalityvalue: _nationalityController,
                        bloodvalue: _bloodController,
                        gendervalue: _genderController),
                    ContactPageRegistration(
                      onchanged: (countryCode) {
                        code = countryCode;
                        return code;
                      },
                      phoneNumberValidate: customValidator,
                      emailValidate: customValidator,
                      commentController: _commentsController,
                      emailController: _emailController,
                      phoneController: _phoneController,
                    ),
                  ],
                ),
              ),
              isPageChanged == 3
                  ? Flexible(
                      flex: 1,
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width / 2,
                        child: CustomButton(
                          height: 50,
                          function: () {
                            if (_domainController
                                    .text.isEmptyValidate.isNotEmpty ||
                                _fnameController
                                    .text.isEmptyValidate.isNotEmpty ||
                                _lnameController
                                    .text.isEmptyValidate.isNotEmpty ||
                                _phoneController.text.isValidPhone.isNotEmpty ||
                                _emailController.text.isValidEmail.isNotEmpty) {
                              openValidationDialogWindow(
                                context,
                                code,
                                _domainController,
                                _fnameController,
                                _mnameController,
                                _lnameController,
                                _idController,
                                _dateinput,
                                _genderController,
                                _nationalityController,
                                _bloodController,
                                _phoneController,
                                _emailController,
                                _commentsController,
                                formHeader: "Validation Error!",
                              );
                            } else {
                              _registerUserAttributes();
                              print(tenantId);
                            }
                          },
                          buttonColor: Theme.of(context).primaryColor,
                          buttonBorder:
                              Border.all(color: Colors.white30, width: 2),
                          buttonBorderRadius: BorderRadius.circular(05),
                          iconColor: Colors.white,
                          data: 'Submit',
                        ),
                      ),
                    )
                  : const Text(""),
            ],
          ),
          bottomSheet: Container(
            color: Theme.of(context).scaffoldBackgroundColor,
            height: height78,
            width: MediaQuery.of(context).size.width,
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              children: [
                Center(
                  child: SmoothPageIndicator(
                    controller: controller,
                    count: 4,
                    axisDirection: Axis.horizontal,
                    effect: const WormEffect(
                      dotWidth: 10,
                      dotHeight: 10,
                      activeDotColor: Colors.black,
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 2),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const CustomTextWidget(
                          text: "Already Registered ?",
                          size: 15,
                          fontWeight: FontWeight.w400,
                          color: Colors.black),
                      const SizedBox(width: 5),
                      InkWell(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        splashColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        hoverColor: AppConstants.secondaryColor,
                        child: Ink(
                          child: CustomTextWidget(
                            color: Theme.of(context).primaryColor,
                            size: 15,
                            decoration: TextDecoration.underline,
                            fontWeight: FontWeight.w400,
                            text: 'Login',
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(5),
                      child: Row(
                        children: [
                          const Text(
                            "v",
                            style: TextStyle(color: Colors.grey),
                          ),
                          getVersionNumber(),
                        ],
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        showDialog(
                            context: context,
                            builder: (context) => const PrivacyPolicyPage());
                      },
                      splashColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      hoverColor: AppConstants.secondaryColor,
                      child: Container(
                        padding: const EdgeInsets.all(5),
                        child: const Text(
                          "Privacy Policy",
                          style: TextStyle(
                              fontSize: 10,
                              decoration: TextDecoration.underline,
                              color: Colors.black),
                        ),
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  initClientDetailsListeners(ConnectionStatus networkStatus) {
    ref.listen(clientInfoNotifierProvider, (previous, next) {
      final clientsInfoResponse =
          next as ServiceResponse<ClientDetailsResponse?>;
      if (clientsInfoResponse.status == ServiceStatus.loading) {
      } else if (clientsInfoResponse.status == ServiceStatus.completed) {
        if (clientsInfoResponse.data!.response!.response!.isNotEmpty) {
          for (var element in clientsInfoResponse.data!.response!.response!) {
            if (element.domain == _domainController.text) {
              tenantId = element.id;
            }
          }
          ref.read(registrationNotifier).updateTenantId(value: tenantId);
        }
      }
    });
  }

  initRegistrationListeners(ConnectionStatus networkStatus) {
    ref.listen(registrationInfoNotifierProvider, (previous, next) {
      final registrationInfoResponse =
          next as ServiceResponse<RegistrationResponse?>;
      if (registrationInfoResponse.status == ServiceStatus.loading) {
      } else if (registrationInfoResponse.status == ServiceStatus.completed) {
        showDialog(
          context: context,
          barrierDismissible: false,
          builder: (context) => InfoDialogWithTimer(
            isTimerActivated: true,
            title: "Registration",
            message: registrationInfoResponse
                .data!.payload!.emailInfo!.body!.value
                .toString(),
          ),
        );
      }
    });
  }

  initConfigListeners(ConnectionStatus networkStatus) {
    ref.listen(configInfoNotifierProvider, ((previous, next) {
      final configInfoResponse = next as ServiceResponse<ConfigResponse?>;

      if (configInfoResponse.status == ServiceStatus.loading) {
      } else if (configInfoResponse.status == ServiceStatus.completed) {
        List<SelectedListItem> _listOfgender = [];
        List<SelectedListItem> _listOfnationality = [];
        List<SelectedListItem> _listOfbloodgroups = [];
        List<SelectedListItem> _listOfSelectionOption = [];
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
            //list of select options
            if (element.value!.selectionResponse != null) {
              for (var item in element.value!.selectionResponse!) {
                _listOfSelectionOption
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
          ref
              .read(registrationNotifier)
              .updatelistOfSelectOptionsState(value: _listOfSelectionOption);
        }
      } else if (configInfoResponse.status == ServiceStatus.error) {
        ref.read(registrationNotifier).updateConfigState(value: false);
        if (networkStatus == ConnectionStatus.offline) {
          showDialog(
            context: context,
            barrierDismissible: false,
            builder: (context) => const InfoDialogWithTimer(
              isTimerActivated: true,
              title: "Error",
              message: "No Internet Connectivity",
            ),
          );
        } else {
          showDialog(
            context: context,
            barrierDismissible: false,
            builder: (context) => const InfoDialogWithTimer(
              isTimerActivated: true,
              title: "Error",
              message: "Something went wrong",
            ),
          );
        }
      }
    }));
  }
}
