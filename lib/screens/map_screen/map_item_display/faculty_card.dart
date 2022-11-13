import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:kampus_sggw/global_widgets/clickable_url.dart';
import 'package:kampus_sggw/models/category.dart';
import 'package:kampus_sggw/translations/locale_keys.g.dart';
import 'service_button_row.dart';

class FacultyCard extends StatelessWidget {
  final Category? category;
  final ServiceButtonsRow? servicesRow;

  FacultyCard({this.category, this.servicesRow});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SimpleDialog(
        title: Text(
          category!.name!,
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.headline3,
        ),
        children: [
          _descriptionWidget(),
          _subCategories(),
          _websiteUrl(),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Padding(
              padding: EdgeInsets.only(
                bottom: 0,
                left: 5,
                top: 15,
              ),
              child: servicesRow,
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

  Widget _descriptionWidget() {
    if (category!.description == null) {
      return Center();
    }
    return Padding(
      padding: EdgeInsets.all(5),
      child: Text(
        category!.description!,
        textAlign: TextAlign.center,
      ),
    );
  }

  Widget _websiteUrl() {
    if (category!.url == null) {
      return Center();
    }

    return ClickableUrl(url: category!.url);
  }

  Widget _subCategories() {
    if (category!.subCategories == null ||
        category!.subCategories!.isEmpty ||
        category!.subCategories![0].name != 'departments') {
      return Center();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Divider(
          color: Colors.grey[800],
          thickness: 1.5,
          indent: 12.0,
          endIndent: 12.0,
        ),
        Padding(
          padding: EdgeInsets.only(bottom: 10),
          child: Text(LocaleKeys.departments.tr()),
        ),
        for (var i = 0; i < category!.subCategories![0].subCategories!.length; i++)
          Padding(
            padding: EdgeInsets.only(left: 10, bottom: 5, right: 10),
            child: Text(
              category!.subCategories![0].subCategories![i].name!,
              textAlign: TextAlign.center,
            ),
          )
      ],
    );
  }
}
