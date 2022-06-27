import 'package:drop_down_list/drop_down_list.dart';
import 'package:flutter/material.dart';
import 'package:idec_face/custom_widgets/custom_selection.dart';

final List<SelectedListItem> _listOfEmployees = [
  SelectedListItem(true, "A"),
  SelectedListItem(false, "B"),
  SelectedListItem(false, "C"),
  SelectedListItem(false, "D"),
  SelectedListItem(false, "E"),
  SelectedListItem(false, "F"),
  SelectedListItem(false, "G"),
  SelectedListItem(false, "H"),
];

final TextEditingController _storetextController = TextEditingController();

final TextEditingController _searchController = TextEditingController();

openMappingDialog(
  BuildContext context,
) {
  showDialog(
    context: context,
    builder: (context) => AlertDialog(
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(20.0))),
        content: SizedBox(
          height: 500,
          width: 500,
          child: Column(
            children: [
              const Center(child: Text('Available Project')),
              Container(
                margin: const EdgeInsets.all(5),
                child: CustomSelectionBar(
                  isConfigreceived: false,
                  isCircleSuffixIcon: true,
                  isCircleSearchIcon: true,
                  isSvg: false,
                  svgAsset: "",
                  width: MediaQuery.of(context).size.width,
                  list: _listOfEmployees,
                  hinttext: "Search Employee",
                  searchhinttext: "Search Employee",
                  sheetTitle: "Search Employee",
                  controller: _storetextController,
                  searchController: _searchController,
                ),
              ),
            ],
          ),
        )),
  );
}
