import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:idec_face/network/service_manager_formPost.dart';

import '../../models/media_upload/media_response.dart';
import '../../network/service_umbrella.dart';

class MediaRepository {
  final ServiceManager _serviceManager;

  MediaRepository(this._serviceManager);

  Future<ServiceResponse<MediaResponse?>> uploadImage(File? mediaFile,
      {bool isDelete = false, String? imageurl}) async {
    String? fileName;

    try {
      if (isDelete) {
        final startIndex = imageurl?.indexOf("ns_");
        final endIndex = imageurl?.indexOf("?", startIndex! + 3);
        imageurl = imageurl?.substring(startIndex!, endIndex);
      } else {
        if (mediaFile != null) {
          fileName = mediaFile.path;
        } else {
          mediaFile = null;
        }
      }
      final response = await _serviceManager.formPost(
        '/api/video/updateImage',
        isDelete
            ? {
                "relativePath": imageurl,
              }
            : {
                "avatar": await MultipartFile.fromFile(
                  mediaFile!.path,
                  filename: fileName,
                ),
                "thumbnail": false
              },
      );
      print(response);
      final str = jsonEncode(response.data);
      final softnodeResponse = mediaResponseFromJson(str);
      return ServiceResponse.completed(softnodeResponse);
    } catch (e) {
      print(e);
      final error = DioNetworkException.getDioException(e);
      return ServiceResponse.error(error.errorCode, error.message);
    }
  }
}
