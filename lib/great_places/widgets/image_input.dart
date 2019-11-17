import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart' as syspath;

class ImageInput extends StatefulWidget {
  final Function(File) onSelectImage;

  const ImageInput({Key key, this.onSelectImage}) : super(key: key);

  @override
  _ImageInputState createState() => _ImageInputState();
}

class _ImageInputState extends State<ImageInput> {
  File _storedImage;

  Future _takePicture() async {
    final image =
        await ImagePicker.pickImage(source: ImageSource.camera, maxWidth: 600);

    setState(() {
      _storedImage = image;
    });

    _savePicture(image);
  }

  Future<void> _savePicture(File picture) async {
    try {
      final appDir = await syspath.getApplicationDocumentsDirectory();
      final filename = path.basename(picture.path);
      final fullname = path.join(appDir.path, filename);

      File destination = await picture.copy(fullname);

      widget.onSelectImage(destination);
    } catch (error) {
      //
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Container(
          width: 100,
          height: 100,
          decoration: BoxDecoration(
            border: Border.all(width: 1, color: Colors.grey),
          ),
          child: _storedImage != null
              ? Image.file(_storedImage,
                  fit: BoxFit.cover, width: double.infinity)
              : Text(
                  'Take a picture',
                  textAlign: TextAlign.center,
                ),
          alignment: Alignment.center,
        ),
        SizedBox(width: 16),
        Expanded(
          child: FlatButton.icon(
            icon: Icon(Icons.camera),
            label: Text('Take Picture'),
            textColor: Theme.of(context).primaryColor,
            onPressed: _takePicture,
          ),
        ),
      ],
    );
  }
}
