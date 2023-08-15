import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

class ImagePickerProvider {
  final picker = ImagePicker();

  void getImage(void Function(File) onComplete) async {
    final XFile? _image = await picker.pickImage(source: ImageSource.gallery);
    if (_image != null) {
      final croppedFile = await ImageCropper().cropImage(
        sourcePath: _image.path,
        aspectRatioPresets: [
          CropAspectRatioPreset.square,
        ],
        uiSettings: [
          AndroidUiSettings(
              toolbarTitle: 'Cropper',
              toolbarColor: Colors.deepOrange,
              toolbarWidgetColor: Colors.white,
              initAspectRatio: CropAspectRatioPreset.square,
              lockAspectRatio: false),
          IOSUiSettings(
            title: 'Cropper',
          )
        ],
      );
      if (croppedFile != null) {
        onComplete(File(croppedFile.path));
      }
    }
  }
}
