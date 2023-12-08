import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'core/local/db/isar_db.dart';

void main() async{

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
    return const MaterialApp(
      home: Scaffold(
        body: Center(
          child: Text('Hello World!'),
        ),
      ),
    );
  }
}
