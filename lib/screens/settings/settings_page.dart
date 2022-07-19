import 'package:flutter/material.dart';
import 'package:idec_face/constants.dart';
import 'package:idec_face/custom_widgets/custom_appbar.dart';
import 'package:settings_ui/settings_ui.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  bool isSwitched = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: customAppBar("Settings"),
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        body: SettingsList(
          shrinkWrap: false,
          applicationType: ApplicationType.both,
          contentPadding: const EdgeInsets.all(10),
          sections: [
            SettingsSection(
              title: const Text("Organisational",
                  style: TextStyle(
                      color: AppConstants.primaryColor, fontSize: 18)),
              tiles: [
                SettingsTile(
                  title: const Text('Language'),
                  value: const Text('English'),
                  leading: const Icon(Icons.language),
                  onPressed: (context) {},
                ),

                SettingsTile.switchTile(
                  onToggle: (value) {
                    setState(() {
                      isSwitched = value;
                    });
                  },
                  initialValue: true,
                  leading: const Icon(Icons.dark_mode),
                  title: const Text('Theme'),
                ),
                // SettingsTile.switchTile(
                //   title: 'Use System Theme',
                //   leading: Icon(Icons.phone_android),
                //   switchValue: isSwitched,
                //   onToggle: (value) {
                //     setState(() {
                //       isSwitched = value;
                //     });
                //   },
                // ),
              ],
            ),
            SettingsSection(
              title: const Text('Personal',
                  style: TextStyle(
                      color: AppConstants.primaryColor, fontSize: 18)),
              tiles: [
                SettingsTile(
                  title: const Text('Change Email'),
                  value: const Text('abc@gmail.com'),
                  leading: const Icon(Icons.mail),
                  onPressed: (context) {},
                ),
                SettingsTile(
                  title: const Text('Change Password'),
                  value: const Text('****'),
                  leading: const Icon(Icons.password),
                  onPressed: (context) {},
                ),
                SettingsTile(
                  title: const Text('Change Name'),
                  value: const Text('abc'),
                  leading: const Icon(Icons.person),
                  onPressed: (context) {},
                ),
              ],
            ),
            SettingsSection(
              title: const Text('Application',
                  style: TextStyle(
                      color: AppConstants.primaryColor, fontSize: 18)),
              tiles: [
                SettingsTile(
                  title: const Text('App Notificaitons'),
                  value: const Text(''),
                  leading: const Icon(Icons.notifications),
                  onPressed: (context) {},
                ),
                SettingsTile(
                  title: const Text('App Info'),
                  value: const Text(''),
                  leading: const Icon(Icons.info),
                  onPressed: (context) {},
                ),
                SettingsTile(
                  title: const Text('App Feedback'),
                  value: const Text(""),
                  leading: const Icon(Icons.feedback),
                  onPressed: (context) {},
                ),
              ],
            ),
          ],
        ));
  }
}
