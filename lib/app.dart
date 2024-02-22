import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gemini_app/page/home.dart';
import 'package:yaml/yaml.dart';

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  String apiKey = "";
  @override
  void initState() {
    loadEnv();
    super.initState();
  }

  Future<void> loadEnv() async {
    final String yamlString = await rootBundle.loadString("pubspec.yaml");
    final dynamic parsedYaml = loadYaml(yamlString);
    setState(() {
      apiKey = parsedYaml["gemini_key"];
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Gemini Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: Home(apiKey: apiKey),
    );
  }
}
