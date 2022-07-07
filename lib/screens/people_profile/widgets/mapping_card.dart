import 'package:flutter/material.dart';
import 'package:idec_face/constants.dart';

class MappingProfileCard extends StatelessWidget {
  final bool isIconNeeded;
  final String cardLabel;
  final String cardData;
  final void Function()? onPressed;
  final IconData icon;
  const MappingProfileCard({
    Key? key,
    required this.isIconNeeded,
    required this.cardLabel,
    required this.cardData,
    this.onPressed,
    required this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 1,
      child: Container(
        margin: const EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(cardLabel),
            Text(cardData),
            isIconNeeded == true
                ? IconButton(
                    onPressed: onPressed,
                    icon: Icon(icon),
                    color: AppConstants.primaryColor,
                  )
                : const Text(''),
          ],
        ),
      ),
    );
  }
}
