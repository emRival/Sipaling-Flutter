import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';
import 'package:quran_app/pages/ui/tab_bar/quran/detail_screen.dart';
import 'package:quran_app/pages/ui/home_screen.dart';
import 'package:quran_app/pages/ui/splash_screen.dart';
import 'package:quran_app/provider/quran_provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  await Hive.openBox('ayah_data');
  await Hive.openBox('last_read_quran');
  await Hive.openBox('bookmarks_quran');
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => QuranProvider(id_surah: ''))
      ],
      child: MaterialApp(
        theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
            useMaterial3: true),
        initialRoute: SplashScreen.routeName,
        routes: {
          SplashScreen.routeName: (context) => const SplashScreen(),
          HomeScreen.routeName: (context) => const HomeScreen(),
          DetailScreen1.routeName: (context) => ChangeNotifierProvider(
            create: (_) => QuranProvider(id_surah: ModalRoute.of(context)?.settings.arguments as String),
            child: DetailScreen1(
                id_surah: ModalRoute.of(context)?.settings.arguments as String),
          )
        },
      ),
    );
  }
}
