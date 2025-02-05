import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:valorant_strategies_flutter/Models/ValAgents.dart';

class AgentsProvider with ChangeNotifier {
  List<Agents> _agentsList = [];

  List<Agents> get agentsList => _agentsList;

  Future<void> fetchAgents() async {
    final dio = Dio();
    try {
      var response = await dio.get('https://valorant-api.com/v1/agents');
      var jsonData = response.data;

      _agentsList.clear(); // Clear previous data
      for (var getAgents in jsonData['data']) {
        final agents = Agents(
          displayName: getAgents['displayName'],
          description: getAgents['description'],
          displayIconSmall: getAgents['displayIconSmall'],
          background: getAgents['background'],
        );
        _agentsList.add(agents);
      }
      notifyListeners(); // Notify UI to rebuild
    } catch (e) {
      print('Error occurred: $e');
    }
  }
}
