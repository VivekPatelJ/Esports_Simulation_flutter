import 'package:cached_network_image/cached_network_image.dart';
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
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<AgentsProvider>(context, listen: false).fetchAgents();
    });
  }

  // Hex to Color conversion function
  Color HexToColor(String hex) {
    final buffer = StringBuffer();
    if (hex.length == 6 || hex.length == 7) buffer.write('ff');
    buffer.write(hex.replaceFirst('#', ''));
    return Color(int.parse('0x${buffer.toString()}'));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Customeappbar(),
      body: Consumer<AgentsProvider>(
        builder: (context, agentsProvider, child) {
          if (agentsProvider.agentsList.isEmpty) {
            return const Center(child: CircularProgressIndicator());
          }

          return GridView.builder(
            padding: const EdgeInsets.all(8.0),
            itemCount: agentsProvider.agentsList.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              childAspectRatio: 1.0,
            ),
            itemBuilder: (context, index) {
              final agent = agentsProvider.agentsList[index];

              // Check if backgroundGradientColors is null before using it
              List<Color> gradientColors = agent.backgroundGradientColors != null
                  ? agent.backgroundGradientColors!
                      .map((colorHex) => HexToColor(colorHex))
                      .toList()
                  : []; // Provide an empty list if null

              return Padding(
                padding: const EdgeInsets.all(12.0),
                child: Container(
                  decoration: BoxDecoration(
                    // Apply gradient if backgroundGradientColors is not empty
                    gradient: gradientColors.isNotEmpty
                        ? LinearGradient(
                            colors: gradientColors,
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          )
                        : null, // No gradient if the list is empty
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  child: Stack(
                    children: [
                      // If gradient is not available, use the default background image
                      Positioned.fill(
                        child: CachedNetworkImage(
                          imageUrl: agent.background,
                          fit: BoxFit.cover,
                          alignment: Alignment.center,
                          // If image fails to load, show a placeholder and error widget
                          placeholder: (context, url) =>
                              const Center(child: CircularProgressIndicator()),
                          errorWidget: (context, url, error) =>
                              const Center(child: Icon(Icons.error)),
                        ),
                      ),
                      Center(
                        child: Image(
                          image: CachedNetworkImageProvider(agent.displayIconSmall),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
