import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:kampus_sggw/models/category.dart';
import 'package:kampus_sggw/translations/locale_keys.g.dart';
import 'faculty_card.dart';
import 'service_button_row.dart';

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
      categoryServiceRow = ServiceButtonsRow(_category.services);
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