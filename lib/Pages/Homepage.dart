import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:valorant_strategies_flutter/Providers/ValAgentsProvider.dart';
import 'package:valorant_strategies_flutter/Utils/CustomeAppBar.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  late Future<void> _fetchAgentsFuture;

  @override
  void initState() {
    super.initState();
    _fetchAgentsFuture = Future.microtask(() =>
        Provider.of<AgentsProvider>(context, listen: false).fetchAgents());
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _fetchAgentsFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        }

        final agentsProvider = Provider.of<AgentsProvider>(context);
        final agentsList = agentsProvider.agentsList;

        if (agentsList.isEmpty) {
          return const Center(child: Text("No agents found!"));
        }

        return Scaffold(
          appBar: Customeappbar(),
          body: ListView.builder(
            itemCount: agentsList.length,
            itemBuilder: (context, index) {
              final agent = agentsList[index];
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.secondaryContainer,
                    borderRadius: BorderRadius.circular(12.0),
                    image: DecorationImage(
                      image: NetworkImage(agent.background),
                      fit: BoxFit.cover,
                      colorFilter: ColorFilter.mode(
                        Colors.black.withOpacity(0.5),
                        BlendMode.darken,
                      ),
                    ),
                  ),
                  child: ListTile(
                    leading: Image.network(agent.displayIconSmall),
                    title: Text(
                      agent.displayName,
                      style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w500, color: Colors.white),
                    ),
                    subtitle: Text(agent.description, style: const TextStyle(color: Colors.white)),
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }
}
