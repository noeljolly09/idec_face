import 'dart:io';

import 'package:drop_down_list/drop_down_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:idec_face/constants.dart';
import 'package:http/http.dart' as http;
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
import 'package:idec_face/models/people_profile/user_update_response.dart';
import 'package:idec_face/network/core/service_response.dart';
import 'package:idec_face/repository/check_username_availabilty/providers/check_username_availability_notifier_provider.dart';
import 'package:idec_face/repository/config_info_repository/providers/config_info_notifier_provider.dart';
import 'package:idec_face/repository/people_profile/providers/people_profile_notifier_provider.dart';
import 'package:idec_face/screens/people_profile/notifiers/people_profile_notfier.dart';
import 'package:idec_face/screens/registration/notifiers/registration_notifiers.dart';
import 'package:idec_face/utility/connectivity/connectivity_constants.dart';
import 'package:idec_face/utility/connectivity/connectivity_notifier_provider.dart';
import 'package:idec_face/utility/extensions/date_utility.dart';
import 'package:idec_face/utility/extensions/string_utility.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

import '../../custom_widgets/country_code_picker.dart';
import '../../custom_widgets/textfields/text_icon_only_textfield.dart';
import '../../dialogs/image_fullscreen_dialog.dart';
import '../../models/media_upload/media_response.dart';
import '../../models/people_profile/all_employees_response.dart';
import '../../models/people_profile/profile_approval_request.dart' as approval;
import '../../network/core/service_constants/service_constants.dart';
import '../../repository/media_repository/providers/media_notifier_provider.dart';
import '../../utility/shared_pref/provider/shared_pref_provider.dart';
import '../registration/notifiers/media_state_notifier/media_upload_notifier.dart';

class ProfileApprovalPage extends ConsumerStatefulWidget {
  final int employeeIndex;
  final List<UserData> empList;
  final String state;
  const ProfileApprovalPage({
    Key? key,
    required this.empList,
    required this.employeeIndex,
    required this.state,
  }) : super(key: key);

  @override
  _ProfileApprovalPageState createState() => _ProfileApprovalPageState();
}

class _ProfileApprovalPageState extends ConsumerState<ProfileApprovalPage> {
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
  TextEditingController genderSearchController = TextEditingController();
  TextEditingController privilageController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController remarkController = TextEditingController();
  GlobalKey<FormState> formGlobalKey = GlobalKey<FormState>();
  List<SelectedListItem> _listOfgender = [];
  List<SelectedListItem> _listOfnationality = [];
  List<SelectedListItem> _listOfbloodgroups = [];
  List<SelectedListItem> _listOftrade = [];
  List<SelectedListItem> _listofRoles = [];
  Map<String, String> tradeMapList = {};
  Map<String, String> roleMapList = {};
  List<SelectedListItem> listofPrivildges = [
    SelectedListItem(false, "Admin L2")
  ];

  File? _tempImageFile;
  XFile? _tempImgFile;

  bool isMediaDeleting = false;

  final ImagePicker _picker = ImagePicker();
  static const cameraPermissionChannel =
      MethodChannel("com.camera.cameraPermission");

  bool isConfigreceived = false;
  bool isUserCredentialGenerated = false;
  String? countryCode = "+91";
  String? image;
  bool? isRejected = false;
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _getConfigAttributes();
      _getTradeAttributes();
      _getRoleAttributes();
      var data = widget.empList[widget.employeeIndex];
      firstNameController.text = data.name!.first!;
      middleNameController.text =
          data.name!.middle == null ? "" : data.name!.middle!;
      lastNameController.text = data.name!.last!;
      employeeIdController.text = data.empId == null ? "" : data.empId!;
      if (data.personal != null) {
        if (data.personal!.dob != null) {
          dateinput.text = data.personal!.dob!.formatDateWithoutTime;
        }
        if (data.personal!.bloodGroup != null) {
          bloodgroupController.text =
              data.personal!.bloodGroup ?? data.personal!.bloodGroup!;
        }
        if (data.personal!.gender != null) {
          genderController.text =
              data.personal!.gender ?? data.personal!.gender!;
        }
        if (data.personal!.nationality != null) {
          nationalityController.text =
              data.personal!.nationality ?? data.personal!.nationality!;
        }
      }
      if (data.phone != null) {
        if (data.phone!.number != null) {
          phoneController.text = data.phone!.number.toString();
        }
        countryCode = countryCode ?? countryCode;
      }
      emailController.text = data.email ?? data.email!;

