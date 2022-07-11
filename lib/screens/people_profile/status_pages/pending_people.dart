import 'package:flutter/material.dart';
import 'package:idec_face/custom_widgets/search_bar.dart';

class PendingPage extends StatefulWidget {
  const PendingPage({Key? key}) : super(key: key);

  @override
  State<PendingPage> createState() => _PendingPageState();
}

class _PendingPageState extends State<PendingPage> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.all(5),
          color: Colors.white,
          child: const SearchInput(labelText: 'Employee'),
        ),
        const Text('Employee List is empty')
      ],
    );
  }
}
