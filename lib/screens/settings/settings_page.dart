import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:idec_face/constants.dart';
import 'package:idec_face/custom_widgets/custom_appbar.dart';
import 'package:idec_face/dialogs/change_password_dialog.dart';
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
                  enabled: false,
                  title: const Text('Language'),
                  value: const Text('English'),
                  leading: const Icon(Icons.language),
                  onPressed: (context) {},
                ),

                SettingsTile.switchTile(
                  enabled: false,
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
                  title: const Text('Change Password'),
                  leading: SvgPicture.asset("assets/svg/password.svg"),
                  onPressed: (context) {
                    showDialog(
                        context: context,
                        builder: (context) => const ChangePasswordDialog(
                            isConfirmPasswordNeeded: true,
                            tooltipText:
                                "PLease enter your credentials here to change",
                            label: "Change Password"));
                  },
                ),
                SettingsTile(
                  enabled: false,
                  title: const Text('Update Profile'),
                  leading: SvgPicture.asset("assets/svg/user.svg"),
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
                  enabled: false,
                  title: const Text('App Notificaitons'),
                  leading: const Icon(Icons.notifications),
                  onPressed: (context) {},
                ),
                SettingsTile(
                  enabled: false,
                  title: const Text('App Info'),
                  leading: const Icon(Icons.info),
                  onPressed: (context) {},
                ),
                SettingsTile(
                  enabled: false,
                  title: const Text('App Feedback'),
                  leading: const Icon(Icons.feedback),
                  onPressed: (context) {},
                ),
              ],
            ),
          ],
        ));
  }
}
