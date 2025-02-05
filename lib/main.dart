import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:valorant_strategies_flutter/Pages/MainPage.dart';
import 'package:valorant_strategies_flutter/Providers/ValMapsProvider.dart';
import 'package:valorant_strategies_flutter/Providers/ValAgentsProvider.dart';
import 'package:valorant_strategies_flutter/Theme/Custome_Theme.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => MapProvider()),
        ChangeNotifierProvider(create: (context) => AgentsProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Valorant Strategies',
      theme: CustomeTheme.lightMode,
      darkTheme: CustomeTheme.darkMode,
      home:  Mainpage(),
    );
  }
}