      if (data.image != null) {
        ref.read(imageNotifier).updateImageUrl(image: data.image);
        image = data.image;
      }
    });

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

  getImage(String? profileImage) async {
    if (profileImage != null && profileImage != '') {
      var client = http.Client();
      try {
        http.Response? uriResponse = await client.get(Uri.parse(profileImage));
        if (uriResponse.statusCode == 200) {
          if (uriResponse.bodyBytes != null) {
            if (uriResponse.bodyBytes.isNotEmpty) {
              return uriResponse.bodyBytes;
            }
          }
        }
        image = null;
        ref.read(imageNotifier).updateImageUrl(image: null);
        ref.read(imageNotifier).updateImage(image: null);
        return null;
      } catch (e) {
        print(e);

        return null;
      } finally {
        client.close();
      }
    } else {
      return null;
    }
  }

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
    }
    return isPermissionAllowed;
  }

  void _showImagePicker() {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext bc) {
        return SafeArea(
          child: image == null
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
                                    imageUrl: image,
                                    isImageNetwork: true,
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
                                isDelete: true, imageurl: image);
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
      isMediaDeleting = false;
      ref
          .read(mediaNotifierProvider.notifier)
          .uploadImageDetails(imageFile: File(_tempImageFile!.path));
    }
  }

  _imgFromGallery() async {
    XFile? galleryPhoto =
        await _picker.pickImage(source: ImageSource.gallery, imageQuality: 70);
    if (galleryPhoto != null) {
      _tempImageFile = File(galleryPhoto.path);

      ref
          .read(mediaNotifierProvider.notifier)
          .uploadImageDetails(imageFile: File(_tempImageFile!.path));

      isMediaDeleting = false;
    }
  }

  void profileApprovalRequest(String approvalStatus) {
    final response =
        ref.read(sharedPrefUtilityProvider).getLoggedInPriviledgeUserDetails();

    final profileApprovalRequest = approval.ProfileApprovalRequest(
      employeeDetails: approval.EmployeeDetails(
        name: approval.Name(
            first: firstNameController.text,
            middle: middleNameController.text.isEmpty
                ? null
                : middleNameController.text,
            last: lastNameController.text),
        empId: employeeIdController.text,
        phone: approval.Phone(
          countryCode: countryCode,
          number: phoneController.text.isEmpty ? null : phoneController.text,
        ),
        personal: approval.Personal(
          bloodGroup: bloodgroupController.text.isEmpty
              ? null
              : bloodgroupController.text,
          dob: dateinput.text.isEmpty ? null : dateinput.text,
          gender: genderController.text.isEmpty ? null : genderController.text,
          nationality: nationalityController.text.isEmpty
              ? null
              : nationalityController.text,
        ),
        email: emailController.text,
        image: image,
        userName: isUserCredentialGenerated ? usernameController.text : null,
        userGroup:
            isUserCredentialGenerated ? "5f9aab55c218ff12938c251f" : null,
        remarks: remarkController.text,
        roleId: roleMapList[roleController.text.toLowerCase()],
        tradeId: tradeMapList[tradeController.text.toLowerCase()],
      ),
      userId: widget.empList[widget.employeeIndex].id,
      action: "validate",
      registrationStatus: approvalStatus,
    );
    ref.read(profileUpdateNotiferProvider.notifier).profileUpdateRequest(
        profileApprovalRequest,
        tenantId: response!.response!.data!.first.tenants!.id!);
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
    String? imageUrl = ref.watch(imageNotifier).getImageUrl;
    File? _imageFile = ref.watch(imageNotifier).getImageFile;
    //config api
    initConfigListeners(networkStatus);
    //trade api
    initTradeListeners(networkStatus);
    //role api
    initRoleListeners(networkStatus);
    //username availability
    initCheckUsernameAvailabilityListeners(networkStatus);
    mediaUploadInit(context);
    profileUpdateInitListener(networkStatus);
    //
    return Scaffold(
      appBar: customAppBar("Validate Profile"),
      body: Form(
        key: formGlobalKey,
        child: SingleChildScrollView(
            child: Column(
          children: [
            const SizedBox(height: 30),
            Stack(
              children: [
                _imageFile != null
                    ? CircleAvatar(
                        radius: 60,
                        backgroundColor: Colors.grey,
                        foregroundImage:
                            Image.file(File(_imageFile.path)).image,
                        onForegroundImageError: (exception, stackTrace) {},
                      )
                    : FutureBuilder<dynamic>(
                        future: getImage(imageUrl),
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            return CircleAvatar(
                              radius: 50,
                              backgroundColor: Colors.grey,
                              foregroundImage: Image.network(
                                imageUrl!,
                              ).image,
                              onForegroundImageError:
                                  (exception, stackTrace) {},
                            );
                          }
                          return SvgPicture.asset(
                            'assets/svg/User_big.svg',
                            height: 80,
                          );
                        },
                      ),
                Positioned(
                  bottom: 5,
                  right: 5,
                  child: IconButton(
                      padding: const EdgeInsets.all(0),
                      alignment: Alignment.bottomRight,
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
                      icon: image == null
                          ? const Icon(Icons.add_a_photo_outlined)
                          : const Icon(
                              Icons.no_photography_outlined,
                            )),
                ),
              ],
            ),
            CustomPendingApprovalTextField(
              controller: firstNameController,
              label: "First Name*",
              assetName: "assets/svg/user.svg",
              validator: (value) {
                if (value!.isEmptyValidate.isEmpty) {
                  return null;
                } else {
                  return value.isEmptyValidate;
                }
              },
            ),
            CustomPendingApprovalTextField(
              controller: middleNameController,
              label: "Middle Name",
            ),
            CustomPendingApprovalTextField(
              controller: lastNameController,
              label: "Last Name*",
              validator: (value) {
                if (value!.isEmptyValidate.isEmpty) {
                  return null;
                } else {
                  return value.isEmptyValidate;
                }
              },
            ),
            CustomPendingApprovalTextField(
              controller: employeeIdController,
              isreadOnly: employeeIdController.text.isNotEmpty,
              label: "Employee Id*",
              assetName: "assets/svg/useriD.svg",
              validator: (value) {
                if (value!.isEmptyValidate.isEmpty) {
                  return null;
                } else {
                  return value.isEmptyValidate;
                }
              },
            ),
            Container(
              margin: const EdgeInsets.only(left: 20, right: 20, top: 5),
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
                    initialDate: dateinput.text.isEmpty
                        ? DateTime.now()
                        : DateTime.parse(dateinput.text),
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
              margin: const EdgeInsets.only(left: 20, right: 20, top: 5),
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
                searchController: bloodgroupController,
                isConfigreceived: isConfigreceived,
              ),
            ),
            Container(
              margin: const EdgeInsets.only(left: 20, right: 20, top: 5),
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
                searchController: roleController,
                isConfigreceived: isConfigreceived,
                validator: (value) {
                  if (value!.isEmptyValidate.isEmpty) {
                    return null;
                  } else {
                    return value.isEmptyValidate;
                  }
                },
              ),
            ),
            Container(
              margin: const EdgeInsets.only(left: 20, right: 20, top: 5),
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
                searchController: tradeController,
                isConfigreceived: isConfigreceived,
                validator: (value) {
                  if (value!.isEmptyValidate.isEmpty) {
                    return null;
                  } else {
                    return value.isEmptyValidate;
                  }
                },
              ),
            ),
            Container(
              margin: const EdgeInsets.only(left: 20, right: 20, top: 5),
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
              margin: const EdgeInsets.only(left: 20, right: 20, top: 5),
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
                searchController: nationalityController,
                isConfigreceived: isConfigreceived,
              ),
            ),
            Container(
              margin: const EdgeInsets.only(left: 20, right: 20, top: 5),
              child: Row(
                children: [
                  Container(
                    margin: const EdgeInsets.only(top: 8),
                    decoration: const BoxDecoration(
                      border: Border(
                        bottom: BorderSide(width: 1.0, color: Colors.grey),
                      ),
                    ),
                    child: Row(
                      children: [
                        SvgPicture.asset(
                          "assets/svg/phone.svg",
                          width: 25,
                          height: 25,
                          color: AppConstants.customblack,
                          alignment: Alignment.center,
                        ),
                        Container(
                          margin: const EdgeInsets.only(bottom: 0),
                          width: MediaQuery.of(context).size.width / 4,
                          height: 50,
                          child: CustomCountryCodePicker(
                            changeCountryCode: (value) {},
                            countryCode: countryCode,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SimpleTextField(
                    hint: "Phone Number ",
                    controller: phoneController,
                    // validator: phoneNumberValidate,
                    textAction: TextInputAction.next,
                    input: TextInputType.number,
                    textorflex: false,
                  ),
                ],
              ),
            ),
            CustomPendingApprovalTextField(
              controller: emailController,
              label: "Email*",
              assetName: "assets/svg/useriD.svg",
              validator: (value) {
                if (value!.isValidEmail.isEmpty) {
                  return null;
                } else {
                  return value.isValidEmail;
                }
              },
            ),
            Container(
              margin: const EdgeInsets.only(
                right: 20,
              ),
              child: CheckboxListTile(
                title: const Text("Generate User Credentials"),
                contentPadding: const EdgeInsets.only(left: 10),
                value: isUserCredentialGenerated,
                onChanged: (value) {
                  if (value!) {
                    ref
                        .read(peopleProfileNotifier)
                        .updatecheckavailabilityState(value: "check");
                    ref
                        .read(peopleProfileNotifier)
                        .updatecheckavailabilityButtonState(value: false);
                  }
                  setState(() {
                    isUserCredentialGenerated = value;
                  });
                },
                controlAffinity: ListTileControlAffinity.leading,
              ),
            ),
            isUserCredentialGenerated == true
                ? Column(
                    children: [
                      Row(
                        children: [
                          Expanded(
                            flex: 3,
                            child: CustomPendingApprovalTextField(
                              label: "Username",
                              controller: usernameController,
                              assetName: "assets/svg/useriD.svg",
                              validator: (value) {
                                if (value!.isEmptyValidate.isEmpty) {
                                  return null;
                                } else {
                                  return value.isEmptyValidate;
                                }
                              },
                            ),
                          ),
                          Flexible(
                            child: ElevatedButton(
                              onPressed: () {
                                if (usernameController.text.isNotEmpty) {
                                  _getCheckAvailabilityAttributes();
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
                                      title: "Info",
                                      message: "Please enter Username",
                                    ),
                                  );
                                }
                              },
                              child: Text(availablityButtonText,
                                  textAlign: TextAlign.center),
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
                          controller: privilageController,
                          searchController: privilageController,
                          isConfigreceived: isConfigreceived,
                          validator: (value) {
                            if (value!.isEmptyValidate.isEmpty) {
                              return null;
                            } else {
                              return value.isEmptyValidate;
                            }
                          },
                        ),
                      ),
                    ],
                  )
                : const SizedBox(),
            Container(
              margin: const EdgeInsets.only(
                left: 20,
                right: 20,
              ),
              child: TextFormField(
                style: TextStyle(
                  fontSize: AppConstants.formtextsize,
                  fontStyle: FontStyle.normal,
                ),
                controller: remarkController,
                decoration: InputDecoration(
                    label: const Text("Leave a comment"),
                    labelStyle: TextStyle(color: AppConstants.labeltextgrey),
                    floatingLabelStyle:
                        const TextStyle(color: AppConstants.customblack),
                    contentPadding: const EdgeInsets.only(bottom: 5),
                    prefixIconConstraints:
                        const BoxConstraints(maxHeight: 50, maxWidth: 50),
                    prefixIcon: Container(
                      margin: const EdgeInsets.only(right: 20),
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
                      borderSide:
                          BorderSide(color: AppConstants.secondaryColor),
                    )),
                keyboardType: TextInputType.multiline,
                textInputAction: TextInputAction.done,
                textAlign: TextAlign.start,
                maxLines: 3,
                validator: (value) {
                  if (isRejected!) {
                    if (value!.isEmptyValidate.isEmpty) {
                      return null;
                    } else {
                      return value.isEmptyValidate;
                    }
                  } else {
                    return null;
                  }
                },
              ),
            ),
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
                Visibility(
                  visible: widget.state == "pending",
                  child: ElevatedButton(
                      onPressed: () {
                        isRejected = true;
                        if (formGlobalKey.currentState!.validate()) {
                          profileApprovalRequest("rejected");
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
                              title: "Info",
                              message: "Please enter mandatory fields",
                            ),
                          );
                        }
                      },
                      child: const Text('Reject')),
                ),
                const SizedBox(width: 30),
                ElevatedButton(
                  onPressed: () {
                    isRejected = false;
                    if (formGlobalKey.currentState!.validate()) {
                      profileApprovalRequest("accept");
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
                          title: "Info",
                          message: "Please enter mandatory fields",
                        ),
                      );
                    }
                  },
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
      ),
    );
  }

  profileUpdateInitListener(ConnectionStatus networkStatus) {
    ref.listen(profileUpdateNotiferProvider, ((previous, next) {
      final profileUpdateResponse =
          next as ServiceResponse<ProfileApprovalResponse?>;

      if (profileUpdateResponse.status == ServiceStatus.loading) {
        showDialog(
            context: context,
            barrierDismissible: false,
            builder: (context) => const SpinKitCircle(
                  color: AppConstants.primaryColor,
                ));
      } else if (profileUpdateResponse.status == ServiceStatus.completed) {
        Navigator.pop(context);
      } else if (profileUpdateResponse.status == ServiceStatus.error) {
        Navigator.of(context).pop(false);
        if (profileUpdateResponse.errorCode == ServiceErrorCode.unauthorized) {
          ref.read(sharedPrefUtilityProvider).resetPreference();

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
    }));
  }

  initRoleListeners(ConnectionStatus networkStatus) {
    ref.listen(roleInfoNotifierProvider, ((previous, next) {
      final roleInfoResponse = next as ServiceResponse<RoleListResponse?>;

      if (roleInfoResponse.status == ServiceStatus.loading) {
      } else if (roleInfoResponse.status == ServiceStatus.completed) {
        List<SelectedListItem> _listofRoles = [];
        roleMapList = {};
        if (roleInfoResponse.data!.response!.data!.isNotEmpty) {
          for (var element in roleInfoResponse.data!.response!.data!) {
            roleMapList[element.roleName!.toLowerCase()] = element.id!;

            _listofRoles
                .add(SelectedListItem(false, element.roleName!.capitalize));
          }
          ref.read(peopleProfileNotifier).updatelistofRole(value: _listofRoles);
        }
      } else if (roleInfoResponse.status == ServiceStatus.error) {
        Navigator.of(context).pop(false);
        if (roleInfoResponse.errorCode == ServiceErrorCode.unauthorized) {
          ref.read(sharedPrefUtilityProvider).resetPreference();

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
    }));
  }

  initCheckUsernameAvailabilityListeners(ConnectionStatus networkStatus) {
    ref.listen(checkAvailabitlityInfoNotifierProvider, ((previous, next) {
      final availabiltiyInfoResponse =
          next as ServiceResponse<CheckAvailabiltyResponse?>;

      if (availabiltiyInfoResponse.status == ServiceStatus.loading) {
        showDialog(
            context: context,
            barrierDismissible: false,
            builder: (context) => const SpinKitCircle(
                  color: AppConstants.primaryColor,
                ));
      } else if (availabiltiyInfoResponse.status == ServiceStatus.completed) {
        Navigator.pop(context);
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
        Navigator.of(context).pop(false);
        if (availabiltiyInfoResponse.errorCode ==
            ServiceErrorCode.unauthorized) {
          ref.read(sharedPrefUtilityProvider).resetPreference();

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
    }));
  }

  initTradeListeners(ConnectionStatus networkStatus) {
    ref.listen(tradeInfoNotifierProvider, ((previous, next) {
      final tradeInfoResponse = next as ServiceResponse<TradeListResponse?>;

      if (tradeInfoResponse.status == ServiceStatus.loading) {
      } else if (tradeInfoResponse.status == ServiceStatus.completed) {
        List<SelectedListItem> _listOftrade = [];
        tradeMapList = {};
        if (tradeInfoResponse.data!.response!.data!.isNotEmpty) {
          for (var element in tradeInfoResponse.data!.response!.data!) {
            tradeMapList[element.tradeName!.toLowerCase()] = element.id!;
            _listOftrade
                .add(SelectedListItem(false, element.tradeName!.capitalize));
          }
          ref
              .read(peopleProfileNotifier)
              .updatelistofTrade(value: _listOftrade);
        }
      } else if (tradeInfoResponse.status == ServiceStatus.error) {
        Navigator.of(context).pop(false);
        if (tradeInfoResponse.errorCode == ServiceErrorCode.unauthorized) {
          ref.read(sharedPrefUtilityProvider).resetPreference();

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
        Navigator.of(context).pop(false);
        if (configInfoResponse.errorCode == ServiceErrorCode.unauthorized) {
          ref.read(sharedPrefUtilityProvider).resetPreference();

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
    }));
  }

  void mediaUploadInit(BuildContext context) {
    ref.listen(mediaNotifierProvider, (previous, next) {
      try {
        final response = next as ServiceResponse<MediaResponse?>;

        if (response.status == ServiceStatus.loading) {
          showDialog(
              context: context,
              barrierDismissible: false,
              builder: (context) => const SpinKitCircle(
                    color: AppConstants.primaryColor,
                  ));
        } else if (response.status == ServiceStatus.completed) {
          Navigator.pop(context);
          if (response.data?.status ?? false) {
            if (isMediaDeleting) {
              ref.read(imageNotifier).updateImageUrl(image: null);
              ref.read(imageNotifier).updateImage(image: null);
              image = null;
              _tempImageFile = null;
            } else {
              image = response.data!.response!.sasUrl;
              ref.read(imageNotifier).updateImageUrl(image: image);
              ref.read(imageNotifier).updateImage(image: _tempImageFile);
            }
          } else {
            if (!isMediaDeleting) {
              ref.read(imageNotifier).updateImageUrl(image: null);
              ref.read(imageNotifier).updateImage(image: null);
              _tempImageFile = null;
            }
          }
        } else if (response.status == ServiceStatus.error) {
          if (response.errorCode == ServiceErrorCode.unauthorized) {
            ref.read(sharedPrefUtilityProvider).resetPreference();

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
          } else {
            image = null;
            if (!isMediaDeleting) {
              ref.read(imageNotifier).updateImageUrl(image: null);
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
        }
      } catch (e) {
        if (!isMediaDeleting) {
          ref.read(imageNotifier).updateImageUrl(image: null);
          ref.read(imageNotifier).updateImage(image: null);
          _tempImageFile = null;
        }
      }
    });
  }
}
