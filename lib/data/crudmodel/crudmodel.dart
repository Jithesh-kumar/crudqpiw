import 'package:json_annotation/json_annotation.dart';

part 'crudmodel.g.dart';

@JsonSerializable()
class Crudmodel {
  @JsonKey(name: '_id')
  String? id;
  @JsonKey(name: 'F_name')
  String? fName;
  @JsonKey(name: 'L_name')
  String? lName;
  @JsonKey(name: 'email')
  String? email;
  @JsonKey(name: 'dob')
  String? dob;
  @JsonKey(name: 'phone')
  String? phone;
  @JsonKey(name: 'acc_num')
  String? accNum;

  Crudmodel({
    this.id,
    this.fName,
    this.lName,
    this.email,
    this.dob,
    this.phone,
    this.accNum,
  });
  Crudmodel.create({
    required this.id,
    required this.fName,
    required this.lName,
    required this.email,
    required this.dob,
    required this.phone,
    required this.accNum,
  });

  factory Crudmodel.fromJson(Map<String, dynamic> json) {
    return _$CrudmodelFromJson(json);
  }

  Map<String, dynamic> toJson() => _$CrudmodelToJson(this);
}
