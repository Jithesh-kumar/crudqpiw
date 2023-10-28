import 'dart:convert';
//import 'dart:ffi';
//import 'dart:math';

import 'package:crud_new/data/crudmodel/crudmodel.dart';
import 'package:crud_new/data/displaymodel/displaymodel.dart';
import 'package:crud_new/data/url.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

abstract class ApiCalls {
  Future<Crudmodel?> createCust(Crudmodel value);
  Future<List<Crudmodel>> displayCust();
  Future<Crudmodel?> updateCust(Crudmodel value);
  Future<void> deleteCust(String id);
}

class CrudDB extends ApiCalls {
  CrudDB._internal();
  static CrudDB instance = CrudDB._internal();
  CrudDB factory() {
    return instance;
  }

  final dio = Dio();
  final url = Url();

  ValueNotifier<List<Crudmodel>> crudListNotifier = ValueNotifier([]);
  CrudDB() {
    dio.options = BaseOptions(
      baseUrl: url.baseUrl,
      responseType: ResponseType.plain,
    );
  }
  @override
  Future<Crudmodel?> createCust(Crudmodel value) async {
    final _result = await dio.post(
      url.createCust,
      data: value.toJson(),
    );

    //return _result.data;
    // Crudmodel.fromJson(_result.data);
    // return null;
    final _resultAsjson = jsonDecode(_result.data);
    return Crudmodel.fromJson(_resultAsjson as Map<String, dynamic>);
  }

  @override
  Future<void> deleteCust(String id) async {
    throw UnimplementedError();
  }

  @override
  // Future<List<Crudmodel>> displayCust() async {
  //   try {
  //     //print("Making request to: ${url.baseUrl + url.displayCust}");
  //     final _result = await dio.get(url.baseUrl + url.displayCust);
  //     //print("Response status code: ${_result.statusCode}");
  //     //print("Response data: ${_result.data}");
  //     // final _result = await dio.get(url.baseUrl + url.displayCust);
  //     if (_result.data != null) {
  //       final _resultAsJson = jsonDecode(_result.data);
  //       final displaymodel = Displaymodel.fromJson(_resultAsJson);
  //       return displaymodel.check;
  //     } else {
  //       return _result.data!.data;
  //     }
  //   } catch (e) {
  //     print("Error fetching data: $e");
  //     return [];
  //   }
  // }

  // Future<List<Crudmodel>> displayCust() async {
  //   try {
  //     final _result = await dio.get(url.baseUrl + url.displayCust);

  //     print("Response status code: ${_result.statusCode}");
  //     print("Response data: ${_result.data}");

  //     if (_result.statusCode == 200) {
  //       final dynamic _resultAsJson = jsonDecode(_result.data);

  //       if (_resultAsJson is Map<String, dynamic> &&
  //           _resultAsJson.containsKey("check")) {
  //         final displaymodel = Displaymodel.fromJson(_resultAsJson);
  //         return displaymodel.check;
  //       } else {
  //         // Handle the case where the data structure is not as expected
  //         print("Unexpected data format");
  //         return [];
  //       }
  //     } else {
  //       // Handle non-200 status codes
  //       print("Request failed with status code: ${_result.statusCode}");
  //       return [];
  //     }
  //   } catch (e) {
  //     print("Error fetching data: $e");
  //     return [];
  //   }
  // }

  Future<List<Crudmodel>> displayCust() async {
    try {
      final _result = await dio.get(url.baseUrl + url.displayCust);

      if (_result.statusCode == 200) {
        if (_result.data is Map<String, dynamic> &&
            _result.data.containsKey("responseData") &&
            _result.data["responseData"] is Map<String, dynamic> &&
            _result.data["responseData"].containsKey("check")) {
          final displaymodel =
              Displaymodel.fromJson(_result.data["responseData"]);

          crudListNotifier.value.clear();
          crudListNotifier.value.addAll(displaymodel.check.reversed);
          return displaymodel.check;
        } else {
          crudListNotifier.value.clear();
          return [];
        }
      } else {
        print("Request failed with status code: ${_result.statusCode}");
        return [];
      }
    } catch (e) {
      print("Error fetching data: $e");
      return [];
    }
  }

  @override
  Future<Crudmodel?> updateCust(Crudmodel value) async {
    final _result = await dio.put(url.updateCust, data: value.toJson());
    if (_result.data == null) {
      return null;
    }
  }

  Crudmodel? getCrudByID(String id) {
    try {
      return crudListNotifier.value.firstWhere((crud) => crud.id == id);
    } catch (_) {
      return null;
    }
  }
}
