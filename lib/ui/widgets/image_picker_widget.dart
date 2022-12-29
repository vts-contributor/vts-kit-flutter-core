import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ImagePickerWidget extends StatefulWidget {
  final void Function(List<File>) onChanged;
  const ImagePickerWidget({Key? key, required this.onChanged}) : super(key: key);

  @override
  State<ImagePickerWidget> createState() => _ImagePickerWidgetState();
}

class _ImagePickerWidgetState extends State<ImagePickerWidget> {
  final ImagePicker _picker = ImagePicker();
  List<XFile> images = [];

  void _pick() async {
    FocusScope.of(context).unfocus();
    XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      images.add(image);
      setState(() {});
      widget.onChanged(images.map((e) => File(e.path)).toList());
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Wrap(
        spacing: 8,
        runSpacing: 8,
        alignment: WrapAlignment.start,
        children: [
          for (var item in images)
            ImagePickedWidget(
              image: item,
              onRemoved: (image) {
                images.remove(image);
                setState(() {});
              },
            ),
          Padding(
            padding: const EdgeInsets.only(top: 6, right: 6),
            child: Ink.image(
              image: const AssetImage("assets/image_picker_icon.png"),
              width: 80,
              height: 80,
              fit: BoxFit.cover,
              child: InkWell(
                borderRadius: BorderRadius.circular(10),
                onTap: () {
                  _pick();
                },
              ),
            ),
          )
        ],
      ),
    );
  }
}

class ImagePickedWidget extends StatefulWidget {
  final XFile image;
  final void Function(XFile) onRemoved;
  const ImagePickedWidget({Key? key, required this.image, required this.onRemoved}) : super(key: key);

  @override
  State<ImagePickedWidget> createState() => _ImagePickedWidgetState();
}

class _ImagePickedWidgetState extends State<ImagePickedWidget> {
  bool showImage = false;

  @override
  void initState() {
    super.initState();
    Timer(const Duration(milliseconds: 100), () {
      if (mounted) {
        setState(() {
          showImage = true;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      curve: Curves.fastOutSlowIn,
      duration: const Duration(milliseconds: 300),
      opacity: showImage ? 1 : 0,
      child: Stack(
        children: [
          AnimatedContainer(
            curve: Curves.fastOutSlowIn,
            onEnd: () {
              if (!showImage) {
                widget.onRemoved(widget.image);
              }
            },
            margin: EdgeInsets.only(
                top: showImage ? 6 : 0, right: showImage ? 6 : 0),
            duration: const Duration(milliseconds: 300),
            width: showImage ? 80 : 0,
            height: showImage ? 80 : 0,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.file(
                File(widget.image.path),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Positioned(
            top: 0,
            right: 0,
            child: InkWell(
              onTap: () {
                setState(() {
                  showImage = false;
                });
              },
              child: Image.asset(
                "assets/remove_icon.png",
                width: 16,
                height: 16,
              ),
            ),
          )
        ],
      ),
    );
  }
}
