// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'crudmodel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Crudmodel _$CrudmodelFromJson(Map<String, dynamic> json) => Crudmodel(
      id: json['_id'] as String?,
      fName: json['F_name'] as String?,
      lName: json['L_name'] as String?,
      email: json['email'] as String?,
      dob: json['dob'] as String?,
      phone: json['phone'] as String?,
      accNum: json['acc_num'] as String?,
    );

Map<String, dynamic> _$CrudmodelToJson(Crudmodel instance) => <String, dynamic>{
      '_id': instance.id,
      'F_name': instance.fName,
      'L_name': instance.lName,
      'email': instance.email,
      'dob': instance.dob,
      'phone': instance.phone,
      'acc_num': instance.accNum,
    };
