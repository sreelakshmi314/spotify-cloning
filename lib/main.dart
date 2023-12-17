import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:spotify_cloning/screens/auth_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:spotify_cloning/screens/splash_screen.dart';
import 'package:spotify_cloning/screens/tab_screen.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

var kDarkColorScheme = ThemeData(
  useMaterial3: true,
  scaffoldBackgroundColor: Colors.black,
  // brightness: Brightness.dark,
  colorScheme: ColorScheme.fromSeed(
      seedColor: const Color.fromARGB(255, 30, 215, 96),
      brightness: Brightness.dark),
  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
    backgroundColor: Colors.white10,
    type: BottomNavigationBarType.fixed,
    selectedLabelStyle: TextStyle(
      fontSize: 12,
    ),
    unselectedLabelStyle: TextStyle(
      fontSize: 12,
    ),
    selectedItemColor: Colors.white,
    unselectedItemColor: Colors.white38,
  ),
);

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.dark,
      darkTheme: kDarkColorScheme,
      home: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: ((context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const SplashScreen();
          }
          if (snapshot.hasData) {
            return const TabScreen();
          }
          return const AuthScreen();
        }),
      ),
    );
  }
}
