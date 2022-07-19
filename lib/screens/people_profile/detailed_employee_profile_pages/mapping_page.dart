// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:idec_face/constants.dart';
import 'package:idec_face/dialogs/profile_dialog.dart';
import 'package:idec_face/screens/people_profile/widgets/mapping_card.dart';

class MappingPage extends StatelessWidget {
  final int employeeMappingIndex;
  const MappingPage({
    Key? key,
    required this.employeeMappingIndex,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: screenHeight(context, dividedBy: 47.52)),
        Align(
          alignment: Alignment.topRight,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              onPrimary: Colors.white,
              primary: AppConstants.primaryColor,
            ),
            onPressed: () {},
            child: const Text('Delete Site'),
          ),
        ),
        Expanded(
          child: Scrollbar(
            thumbVisibility: true,
            thickness: 5,
            child: SingleChildScrollView(
              child: SizedBox(
                child: Column(
                  children: [
                    const MappingProfileCard(
                      isIconNeeded: false,
                      icon: Icons.edit,
                      cardLabel: 'Plant',
                      cardData: 'Bidadari Estate Construction',
                    ),
                    MappingProfileCard(
                      isIconNeeded: true,
                      icon: Icons.edit,
                      onPressed: () {
                        openMappingDialog(context, "Project");
                      },
                      cardLabel: 'Project',
                      cardData: '',
                    ),
                    MappingProfileCard(
                      isIconNeeded: true,
                      icon: Icons.edit,
                      onPressed: () {
                        openMappingDialog(context, "Phase");
                      },
                      cardLabel: 'Phase',
                      cardData: '',
                    ),
                    MappingProfileCard(
                      isIconNeeded: true,
                      icon: Icons.edit,
                      onPressed: () {
                        openMappingDialog(context, "Building");
                      },
                      cardLabel: 'Building',
                      cardData: '',
                    ),
                    MappingProfileCard(
                      isIconNeeded: true,
                      icon: Icons.edit,
                      onPressed: () {
                        openMappingDialog(context, "Floors");
                      },
                      cardLabel: 'Floors',
                      cardData: '',
                    ),
                    MappingProfileCard(
                      isIconNeeded: true,
                      icon: Icons.edit,
                      onPressed: () {
                        openMappingDialog(context, "Restricted Entry Zone");
                      },
                      cardLabel: 'Restricted \nEntry Zones',
                      cardData: '',
                    ),
                    MappingProfileCard(
                      isIconNeeded: true,
                      icon: Icons.link_off,
                      onPressed: () {},
                      cardLabel: 'Device',
                      cardData: 'SIS0005',
                    ),
                    MappingProfileCard(
                      isIconNeeded: true,
                      onPressed: () {
                        openMappingDialog(context, "Buddy");
                      },
                      icon: Icons.person_add_alt,
                      cardLabel: 'Buddy',
                      cardData: '',
                    ),
                    MappingProfileCard(
                      isIconNeeded: true,
                      icon: Icons.person_add_alt,
                      onPressed: () {
                        openMappingDialog(context, "Supervisor 1");
                      },
                      cardLabel: 'Supervisor 1',
                      cardData: '',
                    ),
                    MappingProfileCard(
                      isIconNeeded: true,
                      icon: Icons.person_add_alt,
                      onPressed: () {
                        openMappingDialog(context, "Supervisor 2");
                      },
                      cardLabel: 'Supervisor 2',
                      cardData: '',
                    ),
                    MappingProfileCard(
                      isIconNeeded: true,
                      icon: Icons.person_add_alt,
                      onPressed: () {
                        openMappingDialog(context, "Supervisor 3");
                      },
                      cardLabel: 'Supervisor 3',
                      cardData: '',
                    ),
                    const MappingProfileCard(
                      icon: Icons.edit,
                      isIconNeeded: false,
                      cardLabel: 'Reportees',
                      cardData: '',
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        SizedBox(height: screenHeight(context, dividedBy: 10.52)),
      ],
    );
  }
}
