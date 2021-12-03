import 'package:flutter/material.dart';
import 'gallery_card.dart';

class GalleryButton extends StatefulWidget {
  final List<Image>? images;

  GalleryButton(this.images);

  @override
  _GalleryButton createState() => _GalleryButton();
}

class _GalleryButton extends State<GalleryButton> {
  static List<Image>? _selectedImages;

  static Route<void> _dialogBuilder(BuildContext context, Object? arguments) {
    return DialogRoute<void>(
      context: context,
      builder: (BuildContext context) => GalleryCard(images: _selectedImages),
    );
  }

  void _showGalleryCard(List<Image>? images) {
    _selectedImages = images;
    Navigator.of(context).restorablePush(_dialogBuilder);
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      child: Icon(Icons.photo),
      style: ElevatedButton.styleFrom(
        primary: Colors.green,
        onPrimary: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(90.0),
        ),
      ),
      onPressed: () {
        _showGalleryCard(widget.images);
      },
    );
  }
}