import 'package:drop_down_list/drop_down_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/svg.dart';
import 'package:idec_face/custom_widgets/textfields/forgot_password_textfield.dart';
import 'package:idec_face/models/client_details.dart';
import 'package:idec_face/models/password_reset/password_reset_request.dart';
import 'package:idec_face/models/password_reset/password_reset_response.dart';
import 'package:idec_face/models/registration/client_details_response.dart';
import 'package:idec_face/repository/config_info_repository/providers/config_info_notifier_provider.dart';
import 'package:idec_face/repository/password_reset_repository/providers/password_reset_notifier_provider.dart';
import 'package:idec_face/repository/registration_info_repositary/providers/registration_info_notifier_provider.dart';
import 'package:idec_face/screens/registration/notifiers/registration_notifiers.dart';
import 'package:idec_face/utility/extensions/string_utility.dart';
import 'package:url_launcher/url_launcher.dart';

import '../constants.dart';
import '../custom_widgets/button.dart';

import '../custom_widgets/text.dart';
import '../custom_widgets/textfields/custom_textfield.dart';

import '../dialogs/info_dialog/dialog_with_timer.dart';
import '../models/config/config_request.dart';
import '../models/config/config_response.dart';
import '../network/service_umbrella.dart';
import '../utility/app_info.dart';
import '../utility/connectivity/connectivity_constants.dart';
import '../utility/connectivity/connectivity_notifier_provider.dart';

class ForgotPasswordPage extends ConsumerStatefulWidget {
  const ForgotPasswordPage({Key? key}) : super(key: key);

  @override
  _ForgotPasswordPageState createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends ConsumerState<ForgotPasswordPage> {
  GlobalKey<FormState> formGlobalKey = GlobalKey<FormState>();
  final TextEditingController _domainController = TextEditingController();
  final TextEditingController _valueController = TextEditingController();
  final TextEditingController _optionsController = TextEditingController();
  final TextEditingController _searchController = TextEditingController();

  Map<String, String> domainList = {};

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
    super.dispose();
  }

  void _getClientDetails() {
    ref.read(clientInfoNotifierProvider.notifier).getClientInfo();
  }

  void _getConfigAttributes() {
    final configInfoRequest =
        ConfigInfoRequest(configAttributes: ["forgotPasswordAttributes"]);
    ref
        .read(configInfoNotifierProvider.notifier)
        .getConfigAttributes(configInfoRequest);
  }

  void _getPasswordResetAttributes() {
    String tenantId = "";
    if (domainList.keys.contains(_domainController.text.trim().toUpperCase())) {
      tenantId = domainList[_domainController.text.trim().toUpperCase()]!;
      var passwordResetRequest = PasswordResetRequest();
      if (_optionsController.text.toLowerCase() == "userName") {
        passwordResetRequest = PasswordResetRequest(
          userName: _valueController.text,
        );
      } else if (_optionsController.text.toLowerCase() == "employeeId") {
        passwordResetRequest = PasswordResetRequest(
          empId: _valueController.text,
        );
      } else if (_optionsController.text.toLowerCase() == "email") {
        passwordResetRequest = PasswordResetRequest(
          email: _valueController.text,
        );
      } else if (_optionsController.text.toLowerCase() == "phone") {
        passwordResetRequest = PasswordResetRequest(
          phone: _valueController.text,
        );
      }

      ref
          .read(passwordResetNotifierProvider.notifier)
          .getPasswordResetAttributes(
            passwordResetRequest,
            tenantId,
          );
    }
  }

