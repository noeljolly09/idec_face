import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:idec_face/constants.dart';
import 'package:idec_face/custom_widgets/encryptor.dart';
import 'package:idec_face/custom_widgets/textfields/custom_textfield.dart';
import 'package:idec_face/dialogs/info_dialog/dialog_with_timer.dart';
import 'package:idec_face/models/password_change/change_password_request.dart';
import 'package:idec_face/models/password_change/change_password_response.dart';
import 'package:idec_face/network/core/service_response.dart';
import 'package:idec_face/screens/login/notifier/login_notifiers.dart';
import 'package:idec_face/utility/connectivity/connectivity_constants.dart';
import 'package:idec_face/utility/connectivity/connectivity_notifier_provider.dart';
import 'package:idec_face/utility/extensions/string_utility.dart';
import 'package:idec_face/utility/shared_pref/provider/shared_pref_provider.dart';

import '../repository/password_change_repository/providers/password_change_notifier_provider.dart';

class ChangePasswordDialog extends ConsumerStatefulWidget {
  final String label;
  final bool? isOldPasswordFieldNeeded;
  final bool? isNewPassword;
  final TextEditingController? oldPassword;
  final String? tooltipText;
  const ChangePasswordDialog({
    Key? key,
    this.isOldPasswordFieldNeeded,
    this.tooltipText,
    this.isNewPassword,
    this.oldPassword,
    required this.label,
  }) : super(key: key);

  @override
  _ChangePasswordDialogState createState() => _ChangePasswordDialogState();
}

class _ChangePasswordDialogState extends ConsumerState<ChangePasswordDialog> {
  GlobalKey<FormState> formGlobalKey = GlobalKey<FormState>();
  bool _isConfirmNewPasswordObscure = true;
  bool _isNewPasswordObscure = true;
  bool _isOldPasswordObscure = true;
  String validatorData = "";

  //
  final TextEditingController _newPasswordController = TextEditingController();
  final TextEditingController _oldPasswordController = TextEditingController();

  final TextEditingController _newPasswordConfirmController =
      TextEditingController();
  //

  void _changePasswordAttributes() {
    String tenantId;
    String username;
    ref
                .read(sharedPrefUtilityProvider)
                .getLoggedInUser()!
                .response!
                .defaultValue !=
            null
        ? tenantId = ref.read(loginNotifier).tenantId!
        : tenantId = ref
            .watch(sharedPrefUtilityProvider)
            .getLoggedInPriviledgeUserDetails()!
            .response!
            .data!
            .first
            .tenants!
            .id!;
    ref
                .read(sharedPrefUtilityProvider)
                .getLoggedInUser()!
                .response!
                .defaultValue !=
            null
        ? username = ref.read(loginNotifier).username!
        : username = ref
            .watch(sharedPrefUtilityProvider)
            .getLoggedInPriviledgeUserDetails()!
            .response!
            .data!
            .first
            .userName!;

    final changePasswordRequest = ChangePasswordRequest(
      userName: username,
      oldPassword: widget.isOldPasswordFieldNeeded == true
          ? encryptor(_oldPasswordController.text)
          : encryptor(widget.oldPassword!.text),
      newPassword: encryptor(_newPasswordController.text),
    );
    ref
        .read(passwordChangeNotifierProvider.notifier)
        .getPasswordChangeAttributes(
          changePasswordRequest,
          tenantId,
        );
  }

