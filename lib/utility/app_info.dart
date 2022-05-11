import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';

Future<String> getAppName() async {
  final info = await PackageInfo.fromPlatform();
  return info.appName;
}


getVersionNumber() {
  return FutureBuilder(
    future: PackageInfo.fromPlatform(),
    builder: (BuildContext context, AsyncSnapshot<PackageInfo> snapshot) {
      if (snapshot.hasData) {
        return Text(snapshot.data!.version);
      } else {
        return const Text("");
      }
    },
  );
}
