import 'package:country_list_pick/country_list_pick.dart';
import 'package:flutter/material.dart';

class CustomCountryCodePicker extends StatefulWidget {
  const CustomCountryCodePicker({
    Key? key,
  }) : super(key: key);

  @override
  State<CustomCountryCodePicker> createState() =>
      _CustomCountryCodePickerState();
}

class _CustomCountryCodePickerState extends State<CustomCountryCodePicker> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: CountryListPick(
          theme: CountryTheme(
            isShowFlag: false,
            isShowTitle: false,
            isShowCode: true,
            isDownIcon: true,
            showEnglishName: true,
          ),
          onChanged: (value) => {},
          initialSelection: '+91',
          useUiOverlay: true,
          useSafeArea: true),
    );
  }
}
