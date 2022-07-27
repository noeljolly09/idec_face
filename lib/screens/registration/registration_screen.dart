import 'dart:io';

import 'package:country_list_pick/country_list_pick.dart';
import 'package:drop_down_list/drop_down_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:idec_face/dialogs/loader_dialog.dart';
import 'package:idec_face/models/client_details.dart';
import 'package:idec_face/models/config/config_request.dart';
import 'package:idec_face/models/config/config_response.dart';
import 'package:idec_face/models/registration/client_details_response.dart';
//
import 'package:idec_face/models/registration/registration_request.dart'
    as registrationrequest;
import 'package:idec_face/models/registration/registration_response.dart';
import 'package:idec_face/repository/config_info_repository/providers/config_info_notifier_provider.dart';
import 'package:idec_face/repository/registration_info_repositary/providers/registration_info_notifier_provider.dart';
import 'package:idec_face/screens/registration/widgets/domain_data.dart';
import 'package:idec_face/screens/registration/widgets/name_data.dart';
import 'package:idec_face/screens/registration/widgets/preview_dialog.dart';
import 'package:idec_face/utility/extensions/string_utility.dart';
import 'package:image_picker/image_picker.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../constants.dart';
import '../../custom_widgets/button.dart';
import '../../custom_widgets/text.dart';
import '../../dialogs/image_fullscreen_dialog.dart';
import '../../dialogs/info_dialog/dialog_with_timer.dart';
import '../../models/media_upload/media_response.dart';
import '../../network/service_umbrella.dart';
import '../../repository/media_repository/providers/media_notifier_provider.dart';
import '../../utility/app_info.dart';
import '../../utility/connectivity/connectivity_constants.dart';
import '../../utility/connectivity/connectivity_notifier_provider.dart';

