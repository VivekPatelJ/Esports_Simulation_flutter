import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:valorant_strategies_flutter/Models/ValAgents.dart';

class AgentsProvider with ChangeNotifier {
  List<ValAgents> agentsList = [];

  List<ValAgents> get getAgentsList => agentsList;

  Future<void> fetchAgents() async {
    final dio = Dio();
    try {
      var response = await dio.get('https://valorant-api.com/v1/agents');

      var jsonData = response.data;
      List<ValAgents> tempAgents = [];

      for (var agent in jsonData['data']) {
        final newAgent = ValAgents.fromJson(agent);
        tempAgents.add(newAgent);
      }

      agentsList = tempAgents; // Only update list after parsing all agents
      notifyListeners();
    } catch (e) {
      print('Unable to fetch Agents: $e');
    }
  }
}
