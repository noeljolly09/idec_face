import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../models/media_upload/media_response.dart';
import '../../../network/service_umbrella.dart';
import '../media_repository.dart';

class MediaNotifier extends StateNotifier<ServiceResponse<MediaResponse?>> {
  final MediaRepository _mediaRepository;

  MediaNotifier(this._mediaRepository) : super(ServiceResponse.none());

  Future<void> uploadImageDetails(
      {File? imageFile,
      bool isDelete = false,
      String? imageurl,
      String? tenantId}) async {
    state = ServiceResponse.loading('Loading...');
    final response = await _mediaRepository.uploadImage(imageFile,
        isDelete: isDelete, imageurl: imageurl, tenantId: tenantId);
    state = response;
  }

  void cancelRequest() async {
    state = ServiceResponse.none();
  }
}
