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

import '../repository/password_change_repository/providers/password_change_notifier_provider.dart';

class ChangePasswordDialog extends ConsumerStatefulWidget {
  final String label;
  const ChangePasswordDialog({
    Key? key,
    required this.label,
  }) : super(key: key);

  @override
  _ChangePasswordDialogState createState() => _ChangePasswordDialogState();
}

class _ChangePasswordDialogState extends ConsumerState<ChangePasswordDialog> {
  GlobalKey<FormState> formGlobalKey = GlobalKey<FormState>();
  bool _isOldPasswordObscure = true;
  bool _isNewPasswordObscure = true;

  //
  final TextEditingController _passwordChangeUsernameController =
      TextEditingController();
  final TextEditingController _passwordChangeOldPasswordController =
      TextEditingController();
  final TextEditingController _passwordChangeNewPasswordController =
      TextEditingController();
  //

  void _changePasswordAttributes() {
    String tenantId = ref.watch(loginNotifier).tenantId!;

    final changePasswordRequest = ChangePasswordRequest(
      userName: _passwordChangeUsernameController.text,
      oldPassword: encryptor(_passwordChangeOldPasswordController.text),
      newPassword: encryptor(_passwordChangeNewPasswordController.text),
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
          height: screenHeight(context, dividedBy: 1.82),
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
                    const Tooltip(
                        message: "Please enter new credentials to log in",
                        decoration: BoxDecoration(color: Colors.black54),
                        child: Padding(
                          padding: EdgeInsets.all(10),
                          child: Icon(
                            Icons.info,
                            color: AppConstants.primaryColor,
                          ),
                        )),
                  ],
                ),
                CustomTextField(
                  isSvg: true,
                  svgasset: "assets/svg/user.svg",
                  hint: "Username",
                  controller: _passwordChangeUsernameController,
                  validator: (value) {
                    if (value!.isNotEmpty) {
                      return null;
                    } else {
                      return "Username is Mandatory";
                    }
                  },
                  input: TextInputType.name,
                  textAction: TextInputAction.next,
                ),
                CustomTextField(
                  isSvg: true,
                  svgasset: "assets/svg/password.svg",
                  isObscure: _isOldPasswordObscure,
                  controller: _passwordChangeOldPasswordController,
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
                    if (value!.isNotEmpty) {
                      return null;
                    } else {
                      return "Mandatory field";
                    }
                  },
                  hint: "Old Password",
                  input: TextInputType.name,
                  textAction: TextInputAction.done,
                ),
                CustomTextField(
                  isSvg: true,
                  svgasset: "assets/svg/password.svg",
                  isObscure: _isNewPasswordObscure,
                  controller: _passwordChangeNewPasswordController,
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
                Navigator.of(context).pop(false);
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
