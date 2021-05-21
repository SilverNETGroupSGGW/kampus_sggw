import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:kampus_sggw/models/map_item.dart';
import 'package:kampus_sggw/translations/locale_keys.g.dart';
import 'package:url_launcher/url_launcher.dart';
import 'gallery_button.dart';
import 'service_button_row.dart';

class InfoCardDialog extends StatelessWidget {
  final String header;
  final ListView subcategories;
  final ServiceButtonsRow servicesRow;
  final String photoPath;
  final MapItemType mapItemType;
  final Text buildingDescription;
  final List<Image> buildingGallery;
  final List<Widget> otherCategories;
  final Widget facultyTile;
  final String buildingWebsite;

  InfoCardDialog({
    this.header,
    this.subcategories,
    this.servicesRow,
    this.photoPath,
    this.mapItemType,
    this.buildingDescription,
    this.buildingGallery,
    this.otherCategories,
    this.facultyTile,
    this.buildingWebsite,
  });

  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      title: Text(
        header,
        style: Theme.of(context).textTheme.headline3,
        textAlign: TextAlign.center,
      ),
      children: _infoCardChildren(context),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18.0),
      ),
    );
  }

  List<Widget> _infoCardChildren(BuildContext context) {
    List<Widget> children = [];

    children.add(_mapItemImage());
    children.add(_mapItemDescription());
    children.add(_buildingUrlWidget());
    children.add(_subcategoriesDisplay(context));
    children.add(_divider());

    children.add(
      SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Padding(
          padding: EdgeInsets.only(
            bottom: 0,
            left: 5,
            top: 5,
          ),
          child: servicesRow,
        ),
      ),
    );

    children.add(
      Padding(
        padding: const EdgeInsets.only(
          right: 16.0,
          left: 16.0,
        ),
        child: Align(
          alignment: Alignment.bottomRight,
          child: TextButton(
            style: ButtonStyle(animationDuration: Duration(milliseconds: 0)),
            onPressed: () => Navigator.pop(context),
            child: Text(LocaleKeys.close.tr()),
          ),
        ),
      ),
    );

    return children;
  }

  Widget _mapItemImage() {
    if (photoPath == null || photoPath == "") {
      return Center();
    }

    Widget coverImage;
    if (buildingGallery.isEmpty) {
      coverImage = Center();
    } else {
      coverImage = Align(
        alignment: FractionalOffset.bottomRight,
        child: Padding(
          padding: EdgeInsets.only(right: 5),
          child: GalleryButton(buildingGallery),
        ),
      );
    }

    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(photoPath),
          fit: BoxFit.cover,
        ),
      ),
      height: 160,
      child: coverImage,
    );
  }

  Widget _mapItemDescription() {
    if (buildingDescription == null) {
      return Center();
    }

    return Container(
      child: buildingDescription,
      width: 350.0,
      padding: EdgeInsets.all(20),
    );
  }

  Widget _buildingUrlWidget() {
    Future<void> _goToBuildingURL() async {
      if (await canLaunch(buildingWebsite)) {
        await launch(buildingWebsite);
      } else {
        throw 'Could not launch ' + buildingWebsite;
      }
    }

    if (buildingWebsite == null) {
      return Center();
    }
    return Column(
      children: [
        Text(
          LocaleKeys.website.tr(),
          textAlign: TextAlign.center,
          style: TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 16,
            fontFamily: 'SGGWSans',
          ),
        ),
        Padding(
          padding: EdgeInsets.only(top: 5),
          child: GestureDetector(
            onTap: _goToBuildingURL,
            child: Text(
              buildingWebsite,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.blue,
                fontWeight: FontWeight.w500,
                fontSize: 16,
                fontFamily: 'SGGWSans',
              ),
            ),
          ),
        )
      ],
    );
  }

  Widget _subcategoriesDisplay(BuildContext context) {
    if (mapItemType != MapItemType.facultyBuilding) {
      return Center();
    }

    return Container(
      constraints: BoxConstraints(
        minHeight: 0,
        maxHeight: _subcategoriesMaxHeight(context),
      ),
      width: 350.0,
      child: subcategories,
    );
  }

  double _subcategoriesMaxHeight(BuildContext context) {
    double contextHeight = MediaQuery.of(context).size.height;
    double bonusNoServicesHeight = servicesRow != null ? 0 : 100;

    return contextHeight + bonusNoServicesHeight - 520;
  }

  Widget _divider() {
    if (servicesRow == null) {
      return Center();
    }

    return Divider(
      color: Colors.grey[800],
      thickness: 1.5,
      indent: 12.0,
      endIndent: 12.0,
    );
  }
}
