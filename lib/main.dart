// lib/main.dart
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';

import 'models/storage_item.dart';
import 'providers/storage_provider.dart';
import 'screens/home_screen.dart';

final ColorScheme warmColorScheme = ColorScheme.fromSeed(
  seedColor: Colors.amber,
  brightness: Brightness.light,

  // AppBar / actions principales
  primary: const Color(0xFFFFB300), // ambre soutenu
  onPrimary: Colors.brown,

  // accents
  secondary: const Color(0xFFFF8F00), // ambre plus profond
  onSecondary: Colors.white,

  // fond moins clair
  surface: const Color(0xFFF3E5AB),
  background: const Color(0xFFF0E0B2),

  onSurface: Colors.brown,
  onBackground: Colors.brown,
);

final ColorScheme darkWarmScheme = ColorScheme.fromSeed(
  seedColor: Colors.amber,
  brightness: Brightness.dark,
);

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();
  Hive.registerAdapter(StorageItemAdapter());
  final box = await Hive.openBox<StorageItem>('storage');

  runApp(MyApp(box));
}

class MyApp extends StatelessWidget {
  final Box<StorageItem> box;
  const MyApp(this.box, {super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => StorageProvider(box),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'App de rangement',

        theme: ThemeData(
          useMaterial3: true,
          colorScheme: warmColorScheme,
          scaffoldBackgroundColor: warmColorScheme.background,

          // AppBar ambre
          appBarTheme: AppBarTheme(
            backgroundColor: warmColorScheme.primary,
            foregroundColor: warmColorScheme.onPrimary,
            elevation: 0,
            centerTitle: true,
          ),
        ),

        darkTheme: ThemeData(
          useMaterial3: true,
          colorScheme: darkWarmScheme,
          scaffoldBackgroundColor: darkWarmScheme.background,
          appBarTheme: AppBarTheme(
            backgroundColor: darkWarmScheme.primary,
            foregroundColor: darkWarmScheme.onPrimary,
            elevation: 0,
            centerTitle: true,
          ),
        ),

        themeMode: ThemeMode.system,
        home: const HomeScreen(),
      ),
    );
  }
}
