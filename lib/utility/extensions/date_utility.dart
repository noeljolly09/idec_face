import 'package:intl/intl.dart';

extension DateUtility on DateTime {
  String get dateString {
    final val = DateFormat("yyyy-MM-dd'T'HH:mm:ss").format(this);
    return val;
  }

  String get currentTimeStamp {
    final val = dateString + timeZoneValue;
    return val;
  }

  String get timeZoneValue {
    var offset = timeZoneOffset;
    var hours =
        offset.inHours > 0 ? offset.inHours : 1; // For fixing divide by 0
    var timeZoneValue = "";
    if (!offset.isNegative) {
      timeZoneValue = "+" +
          offset.inHours.toString().padLeft(2, '0') +
          (offset.inMinutes % (hours * 60)).toString().padLeft(2, '0');
    } else {
      timeZoneValue = "-" +
          (-offset.inHours).toString().padLeft(2, '0') +
          (offset.inMinutes % (hours * 60)).toString().padLeft(2, '0');
    }
    return timeZoneValue;
  }

  String get startTimeStamp {
    final timeStamp = dateString;
    final components = timeStamp.split('T');
    return components.first + 'T00:00:00' + timeZoneValue;
  }

  String get endTimeStamp {
    final timeStamp = dateString;
    final components = timeStamp.split('T');
    return components.first + 'T23:59:59' + timeZoneValue;
  }

  String get time {
    final format = DateFormat('HH:mm a');
    return format.format(this);
  }
}

extension DateString on String {
  DateTime get date {
    DateTime formattedString = DateTime.parse(this).toLocal();
    return formattedString;
  }

  String get formatDate {
    final val =
        DateFormat("dd MMM, hh:mm a").format(DateTime.parse(this).toLocal());
    return val;
  }
}

extension DateStringWithoutTime on String {
  DateTime get date {
    DateTime formattedString = DateTime.parse(this).toLocal();
    return formattedString;
  }

  String get formatDateWithoutTime {
    final val = DateFormat('dd/MM/yyyy').format(DateTime.parse(this).toLocal());
    return val;
  }
}

extension TimeDuration on num {
  String get duration {
    var hours = (this ~/ 60);
    String hourValue = hours.toString().padLeft(2, '0');
    var minutesValue = (this % 60).toInt();
    String value = minutesValue.toString().padLeft(2, '0');
    return '${hourValue}h ${value}m';
  }
}
