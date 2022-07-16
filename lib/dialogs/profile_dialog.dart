import 'package:flutter/material.dart';
import 'package:idec_face/constants.dart';

import 'package:idec_face/custom_widgets/search_bar.dart';

openMappingDialog(
  BuildContext context,
  String label, {
  bool isAvailableNeeded = true,
  TextEditingController? controller,
}) {
  showDialog(
    context: context,
    builder: (context) {
      controller = TextEditingController();
      return AlertDialog(
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(20.0))),
          content: SizedBox(
            height: 400,
            child: Column(
              children: [
                Center(
                    child: Text(
                  isAvailableNeeded == true ? 'Available $label' : label,
                  style: const TextStyle(color: AppConstants.primaryColor),
                )),
                const SizedBox(height: 10),
                Container(
                  margin: const EdgeInsets.all(15),
                  color: Colors.white,
                  child: SearchInput(
                    labelText: label,
                    controller: controller!,
                    onTap: () {},
                    onClear: () {},
                  ),
                ),
                PhysicalModel(
                  color: Colors.white,
                  elevation: 2,
                  shadowColor: AppConstants.primaryColor,
                  borderRadius: BorderRadius.circular(20),
                  child: Container(
                    height: 250,
                  ),
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    ElevatedButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text('Cancel')),
                    const SizedBox(width: 10),
                    ElevatedButton(
                      onPressed: () {},
                      child: const Text('Apply'),
                      style: ElevatedButton.styleFrom(
                        onPrimary: Colors.white,
                        primary: AppConstants.primaryColor,
                      ),
                    )
                  ],
                )
              ],
            ),
          ));
    },
  );
}