import 'notifiers/media_state_notifier/media_upload_notifier.dart';
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

  CountryCode? code = CountryCode(
      dialCode: "+91", name: "India", code: "IN", flagUri: "flags/in.png");
  final TextEditingController _genderController = TextEditingController();
  final TextEditingController _nationalityController = TextEditingController();
  final TextEditingController _bloodController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _commentsController = TextEditingController();
  final Map<String, String> _domainList = {};
  File? _tempImageFile;
  XFile? _tempImgFile;
  String? imageSasUrl;
  bool isMediaDeleting = false;

  final ImagePicker _picker = ImagePicker();
  static const cameraPermissionChannel =
      MethodChannel("com.camera.cameraPermission");

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
    imageSasUrl = null;
    _tempImageFile = null;
    super.dispose();
  }

  void _getClientDetails() {
    ref.read(clientInfoNotifierProvider.notifier).getClientInfo();
  }

  void _getConfigAttributes() {
    final configInfoRequest = ConfigInfoRequest(
        configAttributes: ["gender", "nationality", "bloodGroup"]);
    ref
        .read(configInfoNotifierProvider.notifier)
        .getConfigAttributes(configInfoRequest);
  }

  void _registerUserAttributes() {
    String tenantId;
    if (_domainList.keys
        .contains(_domainController.text.trim().toUpperCase())) {
      tenantId = _domainList[_domainController.text.trim().toUpperCase()]!;
      final registrationInfoRequest =
          registrationrequest.RegistrationInfoRequest(
        userDetails: registrationrequest.UserDetails(
          tenantId: tenantId,
          organisation: _domainController.text,
          //
          personal: registrationrequest.Personal(dob: _dateinput.text),
          //
          phone: registrationrequest.Phone(
            countryCode: code.toString(),
            number: _phoneController.text,
          ),
          email: _emailController.text,
          empId: _idController.text,
          image: imageSasUrl,
          name: registrationrequest.Name(
              first: _fnameController.text,
              middle: _mnameController.text,
              last: _lnameController.text),
        ),
      );
      ref
          .read(registrationInfoNotifierProvider.notifier)
          .getregistrationattributes(
            registrationInfoRequest,
            tenantId,
          );
    }
  }

  String? customValidator(String? fieldContent) =>
      fieldContent!.isEmpty ? 'This is required field' : null;

  //getCameraPermission
  Future<bool> getCameraPermission() async {
    bool isPermissionAllowed = false;
    if (Platform.isAndroid) {
      try {
        isPermissionAllowed =
            await cameraPermissionChannel.invokeMethod('camera_permission');
      } on Exception catch (e) {
        print(e.toString());
      }
    } else if (Platform.isIOS) {
      try {
        cameraPermissionChannel.invokeMethod('camera_permission');
      } on Exception catch (e) {
        print(e.toString());
      }
    }
    return isPermissionAllowed;
  }

  void _showImagePicker() {
    final _imageFile = ref.watch(imageNotifier).getImageFile;
    showModalBottomSheet(
      context: context,
      builder: (BuildContext bc) {
        return SafeArea(
          child: _imageFile == null
              ? Wrap(
                  children: <Widget>[
                    ListTile(
                        contentPadding: const EdgeInsets.only(left: 130),
                        leading: const Icon(Icons.photo_library),
                        title: const Text('Photo Library',
                            style: TextStyle(
                              fontSize: 20,
                            )),
                        onTap: () {
                          _imgFromGallery();
                          Navigator.of(context).pop();
                        }),
                    ListTile(
                      contentPadding:
                          const EdgeInsets.only(left: 130, bottom: 20),
                      leading: const Icon(Icons.photo_camera),
                      title: const Text('Camera',
                          style: TextStyle(
                            fontSize: 20,
                          )),
                      onTap: () {
                        Navigator.of(context).pop();
                        _imgFromCamera();
                      },
                    ),
                  ],
                )
              : Wrap(
                  children: <Widget>[
                    ListTile(
                        leading: const Icon(Icons.photo),
                        title: const Text('View Photo'),
                        onTap: () async {
                          Navigator.of(context).pop();
                          await showDialog(
                              context: context,
                              builder: (_) => ImageDialog(
                                    imageFile: File(_imageFile.path),
                                  ));
                        }),
                    ListTile(
                      leading: const Icon(Icons.remove_circle_outline),
                      title: const Text('Remove Photo'),
                      onTap: () async {
                        Navigator.of(context).pop();
                        isMediaDeleting = true;
                        ref
                            .read(mediaNotifierProvider.notifier)
                            .uploadImageDetails(
                                isDelete: true, imageurl: imageSasUrl);
                        ref.read(imageNotifier).updateImage(image: null);
                      },
                    ),
                  ],
                ),
        );
      },
    );
  }

  _imgFromCamera() async {
    _tempImgFile = await _picker.pickImage(
      source: ImageSource.camera,
      preferredCameraDevice: CameraDevice.rear,
    );
    if (_tempImgFile != null) {
      _tempImageFile = File(_tempImgFile!.path);
      ref.read(imageNotifier).updateImage(image: _tempImageFile);
      ref.read(mediaNotifierProvider.notifier).uploadImageDetails(
            imageFile: _tempImageFile,
          );
      isMediaDeleting = false;
    }
  }

  _imgFromGallery() async {
    XFile? galleryPhoto =
        await _picker.pickImage(source: ImageSource.gallery, imageQuality: 70);
    if (galleryPhoto != null) {
      _tempImageFile = File(galleryPhoto.path);
      ref.read(imageNotifier).updateImage(image: _tempImageFile);

      ref
          .read(mediaNotifierProvider.notifier)
          .uploadImageDetails(imageFile: File(_tempImageFile!.path));

      isMediaDeleting = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    double height20 = MediaQuery.of(context).size.height / 42.02;
    double height78 = MediaQuery.of(context).size.height / 9.97;

    final networkStatus = ref.read(connectivityNotifierProvider).status;

    //config api
    initConfigListeners(networkStatus);

    //client Info
    initClientDetailsListeners(networkStatus);

    // registration api
    initRegistrationListeners(networkStatus);

    // profile image upload
    mediaUploadInit(context);

    return WillPopScope(
      onWillPop: () async {
        ref.read(imageNotifier).updateImage(image: null);
        return true;
      },
      child: SafeArea(
        child: Form(
          key: _formKey,
          child: Scaffold(
            resizeToAvoidBottomInset: false,
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            body: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(height: AppConstants.abovecoldtruthheight),
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
                              text: " COLD",
                              style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  color: AppConstants.primaryColor)),
                          TextSpan(text: 'TRUTH', style: TextStyle())
                        ],
                      ),
                    )
                  ],
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
                            _emailController.text.isValidEmail.isNotEmpty ||
                            !_domainList.keys.contains(
                                _domainController.text.trim().toUpperCase())) {
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
                              domainList: _domainList.keys.toList(),
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
                        onPressed: () async {
                          if (networkStatus == ConnectionStatus.online) {
                            bool isCameraPermissionAllowed =
                                await getCameraPermission();
                            if (isCameraPermissionAllowed) {
                              _showImagePicker();
                            }
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
                                message: "No Internet Connectivity",
                              ),
                            );
                          }
                        },
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
                                  _emailController
                                      .text.isValidEmail.isNotEmpty ||
                                  !_domainList.keys.contains(
                                    _domainController.text.trim().toUpperCase(),
                                  )) {
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
                                  domainList: _domainList.keys.toList(),
                                  formHeader: "Validation Error!",
                                );
                              } else {
                                _registerUserAttributes();
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
                  SizedBox(height: screenHeight(context, dividedBy: 80)),
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
                            ref.read(imageNotifier).updateImage(image: null);
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
                        onTap: () async {
                          await launchUrl(Uri.parse(
                              "https://idecobserverappdev.azurewebsites.net/#/policy"));
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
      ),
    );
  }

  initClientDetailsListeners(ConnectionStatus networkStatus) {
    ref.listen(clientInfoNotifierProvider, (previous, next) {
      final clientsInfoResponse =
          next as ServiceResponse<ClientDetailsResponse?>;
      if (clientsInfoResponse.status == ServiceStatus.loading) {
        customLoaderDialog(context);
      } else if (clientsInfoResponse.status == ServiceStatus.completed) {
        Navigator.pop(context);
        if (clientsInfoResponse.data!.response!.response!.isNotEmpty) {
          List<ClientDetailsModel> _list = [];
          for (var item in clientsInfoResponse.data!.response!.response!) {
            _domainList[item.domain!..trim().toUpperCase()] = item.id!;
          }

          ref.read(registrationNotifier).updatelistofClients(value: _list);
        }
      } else if (clientsInfoResponse.status == ServiceStatus.error) {
        Navigator.pop(context);
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
            message: "Unable to fetch Data.",
          ),
        );
      }
    });
  }

  initRegistrationListeners(ConnectionStatus networkStatus) {
    try {
      ref.listen(registrationInfoNotifierProvider, (previous, next) {
        final registrationInfoResponse =
            next as ServiceResponse<RegistrationResponse?>;
        if (registrationInfoResponse.status == ServiceStatus.loading) {
         customLoaderDialog(context);
        } else if (registrationInfoResponse.status == ServiceStatus.completed) {
          ref.read(imageNotifier).updateImage(image: null);
          Navigator.pop(context);
          if (registrationInfoResponse.data!.status == true) {
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
                  title: "Registration",
                  message: registrationInfoResponse.data!.response!.message
                      .toString()),
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
                title: "Validation Error",
                message:
                    registrationInfoResponse.data!.response!.error.toString(),
              ),
            );
          }
        } else if (registrationInfoResponse.status == ServiceStatus.error) {
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
    } catch (e) {
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

  void mediaUploadInit(BuildContext context) {
    ref.listen(mediaNotifierProvider, (previous, next) {
      try {
        final response = next as ServiceResponse<MediaResponse?>;

        if (response.status == ServiceStatus.loading) {
         customLoaderDialog(context);
        } else if (response.status == ServiceStatus.completed) {
          Navigator.pop(context);
          if (response.data?.status ?? false) {
            if (isMediaDeleting) {
              ref.read(imageNotifier).updateImage(image: null);
              imageSasUrl = null;
              _tempImageFile = null;
            } else {
              ref.read(imageNotifier).updateImage(image: _tempImageFile);
              imageSasUrl = response.data!.response!.sasUrl;
            }
          } else {
            if (!isMediaDeleting) {
              ref.read(imageNotifier).updateImage(image: null);
              _tempImageFile = null;
            }
            imageSasUrl = null;
          }
        } else if (response.status == ServiceStatus.error) {
          imageSasUrl = null;
          if (!isMediaDeleting) {
            ref.read(imageNotifier).updateImage(image: null);
            _tempImageFile = null;
          }
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
      } catch (e) {
        if (!isMediaDeleting) {
          ref.read(imageNotifier).updateImage(image: null);
          _tempImageFile = null;
        }
      }
    });
  }
}
