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
        return Text(
          snapshot.data!.version,
          style: const TextStyle(color: Colors.grey),
        );
      } else {
        return const Text(
          "",
          style: TextStyle(color: Colors.grey),
        );
      }
    },
  );
}


