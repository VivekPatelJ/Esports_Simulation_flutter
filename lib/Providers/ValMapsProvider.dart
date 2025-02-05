import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

import 'package:valorant_strategies_flutter/Models/ValMaps.dart';

class MapProvider with ChangeNotifier {
  List<Valmaps> mapList = [];
  bool isLoading = false; // ✅ Loading state

  List<Valmaps> get getMapList => mapList;

  Future<void> getMap() async {
    final dio = Dio();
    isLoading = true;
    notifyListeners();

    try {
      // ✅ Check for cached maps first
      final prefs = await SharedPreferences.getInstance();
      String? cachedMaps = prefs.getString('cached_maps');

      if (cachedMaps != null) {
        List<dynamic> decodedData = jsonDecode(cachedMaps);
        mapList = decodedData.map((e) => Valmaps.fromJson(e)).toList();
        isLoading = false;
        notifyListeners();
        return; // ✅ Show cached data first!
      }

      // ✅ Fetch data from API if no cache exists
      var response = await dio.get('https://valorant-api.com/v1/maps');
      var jsonData = response.data;

      mapList.clear();
      for (var getMap in jsonData['data']) {
        final maps = Valmaps.fromJson(getMap);
        mapList.add(maps);
      }

      // ✅ Save data to cache
      await prefs.setString('cached_maps', jsonEncode(mapList.map((e) => e.toJson()).toList()));

    } catch (e) {
      print('❌ Unable to fetch Maps: $e');
    }

    isLoading = false;
    notifyListeners();
  }
}
