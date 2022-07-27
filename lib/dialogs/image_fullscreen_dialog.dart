import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:http/http.dart' as http;

class ImageDialog extends StatelessWidget {
  final File? imageFile;
  final bool isImageNetwork;
  final String? imageUrl;
  final VoidCallback? onTap;
  const ImageDialog({
    this.imageFile,
    this.isImageNetwork = false,
    this.imageUrl,
    this.onTap,
  });

  getImage(String? profileImage) async {
    if (profileImage != null && profileImage != '') {
      var client = http.Client();
      try {
        http.Response? uriResponse = await client.get(Uri.parse(profileImage));
        if (uriResponse.statusCode == 200) {
          if (uriResponse.bodyBytes != null) {
            if (uriResponse.bodyBytes.isNotEmpty) {
              return uriResponse.bodyBytes;
            }
          }
        }
        return null;
      } catch (e) {
        print(e);

        return null;
      } finally {
        client.close();
      }
    } else {
      return null;
    }
  }

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
                isImageNetwork
                    ? FutureBuilder<dynamic>(
                        future: getImage(imageUrl),
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            return Image.network(
                              imageUrl!,
                              width: 300,
                              height: 280,
                            );
                          }
                          return SizedBox(
                            width: 300,
                            height: 280,
                            child: SpinKitCircle(
                              color: Theme.of(context).primaryColor,
                            ),
                          );
                        },
                      )
                    : Image.file(
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
