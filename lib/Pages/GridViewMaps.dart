import 'package:flutter/material.dart';
import 'package:flutter_tilt/flutter_tilt.dart';
import 'package:provider/provider.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:valorant_strategies_flutter/Providers/ValMapsProvider.dart';
import 'package:valorant_strategies_flutter/Utils/CustomeAppBar.dart';

class Gridviewmaps extends StatefulWidget {
  const Gridviewmaps({super.key});

  @override
  State<Gridviewmaps> createState() => _GridviewmapsState();
}

class _GridviewmapsState extends State<Gridviewmaps> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<MapProvider>(context, listen: false).getMap();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Customeappbar(),
      body: Consumer<MapProvider>(
        builder: (context, mapProvider, child) {
          if (mapProvider.getMapList.isEmpty) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          return GridView.builder(
            padding: const EdgeInsets.all(8.0),
            itemCount: mapProvider.getMapList.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 1.0,
            ),
            itemBuilder: (context, index) {
              final map = mapProvider.getMapList[index];
              return Padding(
                padding: const EdgeInsets.all(8.0),
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
                        image: DecorationImage(
                            image: CachedNetworkImageProvider(map.splash),
                            fit: BoxFit.cover),
                      ),
                      child: Center(
                        child: Text(
                          map.displayName,
                          style: TextStyle(
                              fontFamily: 'valorantfonts', fontSize: 25.0),
                        ),
                      )),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
