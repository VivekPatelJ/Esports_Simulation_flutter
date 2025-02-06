import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tilt/flutter_tilt.dart';
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
            padding: const EdgeInsets.all(10.0),
            itemCount: agentsProvider.agentsList.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              childAspectRatio: 1.0,
            ),
            itemBuilder: (context, index) {
              final agent = agentsProvider.agentsList[index];

              // Check if backgroundGradientColors is null before using it
              List<Color> gradientColors =
                  agent.backgroundGradientColors != null
                      ? agent.backgroundGradientColors!
                          .map((colorHex) => HexToColor(colorHex))
                          .toList()
                      : []; // Provide an empty list if null

              return Padding(
                padding: const EdgeInsets.all(12.0),
                child: Tilt(
                  borderRadius: BorderRadius.circular(12.0),
                  tiltConfig: TiltConfig(angle: 15.0),
                  lightConfig: LightConfig(minIntensity: 0.1),
                  shadowConfig: const ShadowConfig(
                    minIntensity: 0.05,
                    maxIntensity: 0.4,
                    offsetFactor: 0.08,
                    minBlurRadius: 10,
                    maxBlurRadius: 15,
                  ),
                  childLayout: ChildLayout(
                    outer: [
                      Positioned(
                        top: 200,
                        child: TiltParallax(
                          size: const Offset(-20, -20),
                          child: Container(),
                        ),
                      ),
                    ],
                  ),
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: gradientColors.isNotEmpty
                          ? LinearGradient(
                              colors: gradientColors,
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            )
                          : null,
                      image: DecorationImage(
                          image: CachedNetworkImageProvider(agent.background),
                          fit: BoxFit.cover),
                    ),
                    child: Image(
                      image: CachedNetworkImageProvider(agent.displayIconSmall),
                    ),
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
