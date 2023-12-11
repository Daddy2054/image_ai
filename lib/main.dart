import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'core/local/db/isar_db.dart';
import 'features/image/presentation/ui/image_list_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final container = ProviderContainer();
  final db = container.read(isarDbProvider);
  await db.openDb();

  runApp(
    ProviderScope(
      parent: container,
      child: const MainApp(),
    ),
  );
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: FlexThemeData.light(
        scheme: FlexScheme.redWine,
        useMaterial3: true,
        useMaterial3ErrorColors: true,
      ),
      darkTheme: FlexThemeData.dark(
        scheme: FlexScheme.redWine,
        useMaterial3: true,
        useMaterial3ErrorColors: true,
      ),
      themeMode: ThemeMode.system,
      home: const ImageListScreen(),
    );
  }
}
