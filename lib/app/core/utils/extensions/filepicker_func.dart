import 'dart:io';

import 'package:file_picker/file_picker.dart';

Future filePicker() async {
  FilePickerResult? result = await FilePicker.platform.pickFiles(
    type: FileType.image,
  );

  if (result != null) {
    File file = File(result.files.single.path!);
    var res = {
      'name': result.files.single.name,
      'path': file.path,
    };
    return res;
  } else {
    return null;
  }
}
