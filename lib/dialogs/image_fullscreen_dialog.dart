import 'dart:io';
import 'package:flutter/material.dart';

class ImageDialog extends StatelessWidget {
  final File? imageFile;
  final VoidCallback? onTap;
  const ImageDialog({
    this.imageFile,
    this.onTap,
  });
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.of(context).pop(false);
        return false;
      },
      child: Dialog(
        insetPadding: const EdgeInsets.all(0),
        child: Stack(
          alignment: Alignment.topCenter,
          children: [
            Stack(
              children: [
                Image.file(
                  File(imageFile!.path),
                  fit: BoxFit.fill,
                  width: 280,
                  height: 280,
                ),
                Visibility(
                  visible: onTap == null,
                  child: Positioned(
                    bottom: 0,
                    child: SizedBox(
                      height: 75,
                      width: 300,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Expanded(
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  padding: const EdgeInsets.all(0),
                                  fixedSize: const Size(150, 60),
                                  primary: Colors.black54),
                              onPressed: () {
                                Navigator.of(context).pop(false);
                              },
                              child: const Icon(
                                Icons.check_sharp,
                                color: Colors.white,
                                size: 50,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
