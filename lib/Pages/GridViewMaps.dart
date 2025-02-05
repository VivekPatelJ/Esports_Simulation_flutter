import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cached_network_image/cached_network_image.dart'; // ✅ Import the caching package
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
            return const Center(child: CircularProgressIndicator());
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
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15.0),
                    image: DecorationImage(
                      image: CachedNetworkImageProvider(map.splash), // ✅ Cached Image
                      colorFilter: const ColorFilter.mode(
                        Color.fromARGB(84, 0, 0, 0),
                        BlendMode.darken,
                      ),
                      fit: BoxFit.cover,
                    ),
                    color: Theme.of(context).colorScheme.secondaryContainer,
                  ),
                  child: Center(
                    child: Text(
                      map.displayName,
                      style: const TextStyle(
                        fontSize: 25.0,
                        fontFamily: 'valorantfonts',
                        fontWeight: FontWeight.w200,
                      ),
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
