import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:kelime_oyunu/const/consts.dart';
import 'package:kelime_oyunu/data/databaseHelper.dart';
import 'package:kelime_oyunu/screens/onboarding.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  MobileAds.instance.initialize();
  // await listemidoldur();
  runApp(const MyApp());
}

listemidoldur() async {
  //* şu anlık kullanılmıyor
  Consts.kelime_oyunu =
      await DatabaseHelper.instance.getMaddesWithAnlamNotInAtasozu();
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme:
            ColorScheme.fromSeed(seedColor: Colors.blue /*Colors.white54*/),
        useMaterial3: true,
      ),
      home: const OnboardingPage1(),
    );
  }
}
