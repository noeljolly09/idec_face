import 'package:country_list_pick/country_list_pick.dart';
import 'package:flutter/material.dart';

class CustomCountryCodePicker extends StatefulWidget {
  final CountryCode? Function(CountryCode?)? changeCountryCode;
  final String? countryCode;

  const CustomCountryCodePicker({
    Key? key,
    required this.changeCountryCode,
    this.countryCode = '+91',
  }) : super(key: key);

  @override
  State<CustomCountryCodePicker> createState() =>
      _CustomCountryCodePickerState();
}

class _CustomCountryCodePickerState extends State<CustomCountryCodePicker> {
  static const int _blackPrimaryValue = 0xFF000000;
  static const MaterialColor primaryBlack = MaterialColor(
    _blackPrimaryValue,
    <int, Color>{
      50: Color(0xFF000000),
      100: Color(0xFF000000),
      200: Color(0xFF000000),
      300: Color(0xFF000000),
      400: Color(0xFF000000),
      500: Color(_blackPrimaryValue),
      600: Color(0xFF000000),
      700: Color(0xFF000000),
      800: Color(0xFF000000),
      900: Color(0xFF000000),
    },
  );

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData(primarySwatch: primaryBlack),
      child: CountryListPick(
          theme: CountryTheme(
            isShowFlag: true,
            isShowTitle: false,
            isShowCode: false,
            isDownIcon: true,
            showEnglishName: true,
            alphabetSelectedBackgroundColor: Theme.of(context).primaryColor,
            searchHintText: "Search the country code or country",
          ),
          initialSelection: widget.countryCode,
          onChanged: widget.changeCountryCode,
          useUiOverlay: true,
          useSafeArea: true),
    );
  }
}
