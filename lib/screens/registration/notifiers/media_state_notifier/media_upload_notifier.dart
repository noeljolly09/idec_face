import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MediaUploadNotifier extends ChangeNotifier {
  File? _imageFile;
  File? get getImageFile => _imageFile;

  void updateImage({File? image}) {
    _imageFile = image;
    notifyListeners();
  }
}

final imageNotifier = ChangeNotifierProvider((ref) => MediaUploadNotifier());
