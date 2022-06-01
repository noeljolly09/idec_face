
import 'package:drop_down_list/drop_down_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:idec_face/utility/extensions/string_utility.dart';
import 'package:intl/intl.dart';

import '../../../constants.dart';
import '../../../custom_widgets/custom_selection.dart';
import '../../../custom_widgets/text.dart';
import '../../../network/core/service_constants/service_constants.dart';
import '../../../network/core/service_response.dart';
import '../../../repositary/config_info_repository/providers/config_info_notifier_provider.dart';
import '../../../utility/connectivity/connectivity_constants.dart';
import '../../../utility/connectivity/connectivity_notifier_provider.dart';

class GenderPageRegistration extends ConsumerStatefulWidget {
  final TextEditingController dateinput;
  final TextEditingController gendervalue;
  final TextEditingController nationalityvalue;
  final TextEditingController bloodvalue;
  final String? Function(String?)? onValidate;

  const GenderPageRegistration({
    Key? key,
    required this.dateinput,
    required this.gendervalue,
    required this.nationalityvalue,
    required this.bloodvalue,
    this.onValidate,
  }) : super(key: key);

  @override
  _GenderPageRegistrationState createState() => _GenderPageRegistrationState();
}

class _GenderPageRegistrationState
    extends ConsumerState<GenderPageRegistration> {
  final List<SelectedListItem> _listOfgender = [];
  final List<SelectedListItem> _listOfnationality = [];
  final List<SelectedListItem> _listOfbloodgroups = [];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
      final networkStatus = ref.read(connectivityNotifierProvider).status;
      initListeners(networkStatus);
    });
  }

  @override
  Widget build(BuildContext context) {
    TextEditingController _searchcontroller = TextEditingController();
    double height30 = MediaQuery.of(context).size.height / 27.352;
    double height40 = MediaQuery.of(context).size.height / 20.514;

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SingleChildScrollView(
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          width: double.infinity,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height / 2,
                  width: MediaQuery.of(context).size.width / 1.111971924,
                  child: Column(
                    children: [
                      Container(height: height30),
                      const CustomTextWidget(
                        color: AppConstants.customblack,
                        size: 18,
                        text: 'Personal Details',
                        fontWeight: FontWeight.w600,
                        letterspacing: 1,
                      ),
                      Container(height: height30),
                      Container(
                        padding: const EdgeInsets.only(left: 10),
                        width: MediaQuery.of(context).size.width / 1.2,
                        child: TextField(
                          controller: widget.dateinput,
                          decoration: InputDecoration(
                            enabledBorder: const UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.grey),
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.grey.shade400),
                            ),
                            hintText: "DOB",
                            contentPadding: const EdgeInsets.all(10),
                            prefixIconConstraints: const BoxConstraints(
                                maxHeight: 30, maxWidth: 30),
                            prefixIcon: Container(
                              margin: const EdgeInsets.only(left: 5, right: 5),
                              child: SvgPicture.asset(
                                "assets/svg/calendar.svg",
                                color: AppConstants.customblack,
                                alignment: Alignment.center,
                              ),
                            ),
                          ),
                          readOnly: true,
                          onTap: () async {
                            DateTime? pickedDate = await showDatePicker(
                                context: context,
                                initialDate: DateTime.now(),
                                firstDate: DateTime(1998),
                                lastDate: DateTime(2100));

                            if (pickedDate != null) {
                              String formattedDate =
                                  DateFormat('dd-MM-yyyy').format(pickedDate);

                              setState(() {
                                widget.dateinput.text = formattedDate;
                              });
                            } else {
                              SnackBar; // to be implemented...
                            }
                          },
                        ),
                      ),
                      Container(height: height40),
                      // gender
                      Container(
                        padding: const EdgeInsets.only(left: 10),
                        width: MediaQuery.of(context).size.width / 1.2,
                        child: CustomSelectionBar(
                          circleSuffixIcon: false,
                          isSvg: true,
                          svgAsset: "assets/svg/gender.svg",
                          width: MediaQuery.of(context).size.width,
                          list: _listOfgender,
                          hinttext: "Gender",
                          searchhinttext: "Select your gender",
                          sheetTitle: "Gender",
                          controller: widget.gendervalue,
                          searchController: _searchcontroller,
                        ),
                      ),

                      Container(height: height40),
                      // nationality
                      Container(
                        padding: const EdgeInsets.only(left: 10),
                        width: MediaQuery.of(context).size.width / 1.2,
                        child: CustomSelectionBar(
                          circleSuffixIcon: false,
                          isSvg: true,
                          svgAsset: "assets/svg/nationality.svg",
                          width: MediaQuery.of(context).size.width,
                          list: _listOfnationality,
                          hinttext: "Nationality",
                          searchhinttext: "Search your nationality",
                          sheetTitle: "Nationality",
                          controller: widget.nationalityvalue,
                          searchController: _searchcontroller,
                        ),
                      ),
                      Container(height: height40),
                      //bloodgroup
                      Container(
                        padding: const EdgeInsets.only(left: 10),
                        width: MediaQuery.of(context).size.width / 1.2,
                        child: CustomSelectionBar(
                          circleSuffixIcon: false,
                          isSvg: true,
                          svgAsset: "assets/svg/blood.svg",
                          width: MediaQuery.of(context).size.width,
                          list: _listOfbloodgroups,
                          hinttext: "Blood Group",
                          searchhinttext: "Search your blood group",
                          sheetTitle: "Blood Group",
                          controller: widget.bloodvalue,
                          searchController: _searchcontroller,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  initListeners(ConnectionStatus networkStatus) {
    final configInfoResponse = ref.watch(configInfoNotifierProvider);
    // final configInfoResponse = next as ServiceResponse<ConfigResponse?>;
    if (configInfoResponse.status == ServiceStatus.completed) {
      if (configInfoResponse.data!.response!.isNotEmpty) {
        for (var element in configInfoResponse.data!.response!) {
          if (element.value!.genderResponse != null) {
            for (var item in element.value!.genderResponse!) {
              _listOfgender.add(SelectedListItem(false, item.name!.capitalize));
            }
          }
        }
      }
    } else if (configInfoResponse.status == ServiceStatus.error) {
      if (networkStatus == ConnectionStatus.offline) {
      } else if (configInfoResponse.errorCode ==
          ServiceErrorCode.unauthorized) {
      } else if (configInfoResponse.errorCode == ServiceErrorCode.timeOut) {
      } else {}
    }

    //bloodgroup

    if (configInfoResponse.status == ServiceStatus.completed) {
      if (configInfoResponse.data!.response!.isNotEmpty) {
        for (var element in configInfoResponse.data!.response!) {
          if (element.value!.bloodGrpResponse != null) {
            for (var item in element.value!.bloodGrpResponse!) {
              _listOfbloodgroups
                  .add(SelectedListItem(false, item.value!.capitalize));
            }
          }
        }
      }
    } else if (configInfoResponse.status == ServiceStatus.error) {
      if (networkStatus == ConnectionStatus.offline) {
      } else if (configInfoResponse.errorCode ==
          ServiceErrorCode.unauthorized) {
      } else if (configInfoResponse.errorCode == ServiceErrorCode.timeOut) {
      } else {}
    }

    // // nationality

    if (configInfoResponse.status == ServiceStatus.completed) {
      if (configInfoResponse.data!.response!.isNotEmpty) {
        for (var element in configInfoResponse.data!.response!) {
          if (element.value!.nationalityResponse != null) {
            for (var item in element.value!.nationalityResponse!) {
              _listOfnationality
                  .add(SelectedListItem(false, item.name!.capitalize));
            }
          }
        }
      }
    } else if (configInfoResponse.status == ServiceStatus.error) {
      if (networkStatus == ConnectionStatus.offline) {
      } else if (configInfoResponse.errorCode ==
          ServiceErrorCode.unauthorized) {
      } else if (configInfoResponse.errorCode == ServiceErrorCode.timeOut) {
      } else {}
    }
  }
}
