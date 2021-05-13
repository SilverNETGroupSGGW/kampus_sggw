import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:kampus_sggw/models/category.dart';
import 'package:kampus_sggw/models/map_item.dart';
import 'package:kampus_sggw/translations/locale_keys.g.dart';
import 'category_item.dart';
import 'floor_tile.dart';
import 'gallery_button.dart';
import 'service_button_row.dart';

class InfoCardDialog extends StatelessWidget {
  String header;
  ListView description;
  ServiceButtonsRow servicesRow;
  String photoPath;
  MapItemType mapItemType;
  Text buildingDescription;
  List<Image> buildingGallery = [];
  List<Widget> otherCategories = [];
  Widget facultyTile;

  final headerStyle = TextStyle(
      fontWeight: FontWeight.w600, fontSize: 26, fontFamily: 'SGGWMastro');

  InfoCardDialog({this.header, this.description});

  InfoCardDialog.fromMapItem(MapItem mapItem) {
    this.header = mapItem.name;
    this.photoPath = mapItem.photoPath;
    this.mapItemType = mapItem.type;

    if (mapItem.gallery != null && mapItem.gallery.isNotEmpty) {
      for (var image in mapItem.gallery) {
        buildingGallery.add(Image.network(image));
      }
    }

    if (mapItem.categories != null && mapItem.categories.isNotEmpty) {
      final data = mapItem.categories;
      for (Category category in data) {
        if (category.name == 'faculties') {
          facultyTile = CategoryItem(category);
        } else {
          for (Category subCategory in category.subCategories)
            otherCategories.add(CategoryItem(subCategory));
        }
      }
      this.description = _buildDescription();
    }

    if (mapItem.description != null) {
      this.buildingDescription = Text(
        mapItem.description,
        textAlign: TextAlign.center,
        style: TextStyle(
            fontWeight: FontWeight.w500, fontSize: 16, fontFamily: 'SGGWSans'),
      );
    }

    if (mapItem.services != null && mapItem.services.isNotEmpty) {
      this.servicesRow = ServiceButtonsRow(mapItem.services);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      title: Text(header, style: headerStyle, textAlign: TextAlign.center),
      children: [
        Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(photoPath),
              fit: BoxFit.cover,
            ),
          ),
          child: (buildingGallery.isNotEmpty
              ? Align(
                  alignment: FractionalOffset.bottomRight,
                  child: Padding(
                      padding: EdgeInsets.only(right: 5),
                      child: GalleryButton(buildingGallery)),
                )
              : Center()),
          height: 160,
        ),
        (buildingDescription != null
            ? Container(
                child: buildingDescription,
                height: 60.0,
                width: 350.0,
                padding: EdgeInsets.all(20))
            : Center()),
        (mapItemType == MapItemType.facultyBuilding
            ? Container(
                constraints: BoxConstraints(minHeight: 0, maxHeight: 450),
                child: description,
                width: 350.0,
              )
            : Center()),
        (servicesRow != null
            ? Divider(
                color: Colors.grey[800],
                thickness: 1.5,
                indent: 12.0,
                endIndent: 12.0,
              )
            : Center()),
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
        Padding(
          padding: const EdgeInsets.only(
            right: 16.0,
            left: 16.0,
          ),
          child: Align(
              alignment: Alignment.bottomRight,
              child: TextButton(
                style:
                    ButtonStyle(animationDuration: Duration(milliseconds: 0)),
                onPressed: () => Navigator.pop(context),
                child: Text(LocaleKeys.close.tr()),
              )),
        ),
      ],
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18.0),
      ),
    );
  }

  ListView _buildDescription() {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: _descriptionItemsCount(),
      itemBuilder: _descriptionItemsBuilder,
    );
  }

  int _descriptionItemsCount() {
    int isFaculty = facultyTile != null ? 1 : 0;
    int hasOtherCategories = otherCategories.length > 0 ? 1 : 0;

    return isFaculty + hasOtherCategories + 1;
  }

  Widget _descriptionItemsBuilder(BuildContext context, int index) {
    if ((facultyTile != null && index == 1) ||
        (facultyTile == null && index == 0)) {
      return ExpansionTile(
        title: Text(LocaleKeys.building_plans.tr()),
        leading: Icon(Icons.map),
        children: [
          // TODO: load floors from mapItem
          FloorTile(
            Image.asset("assets/images/floors/floor_1.jpg"),
            LocaleKeys.ground.tr() + " I",
          ),
          FloorTile(
            Image.asset("assets/images/floors/floor_1.jpg"),
            LocaleKeys.ground.tr() + " II",
          ),
          FloorTile(
            Image.asset("assets/images/floors/floor_1.jpg"),
            LocaleKeys.ground.tr() + " III",
          ),
          FloorTile(
            Image.asset("assets/images/floors/floor_1.jpg"),
            LocaleKeys.ground.tr() + " IV",
          ),
        ],
      );
    }
    if (index == 2 || (facultyTile == null && index == 1)) {
      if (otherCategories != null && otherCategories.isNotEmpty) {
        return ExpansionTile(
          leading: Icon(Icons.build_outlined),
          title: Text(LocaleKeys.other_institutions.tr()),
          children: otherCategories,
        );
      }
    }

    return facultyTile;
  }
}
