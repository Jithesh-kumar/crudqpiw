import 'package:crud_new/data/crudmodel/crudmodel.dart';
import 'package:json_annotation/json_annotation.dart';

part 'displaymodel.g.dart';

@JsonSerializable()
class Displaymodel {
  @JsonKey(name: 'check')
  List<Crudmodel> check;

  Displaymodel({this.check = const []});

  factory Displaymodel.fromJson(Map<String, dynamic> json) {
    return _$DisplaymodelFromJson(json);
  }

  Map<String, dynamic> toJson() => _$DisplaymodelToJson(this);
}
