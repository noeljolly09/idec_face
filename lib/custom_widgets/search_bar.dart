// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:idec_face/constants.dart';

class SearchInput extends StatefulWidget {
  final String labelText;
  const SearchInput({
    Key? key,
    required this.labelText,
  }) : super(key: key);

  @override
  State<SearchInput> createState() => _SearchInputState();
}

class _SearchInputState extends State<SearchInput> {
  @override
  Widget build(BuildContext context) {
    return TextField(
      cursorColor: AppConstants.primaryColor,
      decoration: InputDecoration(
          fillColor: Colors.white,
          contentPadding: const EdgeInsets.only(left: 30),
          filled: true,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
          ),
          hintText: 'Search ${widget.labelText}',
          hintStyle: const TextStyle(color: Colors.grey, fontSize: 15),
          suffixIcon: Container(
            padding: const EdgeInsets.all(10),
            child: const Icon(
              Icons.search,
              color: AppConstants.primaryColor,
            ),
            width: 18,
          )),
    );
  }
}
