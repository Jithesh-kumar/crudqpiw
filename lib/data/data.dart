import 'package:crud_new/data/crudmodel/crudmodel.dart';
import 'package:crud_new/data/displaymodel/displaymodel.dart';
import 'package:crud_new/data/url.dart';
import 'package:dio/dio.dart';

abstract class ApiCalls {
  Future<Crudmodel?> createCust(Crudmodel value);
  Future<List<Crudmodel>> displayCust();
  Future<Crudmodel?> updateCust(Crudmodel value);
  Future<void> deleteCust(String id);
}

class CrudDB extends ApiCalls {
  final dio = Dio();
  final url = Url();
  @override
  Future<Crudmodel?> createCust(Crudmodel value) async {
    final _result = await dio.post(
      url.baseUrl + url.createCust,
      data: value.toJson(),
    );
    print(_result.data);
    return _result.data;
  }

  @override
  Future<void> deleteCust(String id) async {
    // TODO: implement deleteCust
    throw UnimplementedError();
  }

  @override
  Future<List<Crudmodel>> displayCust() async {
    final _result = await dio.get<Displaymodel>(url.baseUrl + url.displayCust);
    if (_result.data == null) {
      return [];
    } else {
      return _result.data!.check;
    }
  }

  @override
  Future<Crudmodel?> updateCust(Crudmodel value) async {
    // TODO: implement updateCust
    throw UnimplementedError();
  }
}
