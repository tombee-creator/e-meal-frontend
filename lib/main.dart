import 'package:flutter/material.dart';
import 'package:frontend/views/routes/route_generator.dart';
import 'package:frontend/services/authentication.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Authentication().initialize();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'つみたべ',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.amber),
        useMaterial3: true,
      ),
      onGenerateRoute: RouteGenerator().generateRoute,
      initialRoute: '/',
    );
  }
}