  @override
  Widget build(BuildContext context) {
    final networkStatus = ref.read(connectivityNotifierProvider).status;

    initChangePasswordListeners(networkStatus);

    return AlertDialog(
        insetPadding: EdgeInsets.zero,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(20.0))),
        content: SizedBox(
          height: screenHeight(context, dividedBy: 1.80),
          width: screenWidth(context, dividedBy: 1.32),
          child: Form(
            key: formGlobalKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Center(
                        child: Text(
                      widget.label,
                      style: TextStyle(
                          color: AppConstants.primaryColor,
                          fontSize: AppConstants.authtitlesize),
                    )),
                  ],
                ),
                widget.isOldPasswordFieldNeeded == true
                    ? CustomTextField(
                        isSvg: true,
                        svgasset: "assets/svg/password.svg",
                        isObscure: _isOldPasswordObscure,
                        controller: _oldPasswordController,
                        suffixIcon: IconButton(
                          color: const Color.fromRGBO(28, 36, 44, 1),
                          icon: Icon(
                            _isOldPasswordObscure
                                ? Icons.visibility
                                : Icons.visibility_off,
                          ),
                          onPressed: () {
                            setState(() {
                              _isOldPasswordObscure = !_isOldPasswordObscure;
                            });
                          },
                        ),
                        validator: (value) {
                          if (value!.isValidChangePassword.isEmpty) {
                            return null;
                          } else {
                            return value.isValidChangePassword;
                          }
                        },
                        hint: "Old Password",
                        input: TextInputType.name,
                        textAction: TextInputAction.done,
                      )
                    : const SizedBox(),
                CustomTextField(
                  isSvg: true,
                  svgasset: "assets/svg/password.svg",
                  isObscure: _isNewPasswordObscure,
                  controller: _newPasswordController,
                  suffixIcon: IconButton(
                    color: const Color.fromRGBO(28, 36, 44, 1),
                    icon: Icon(
                      _isNewPasswordObscure
                          ? Icons.visibility
                          : Icons.visibility_off,
                    ),
                    onPressed: () {
                      setState(() {
                        _isNewPasswordObscure = !_isNewPasswordObscure;
                      });
                    },
                  ),
                  validator: (value) {
                    if (value!.isValidChangePassword.isEmpty) {
                      return null;
                    } else {
                      return value.isValidChangePassword;
                    }
                  },
                  hint: "New Password",
                  input: TextInputType.name,
                  textAction: TextInputAction.done,
                ),
                CustomTextField(
                  isSvg: true,
                  svgasset: "assets/svg/password.svg",
                  isObscure: _isConfirmNewPasswordObscure,
                  controller: _newPasswordConfirmController,
                  suffixIcon: IconButton(
                    color: const Color.fromRGBO(28, 36, 44, 1),
                    icon: Icon(
                      _isConfirmNewPasswordObscure
                          ? Icons.visibility
                          : Icons.visibility_off,
                    ),
                    onPressed: () {
                      setState(() {
                        _isConfirmNewPasswordObscure =
                            !_isConfirmNewPasswordObscure;
                      });
                    },
                  ),
                  validator: (value) {
                    if (_newPasswordController.text != value) {
                      return "Password not same";
                    }
                    return null;
                  },
                  hint: "Confirm New Password",
                  input: TextInputType.name,
                  textAction: TextInputAction.done,
                ),
                ElevatedButton(
                  onPressed: () {
                    if (formGlobalKey.currentState!.validate()) {
                      _changePasswordAttributes();
                    }
                  },
                  child: const Text('Confirm'),
                  style: ElevatedButton.styleFrom(
                    onPrimary: Colors.white,
                    primary: AppConstants.primaryColor,
                  ),
                )
              ],
            ),
          ),
        ));
  }

  initChangePasswordListeners(ConnectionStatus networkStatus) {
    ref.listen(passwordChangeNotifierProvider, (previous, next) {
      final changePasswordResponse =
          next as ServiceResponse<ChangePasswordResponse?>;
      if (changePasswordResponse.status == ServiceStatus.loading) {
        showDialog(
            context: context,
            builder: (context) => const Center(
                  child: SpinKitCircle(
                    color: AppConstants.primaryColor,
                  ),
                ));
      } else if (changePasswordResponse.status == ServiceStatus.completed) {
        Navigator.pop(context);
        if (changePasswordResponse.data!.status! == true) {
          ref.read(sharedPrefUtilityProvider).resetPreference();

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
              title: "Password Change",
              message:
                  changePasswordResponse.data!.response!.message.toString(),
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
              title: "Password Change Error",
              message:
                  changePasswordResponse.data!.response!.message.toString(),
            ),
          );
        }
      } else if (changePasswordResponse.status == ServiceStatus.error) {
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
