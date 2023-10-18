// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'displaymodel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Displaymodel _$DisplaymodelFromJson(Map<String, dynamic> json) => Displaymodel(
      check: (json['check'] as List<dynamic>?)
              ?.map((e) => Crudmodel.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
    );

Map<String, dynamic> _$DisplaymodelToJson(Displaymodel instance) =>
    <String, dynamic>{
      'check': instance.check,
    };
