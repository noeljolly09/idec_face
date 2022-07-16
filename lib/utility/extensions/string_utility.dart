extension StringUtility on String {
  String get isValidEmail {
    String textValue = this;
    if (textValue.isEmpty) {
      return "Mandatory field";
    } else {
      bool value = RegExp(
              r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
          .hasMatch(this);
      if (!value) {
        return "Enter valid mail";
      } else {
        return "";
      }
    }
  }

  String get isValidPhone {
    String value = this;
    if (value.isEmpty) {
      return "Mandatory field";
    } else {
      const pattern = r'(^(?:[+0]9)?[0-9]{10,12}$)';
      final phone = this;
      final regex = RegExp(pattern);
      final value = regex.hasMatch(phone.trim());
      if (!value) {
        return "Enter valid number";
      } else {
        return "";
      }
    }
  }

  String get isEmptyValidate {
    final value = this;
    if (value.isEmpty) {
      return "Mandatory field";
    } else {
      return "";
    }
  }

  String domainValidate(
      {required String domainController, required List<String> domainList}) {
    final value = domainController;
    if (value.isEmpty) {
      return "Mandatory field";
    } else if (domainList.isEmpty) {
      return "No domains found";
    } else if (!domainList.contains(
      domainController.trim().toUpperCase(),
    )) {
      return "Invalid domain";
    } else {
      return "";
    }
  }

  String get capitalize {
    return "${this[0].toUpperCase()}${substring(1)}";
  }
}
