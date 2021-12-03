import 'package:flutter/material.dart';
import 'package:kampus_sggw/models/category.dart';
import 'package:kampus_sggw/models/map_item.dart';
import 'package:kampus_sggw/screens/map_screen/map_item_display/info_card.dart';
import 'package:kampus_sggw/screens/map_screen/map_item_display/category_item.dart';
import 'package:kampus_sggw/screens/map_screen/map_item_display/service_button_row.dart';

class InfoCardDialogBuilder {
  String? header;
  ListView? description;
  ServiceButtonsRow? servicesRow;
  String? photoPath;
  Text? mapItemDescription;
  List<Image> mapItemGallery = [];
  List<Widget> otherCategories = [];
  Widget? facultyTile;
  Widget? instituteTile;
  Widget? officesTile;
  String? mapItemWebsite;

  InfoCardDialog fromMapItem(MapItem mapItem) {
    if (mapItem.gallery != null && mapItem.gallery!.isNotEmpty) {
      for (var image in mapItem.gallery!) {
        mapItemGallery.add(Image.network(image));
      }
    }

    if (mapItem.categories != null && mapItem.categories!.isNotEmpty) {
      final data = mapItem.categories!;
      for (Category category in data) {
        if (category.name == 'faculties') {
          facultyTile = CategoryItem(category);
        } else if (category.name == 'institutes') {
          instituteTile = CategoryItem(category);
        } else if (category.name == 'offices') {
          officesTile = CategoryItem(category);
        } else {
          for (Category subCategory in category.subCategories!)
            otherCategories.add(CategoryItem(subCategory));
        }
      }
      description = _buildDescription();
    } else {
      description = ListView(
        shrinkWrap: true,
      );
    }

    if (mapItem.description != null && mapItem.description!.isNotEmpty) {
      mapItemDescription = Text(
        mapItem.description!,
        textAlign: TextAlign.center,
        style: TextStyle(
            fontWeight: FontWeight.w500, fontSize: 16, fontFamily: 'SGGWSans'),
      );
    }

    if (mapItem.services != null && mapItem.services!.isNotEmpty) {
      servicesRow = ServiceButtonsRow(mapItem.services);
    }

    if (mapItem.url != null) {
      mapItemWebsite = mapItem.url;
    }

    return InfoCardDialog(
      header: mapItem.name,
      subcategories: description,
      servicesRow: servicesRow,
      photoPath: mapItem.photoPath,
      type: mapItem.functionGroup,
      mapItemDescription: mapItemDescription,
      mapItemGallery: mapItemGallery,
      otherCategories: otherCategories,
      facultyTile: facultyTile,
      mapItemWebsite: mapItemWebsite,
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
    int isInstitute = instituteTile != null ? 1 : 0;
    int isOffice = officesTile != null ? 1 : 0;
    int hasOtherCategories = otherCategories.length > 0 ? 1 : 0;

    return isFaculty + isInstitute + isOffice + hasOtherCategories;
  }

  Widget _descriptionItemsBuilder(BuildContext context, int index) {
    if (facultyTile != null && index == 0) return facultyTile!;
    if (instituteTile != null && index == 1 ||
        facultyTile != null && index == 0) return instituteTile!;
    if (facultyTile == null && instituteTile == null) return officesTile!;
    return new ListTile();
  }
}
