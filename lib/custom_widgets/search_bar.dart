// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:idec_face/constants.dart';

import '../screens/people_profile/notifiers/people_profile_notfier.dart';

class SearchInput extends ConsumerWidget {
  final String labelText;
  final VoidCallback onTap;
  final TextEditingController controller;
  final VoidCallback onClear;
  const SearchInput({
    Key? key,
    required this.labelText,
    required this.onTap,
    required this.onClear,
    required this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final clearIconVisibility =
        ref.watch(peopleProfileNotifier).getEmpNameFilteredStatus;
    return TextFormField(
      controller: controller,
      cursorColor: AppConstants.primaryColor,
      decoration: InputDecoration(
        fillColor: Colors.white,
        contentPadding: const EdgeInsets.only(left: 30),
        filled: true,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
        ),
        hintText: 'Search $labelText',
        hintStyle: const TextStyle(color: Colors.grey, fontSize: 15),
        suffixIconConstraints: const BoxConstraints(minWidth: 70),
        suffixIcon: SizedBox(
          child: Row(
            children: [
              Visibility(
                visible: clearIconVisibility,
                child: InkWell(
                  child: const Icon(
                    Icons.clear,
                    color: AppConstants.primaryColor,
                  ),
                  onTap: onClear,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 8.0, left: 8),
                child: InkWell(
                  child: const Icon(
                    Icons.search,
                    color: AppConstants.primaryColor,
                  ),
                  onTap: onTap,
                ),
              ),
            ],
          ),
          width: 40,
        ),
      ),
    );
  }
}
