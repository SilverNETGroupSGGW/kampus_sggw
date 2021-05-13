import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:kampus_sggw/models/category.dart';
import 'package:kampus_sggw/models/map_item.dart';
import 'package:kampus_sggw/screens/map_screen/gallery_card.dart';
import 'package:kampus_sggw/screens/map_screen/photo_card.dart';
import 'package:kampus_sggw/screens/map_screen/faculty_card.dart';
import 'package:kampus_sggw/translations/locale_keys.g.dart';
import 'package:kampus_sggw/screens/map_screen/service_button_row.dart';

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
      this.description = ListView.builder(
        shrinkWrap: true,
        itemCount: (facultyTile != null ? 1 : 0) +
            1 +
            (otherCategories.length > 0 ? 1 : 0),
        itemBuilder: (BuildContext context, int index) {
          if (index == 1 || facultyTile == null && index == 0) {
            return ExpansionTile(
              title: Text(LocaleKeys.building_plans.tr()),
              leading: Icon(Icons.map),
              children: [
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
          if (index == 2) {
            if (otherCategories != null && otherCategories.isNotEmpty)
              return ExpansionTile(
                leading: Icon(Icons.build_outlined),
                title: Text(LocaleKeys.other_institutions.tr()),
                children: otherCategories,
              );
          }
          if (facultyTile != null) return facultyTile;
        },
      );
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
      this.servicesRow = ServiceButtonsRow.fromServices(mapItem.services);
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
}

class CategoryItem extends StatefulWidget {
  final Category category;
  CategoryItem(this.category);
  @override
  _CategoryItemState createState() => _CategoryItemState();
}

class _CategoryItemState extends State<CategoryItem> {
  static Category _category;

  @override
  Widget build(BuildContext context) {
    return _buildTiles(widget.category);
  }

  Widget _buildTiles(Category root, {bool isFaculty = false}) {
    if (isFaculty) {
      return ListTile(
        leading: Icon(Icons.info_outline),
        title: Text(root.name),
        onTap: () {
          showFacultyCard(root);
        },
      );
    }
    if (root.subCategories != null && root.subCategories.isNotEmpty) {
      return ExpansionTile(
        leading: (root.name == 'faculties' ? Icon(Icons.science) : null),
        key: PageStorageKey<Category>(root),
        title: Text(
            root.name == 'faculties' ? LocaleKeys.faculties.tr() : root.name),
        children: root.subCategories.map<Widget>((sub) {
          return _buildTiles(sub, isFaculty: root.name == 'faculties');
        }).toList(),
      );
    }
    return ListTile(
      leading: Icon(Icons.info_outline),
      title: Text(root.name),
    );
  }

  showFacultyCard(Category category) {
    _category = category;
    Navigator.of(context).restorablePush(_dialogBuilder);
  }

  static Route<Object> _dialogBuilder(BuildContext context, Object arguments) {
    ServiceButtonsRow categoryServiceRow;
    if (_category.services != null && _category.services.isNotEmpty) {
      categoryServiceRow = ServiceButtonsRow.fromServices(_category.services);
    }
    return DialogRoute<void>(
      context: context,
      builder: (BuildContext context) => FacultyCard(
        category: _category,
        servicesRow: categoryServiceRow,
      ),
    );
  }
}

class FloorTile extends StatefulWidget {
  final Image floorPlan;
  final String floorNum;

  FloorTile(this.floorPlan, this.floorNum);

  @override
  _FloorTile createState() => _FloorTile();
}

class _FloorTile extends State<FloorTile> {
  static Image _selectedFloorPlan;
  static String _selectedFloornum;

  static Route<Object> _dialogBuilder(BuildContext context, Object arguments) {
    return DialogRoute<void>(
      context: context,
      builder: (BuildContext context) => PhotoCard(
        image: _selectedFloorPlan,
        heading: _selectedFloornum,
      ),
    );
  }

  showFloorCard(Image floorPlan, String floorNum) {
    _selectedFloorPlan = floorPlan;
    _selectedFloornum = floorNum;
    Navigator.of(context).restorablePush(_dialogBuilder);
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(Icons.info_outline),
      title: Text(widget.floorNum),
      onTap: () {
        showFloorCard(widget.floorPlan, widget.floorNum);
      },
    );
  }
}

class GalleryButton extends StatefulWidget {
  List<Image> images;

  GalleryButton(this.images);

  @override
  _GalleryButton createState() => _GalleryButton();
}

class _GalleryButton extends State<GalleryButton> {
  static List<Image> _selectedImages;

  static Route<Object> _dialogBuilder(BuildContext context, Object arguments) {
    return DialogRoute<void>(
      context: context,
      builder: (BuildContext context) => GalleryCard(images: _selectedImages),
    );
  }

  showGalleryCard(List<Image> images) {
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
        showGalleryCard(widget.images);
      },
    );
  }
}
