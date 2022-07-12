import 'package:flutter/material.dart';

import 'package:idec_face/custom_widgets/search_bar.dart';

class DeclinedPage extends StatefulWidget {
  const DeclinedPage({Key? key}) : super(key: key);

  @override
  State<DeclinedPage> createState() => _DeclinedPageState();
}

class _DeclinedPageState extends State<DeclinedPage> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.all(15),
          color: Colors.white,
          child: const SearchInput(labelText: 'Employee'),
        ),
        const Text('Employee List is empty')
      ],
    );
  }
}
