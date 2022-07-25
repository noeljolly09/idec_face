import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MediaUploadNotifier extends ChangeNotifier {
  File? _imageFile;
  File? get getImageFile => _imageFile;

  String? _imageUrl;
  String? get getImageUrl => _imageUrl;

  void updateImage({File? image}) {
    _imageFile = image;
    notifyListeners();
  }

  void updateImageUrl({String? image}) {
    _imageUrl = image;
    notifyListeners();
  }
}

final imageNotifier = ChangeNotifierProvider((ref) => MediaUploadNotifier());
