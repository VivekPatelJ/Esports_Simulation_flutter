import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:valorant_strategies_flutter/Models/ValMaps.dart';

class MapProvider with ChangeNotifier {
  List<Valmaps> mapList = [];

  List<Valmaps> get getMapList => mapList;

  Future<void> getMap() async {
    final dio = Dio();
    try {
      var response = await dio.get('https://valorant-api.com/v1/maps');
      var jsonData = response.data;

      mapList.clear();

      for (var getMap in jsonData['data']) {
        final maps = Valmaps.fromJson(getMap);
        mapList.add(maps);
      }
      notifyListeners();
    } catch (e) {
      print('Unable to fetch Maps : $e');
    }
  }
}
