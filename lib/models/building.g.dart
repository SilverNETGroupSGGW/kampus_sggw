// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'building.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Building _$BuildingFromJson(Map<String, dynamic> json) {
  return Building(
    json['id'],
    json['geoLocation'],
    json['name'],
    json['description'],
    json['url'],
    json['type'],
    json['photoPath'],
    json['minScale'],
    json['lastModified'],
    json['gallery'],
    (json['services'] as List)
        ?.map((e) =>
            e == null ? null : Service.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    (json['categories'] as List)
        ?.map((e) =>
            e == null ? null : Category.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$BuildingToJson(Building instance) => <String, dynamic>{
      'id': instance.id,
      'geoLocation': instance.geoLocation,
      'name': instance.name,
      'description': instance.description,
      'url': instance.url,
      'type': _$MapItemTypeEnumMap[instance.type],
      'photoPath': instance.photoPath,
      'minScale': instance.minScale,
      'lastModified': instance.lastModified?.toIso8601String(),
      'gallery': instance.gallery,
      'services': instance.services,
      'categories': instance.categories,
    };

const _$MapItemTypeEnumMap = {
  MapItemType.facultyBuilding: 'facultyBuilding',
  MapItemType.administrationBuilding: 'administrationBuilding',
  MapItemType.sportsFacility: 'sportsFacility',
  MapItemType.store: 'store',
  MapItemType.food: 'food',
  MapItemType.library: 'library',
  MapItemType.parking: 'parking',
  MapItemType.transport: 'transport',
  MapItemType.finance: 'finance',
  MapItemType.dormitories: 'dormitories',
  MapItemType.kindergarten: 'kindergarten',
  MapItemType.monument: 'monument',
  MapItemType.medicine: 'medicine',
};
