// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:drop_down_list/drop_down_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/svg.dart';

import '../constants.dart';
import '../models/config/config_request.dart';
import '../repository/config_info_repository/providers/config_info_notifier_provider.dart';

class CustomSelectionBar extends ConsumerStatefulWidget {
  final TextEditingController controller;
  final TextEditingController searchController;
  final String? searchhinttext;
  final String? hinttext;
  final double width;
  final bool isSvg;
  final bool isCircleSuffixIcon;
  final bool? isCircleSearchIcon;
  final String svgAsset;
  final String? sheetTitle;
  final String? Function(String?)? validator;
  final List<SelectedListItem> list;
  final bool isConfigreceived;

  const CustomSelectionBar({
    Key? key,
    required this.controller,
    required this.searchController,
    this.searchhinttext,
    this.hinttext,
    required this.width,
    required this.isSvg,
    required this.isCircleSuffixIcon,
    this.isCircleSearchIcon,
    required this.svgAsset,
    this.sheetTitle,
    this.validator,
    required this.list,
    required this.isConfigreceived,
  }) : super(key: key);

  @override
  _CustomSelectionBarState createState() => _CustomSelectionBarState();
}

class _CustomSelectionBarState extends ConsumerState<CustomSelectionBar> {
  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, child) => SizedBox(
        width: widget.width,
        child: TextFormField(
          controller: widget.controller,
          validator: widget.validator,
          onTap: () {
            if (widget.list.isNotEmpty) {
              FocusScope.of(context).unfocus();
              onTextFieldTap(widget.list);
            } else if (!widget.isConfigreceived) {
              _getConfigAttributes();
              onEmptyList();
            } else {
              onEmptyListLoading();
            }
          },
          readOnly: true,
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.only(top: 15, bottom: 10),
            hintText: widget.hinttext,
            hintStyle: TextStyle(
                fontSize: AppConstants.formtextsize,
                color: AppConstants.labeltextgrey),
            prefixIconConstraints:
                const BoxConstraints(maxHeight: 25, maxWidth: 30),
            prefixIcon: Container(
                margin: const EdgeInsets.only(left: 5, right: 5),
                child: widget.isSvg == true
                    ? SvgPicture.asset(
                        widget.svgAsset,
                        color: AppConstants.customblack,
                        alignment: Alignment.center,
                        height: 25,
                        width: 25,
                      )
                    : null),
            suffixIconConstraints:
                const BoxConstraints(maxHeight: 25, maxWidth: 30),
            suffixIcon: widget.isCircleSuffixIcon == true
                ? Icon(
                    (widget.isCircleSearchIcon == true)
                        ? Icons.search_rounded
                        : Icons.arrow_drop_down_circle_sharp,
                    color: AppConstants.primaryColor,
                  )
                : (widget.isCircleSearchIcon == true)
                    ? const Icon(
                        Icons.search,
                        size: 30,
                        color: AppConstants.primaryColor,
                      )
                    : const Icon(
                        Icons.arrow_drop_down,
                        size: 30,
                        color: AppConstants.customblack,
                      ),
            fillColor: Colors.black12,
            border: widget.isCircleSuffixIcon == true
                ? const OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(8.0),
                    ),
                  )
                : null,
          ),
        ),
      ),
    );
  }

  void _getConfigAttributes() {
    final configInfoRequest =
        ConfigInfoRequest(configAttributes: ["GNDR", "BG", "NTY", "FGTPSD"]);
    ref
        .read(configInfoNotifierProvider.notifier)
        .getConfigAttributes(configInfoRequest);
  }

  void onTextFieldTap(List<SelectedListItem> _listOfSelectOptions) {
    DropDownState(
      DropDown(
        searchHintText: widget.searchhinttext,
        bottomSheetTitle: widget.sheetTitle,
        searchBackgroundColor: Colors.black12,
        dataList: _listOfSelectOptions,
        enableMultipleSelection: false,
        searchController: widget.searchController,
        selectedItem: (String selected) {
          widget.controller.text = selected;
        },
      ),
    ).showModal(context);
  }

  void onEmptyList() {
    showModalBottomSheet(
      isScrollControlled: false,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(15.0)),
      ),
      context: context,
      builder: (context) {
        return DraggableScrollableSheet(
          initialChildSize: 1,
          maxChildSize: 1,
          minChildSize: 0.5,
          builder: (BuildContext context, ScrollController scrollController) {
            return const Center(
              child: Text("Data Not Available"),
            );
          },
        );
      },
    );
  }

  void onEmptyListLoading() {
    showModalBottomSheet(
      isScrollControlled: false,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(15.0)),
      ),
      context: context,
      builder: (context) {
        return DraggableScrollableSheet(
          initialChildSize: 1,
          maxChildSize: 1,
          minChildSize: 0.5,
          builder: (BuildContext context, ScrollController scrollController) {
            return const Center(
              child: SpinKitCircle(
                color: AppConstants.primaryColor,
              ),
            );
          },
        );
      },
    );
  }
}