  @override
  Widget build(BuildContext context) {
    double height10 = MediaQuery.of(context).size.height / 82.05;
    double height20 = MediaQuery.of(context).size.height / 42.02;
    double height25 = MediaQuery.of(context).size.height / 32.82;
    double height60 = MediaQuery.of(context).size.height / 13.67;

    final networkStatus = ref.read(connectivityNotifierProvider).status;
    initConfigListeners(networkStatus);
    initResetPasswordListeners(networkStatus);
    initClientDetailsListeners(networkStatus);

    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        body: Form(
          key: formGlobalKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: AppConstants.abovecoldtruthheight),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SvgPicture.asset(
                          "assets/svg/ust_logo.svg",
                          height: 50,
                        ),
                        RichText(
                          text: const TextSpan(
                            style: TextStyle(color: Colors.black, fontSize: 35),
                            children: <TextSpan>[
                              TextSpan(
                                  text: " Idec ",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      color: AppConstants.primaryColor)),
                              TextSpan(text: 'Face', style: TextStyle())
                            ],
                          ),
                        )
                      ],
                    ),
                    SizedBox(height: height25),
                    CustomTextWidget(
                      color: AppConstants.customblack,
                      size: AppConstants.authtitlesize,
                      text: 'FORGOT YOUR PASSWORD ?',
                      fontWeight: FontWeight.normal,
                    ),
                    SizedBox(height: height10),
                    Column(
                      children: [
                        SizedBox(height: height25),
                        SizedBox(
                          width: MediaQuery.of(context).size.width / 1.4,
                          child: Column(
                            children: [
                              SizedBox(height: height20),
                              CustomTextField(
                                isSvg: true,
                                svgasset: "assets/svg/domain.svg",
                                controller: _domainController,
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Domain name required';
                                  } else if (!domainList.keys
                                      .contains(value.trim().toUpperCase())) {
                                    return "Invalid domain";
                                  } else {
                                    return null;
                                  }
                                },
                                capital: TextCapitalization.characters,
                                hint: "Domain",
                                input: TextInputType.name,
                                textAction: TextInputAction.next,
                              ),
                              SizedBox(height: height20),
                              SizedBox(
                                width: MediaQuery.of(context).size.width / 1.2,
                                child: ForgotPasswordTextField(
                                  hint: _optionsController.text.isEmpty
                                      ? "Enter Value"
                                      : _optionsController.text,
                                  controller: _valueController,
                                  optionController: _optionsController,
                                  searchController: _searchController,
                                  textAction: TextInputAction.done,
                                  input: TextInputType.text,
                                  textorflex: false,
                                  validator: (value) {
                                    if (value!.isEmpty ||
                                        _optionsController.text.isEmpty) {
                                      return 'Select any one option';
                                    } else {
                                      return null;
                                    }
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: height60),
                        SizedBox(
                          width: MediaQuery.of(context).size.width / 1.4,
                          child: Row(
                            children: [
                              Expanded(
                                child: CustomButton(
                                  height: 50,
                                  function: () {
                                    Navigator.pop(context);
                                  },
                                  buttonColor: Theme.of(context).primaryColor,
                                  buttonBorder: Border.all(
                                      color: Colors.white30, width: 2),
                                  buttonBorderRadius: BorderRadius.circular(05),
                                  iconColor: Colors.white,
                                  data: 'CANCEL',
                                ),
                              ),
                              const SizedBox(width: 5),
                              Expanded(
                                child: CustomButton(
                                  height: 50,
                                  function: () {
                                    if (formGlobalKey.currentState!
                                        .validate()) {
                                      _getPasswordResetAttributes();
                                    }
                                  },
                                  width:
                                      MediaQuery.of(context).size.width / 1.7,
                                  buttonColor: Theme.of(context).primaryColor,
                                  buttonBorder: Border.all(
                                      color: Colors.white30, width: 2),
                                  buttonBorderRadius: BorderRadius.circular(05),
                                  iconColor: Colors.white,
                                  data: 'SUBMIT',
                                ),
                              )
                            ],
                          ),
                        ),
                        SizedBox(height: height20),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 5),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const CustomTextWidget(
                                  text: "Already Registered?",
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
                      ],
                    ),
                  ],
                ),
              ),
              const Spacer(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(5),
                    child: Row(
                      children: [
                        const Text(
                          "V",
                          style: TextStyle(color: Colors.grey),
                        ),
                        getVersionNumber(),
                      ],
                    ),
                  ),
                  InkWell(
                    onTap: () async {
                      await launchUrl(Uri.parse(
                          "https://idecobserverappdev.azurewebsites.net/#/policy"));
                    },
                    splashColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    hoverColor: AppConstants.secondaryColor,
                    child: Container(
                      margin: const EdgeInsets.all(5),
                      padding: const EdgeInsets.all(5),
                      child: const Text(
                        "Privacy Policy",
                        style: TextStyle(
                            decoration: TextDecoration.underline,
                            fontSize: 10,
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
    );
  }

  initClientDetailsListeners(ConnectionStatus networkStatus) {
    ref.listen(clientInfoNotifierProvider, (previous, next) {
      final clientsInfoResponse =
          next as ServiceResponse<ClientDetailsResponse?>;
      if (clientsInfoResponse.status == ServiceStatus.loading) {
      } else if (clientsInfoResponse.status == ServiceStatus.completed) {
        if (clientsInfoResponse.data!.response!.response!.isNotEmpty) {
          List<ClientDetailsModel> _list = [];
          for (var item in clientsInfoResponse.data!.response!.response!) {
            domainList[item.domain!.trim().toUpperCase()] = item.id!;
          }

          ref.read(registrationNotifier).updatelistofClients(value: _list);
        }
      } else {
        showDialog(
          context: context,
          barrierDismissible: false,
          builder: (context) => InfoDialogWithTimer(
            isTimerActivated: true,
            isCancelButtonVisible: false,
            afterSuccess: () {
              Navigator.pushNamedAndRemoveUntil(
                  context, '/login', (route) => false);
            },
            onPressedBttn1: () {
              Navigator.pushNamedAndRemoveUntil(
                  context, '/login', (route) => false);
            },
            title: "Error",
            message: "Unable to fetch Data.",
          ),
        );
      }
    });
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

  initConfigListeners(ConnectionStatus networkStatus) {
    ref.listen(configInfoNotifierProvider, ((previous, next) {
      final configInfoResponse = next as ServiceResponse<ConfigResponse?>;

      if (configInfoResponse.status == ServiceStatus.loading) {
      } else if (configInfoResponse.status == ServiceStatus.completed) {
        List<SelectedListItem> _listOfSelectionOption = [];

        if (configInfoResponse.data!.response!.isNotEmpty) {
          for (var element in configInfoResponse.data!.response!) {
            //list of select options
            if (element.value!.selectionResponse != null) {
              for (var item in element.value!.selectionResponse!) {
                _listOfSelectionOption
                    .add(SelectedListItem(false, item.value!.capitalize));
              }
            }
          }
          ref.read(registrationNotifier).updateConfigState(value: true);
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
    }));
  }
}
