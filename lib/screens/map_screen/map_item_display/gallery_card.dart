import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:kampus_sggw/screens/map_screen/photo_card.dart';
import 'package:kampus_sggw/translations/locale_keys.g.dart';

class GalleryCard extends StatelessWidget {
  final List<Image>? images;
  GalleryCard({this.images});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SimpleDialog(
        title: Text(
          LocaleKeys.gallery.tr(),
          textAlign: TextAlign.center,
          style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 26,
              fontFamily: 'SGGWMastro'),
        ),
        children: [
          Container(
            width: 350,
            height: 450,
            child: GridView.count(
              crossAxisCount: 2,
              children: _photoViewers(),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 16.0, left: 16.0),
            child: Align(
              alignment: Alignment.bottomRight,
              child: TextButton(
                style: ButtonStyle(
                  animationDuration: Duration(milliseconds: 0),
                ),
                onPressed: () => Navigator.pop(context),
                child: Text(LocaleKeys.close.tr()),
              ),
            ),
          ),
        ],
      ),
    );
  }

  List<Widget> _photoViewers() {
    return images!.map((image) => PhotoViewer(image)).toList();
  }
}

class PhotoViewer extends StatefulWidget {
  final Image image;

  PhotoViewer(this.image);

  @override
  _PhotoViewer createState() => _PhotoViewer();
}

class _PhotoViewer extends State<PhotoViewer> {
  static Image? _selectedImage;

  static Route<void> _dialogBuilder(BuildContext context, Object? arguments) {
    return DialogRoute<void>(
      context: context,
      builder: (BuildContext context) => PhotoCard(
        heading: LocaleKeys.photo.tr(),
        image: _selectedImage,
      ),
    );
  }

  void _showGalleryCard(Image image) {
    _selectedImage = image;
    Navigator.of(context).restorablePush(_dialogBuilder);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: GridTile(
        child: widget.image,
      ),
      onTap: () {
        _showGalleryCard(widget.image);
      },
    );
  }
}
