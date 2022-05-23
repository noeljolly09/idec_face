import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';

class CustomCountryCodePicker extends StatefulWidget {
  late CountryCode codeController;
  CustomCountryCodePicker({Key? key, required this.codeController})
      : super(key: key);

  @override
  State<CustomCountryCodePicker> createState() =>
      _CustomCountryCodePickerState();
}

class _CustomCountryCodePickerState extends State<CustomCountryCodePicker> {
  @override
  Widget build(BuildContext context) {
    return CountryCodePicker(
      onChanged: (value) => setState(() {
        widget.codeController = value;
      }),
      hideMainText: false,
      showFlagMain: false,
      showFlag: true,
      initialSelection: 'IN',
      hideSearch: false,
      showCountryOnly: false,
      showOnlyCountryWhenClosed: false,
      alignLeft: true,
    );
  }
}


// supportedLocales: const [
//         Locale("af"),
//         Locale("am"),
//         Locale("ar"),
//         Locale("az"),
//         Locale("be"),
//         Locale("bg"),
//         Locale("bn"),
//         Locale("bs"),
//         Locale("ca"),
//         Locale("cs"),
//         Locale("da"),
//         Locale("de"),
//         Locale("el"),
//         Locale("en"),
//         Locale("es"),
//         Locale("et"),
//         Locale("fa"),
//         Locale("fi"),
//         Locale("fr"),
//         Locale("gl"),
//         Locale("ha"),
//         Locale("he"),
//         Locale("hi"),
//         Locale("hr"),
//         Locale("hu"),
//         Locale("hy"),
//         Locale("id"),
//         Locale("is"),
//         Locale("it"),
//         Locale("ja"),
//         Locale("ka"),
//         Locale("kk"),
//         Locale("km"),
//         Locale("ko"),
//         Locale("ku"),
//         Locale("ky"),
//         Locale("lt"),
//         Locale("lv"),
//         Locale("mk"),
//         Locale("ml"),
//         Locale("mn"),
//         Locale("ms"),
//         Locale("nb"),
//         Locale("nl"),
//         Locale("nn"),
//         Locale("no"),
//         Locale("pl"),
//         Locale("ps"),
//         Locale("pt"),
//         Locale("ro"),
//         Locale("ru"),
//         Locale("sd"),
//         Locale("sk"),
//         Locale("sl"),
//         Locale("so"),
//         Locale("sq"),
//         Locale("sr"),
//         Locale("sv"),
//         Locale("ta"),
//         Locale("tg"),
//         Locale("th"),
//         Locale("tk"),
//         Locale("tr"),
//         Locale("tt"),
//         Locale("uk"),
//         Locale("ug"),
//         Locale("ur"),
//         Locale("uz"),
//         Locale("vi"),
//         Locale("zh")
//       ],
//       localizationsDelegates: const [
//         CountryLocalizations.delegate,
//         GlobalMaterialLocalizations.delegate,
//         GlobalWidgetsLocalizations.delegate,
//       ],