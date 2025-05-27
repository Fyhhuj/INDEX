import 'dart:async'; // تم تضمين هذا الاستيراد لأنه موجود في الكود الأصلي

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:google_fonts/google_fonts.dart';
// *** تم تغيير 'package:semo/' إلى 'package:index/' في جميع الاستيرادات ***
import 'package:index/firebase_options.dart'; 
import 'package:index/screens/splash.dart';
import 'package:index/utils/preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  GoogleFonts.config.allowRuntimeFetching = false;
  await Preferences.init();
  await initializeFirebase();
  runApp(const Semo()); // استخدام const هنا إذا كان Widget لا يتغير
}

initializeFirebase() async {
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  FirebaseCrashlytics crashlytics = FirebaseCrashlytics.instance; // إزالة await الزائدة
  runZonedGuarded<Future<void>>(() async {
    if (!kIsWeb) {
      await crashlytics.setCrashlyticsCollectionEnabled(!kDebugMode);
      FlutterError.onError = crashlytics.recordFlutterFatalError;
    }
  }, (error, stack) async {
    if (!kIsWeb) await crashlytics.recordError(error, stack, fatal: true);
  });
}

class index extends StatelessWidget {
  const index({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Index', // تم تغيير العنوان الافتراضي هنا إلى 'Index'
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        brightness: Brightness.dark,
        primaryColor: const Color(0xFFAB261D),
        scaffoldBackgroundColor: const Color(0xFF120201),
        dialogBackgroundColor: const Color(0xFF250604),
        cardColor: const Color(0xFF250604),
        appBarTheme: AppBarTheme(
          scrolledUnderElevation: 0,
          backgroundColor: const Color(0xFF120201),
          titleTextStyle: GoogleFonts.freckleFace(
            textStyle: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w900,
              color: Colors.white,
            ),
          ),
          iconTheme: const IconThemeData(color: Colors.white),
          centerTitle: false,
        ),
        textTheme: TextTheme(
          titleLarge: GoogleFonts.freckleFace(
            textStyle: const TextStyle(
              fontSize: 38,
              fontWeight: FontWeight.w900,
              color: Colors.white,
            ),
          ),
          titleMedium: GoogleFonts.freckleFace(
            textStyle: const TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.w900,
              color: Colors.white,
            ),
          ),
          titleSmall: GoogleFonts.freckleFace(
            textStyle: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w900,
              color: Colors.white,
            ),
          ),
          displayLarge: GoogleFonts.lexend(
            textStyle: const TextStyle(
              fontSize: 18,
              color: Colors.white,
            ),
          ),
          displayMedium: GoogleFonts.lexend(
            textStyle: const TextStyle(
              fontSize: 15,
              color: Colors.white,
            ),
          ),
          displaySmall: GoogleFonts.lexend(
            textStyle: const TextStyle(
              fontSize: 14,
              color: Colors.white,
            ),
          ),
        ),
        progressIndicatorTheme: const ProgressIndicatorThemeData(color: Color(0xFFAB261D)),
        // *** تم تصحيح استخدام TabBarTheme ***
        tabBarTheme: const TabBarTheme( // إضافة const
          indicatorColor: Color(0xFFAB261D),
          labelColor: Color(0xFFAB261D),
          dividerColor: Color(0xFF250604),
          unselectedLabelColor: Colors.white54,
        ),
        menuTheme: const MenuThemeData( // إضافة const
          style: MenuStyle(
            backgroundColor: WidgetStatePropertyAll(Color(0xFF250604)),
          ),
        ),
        bottomSheetTheme: const BottomSheetThemeData( // إضافة const
          showDragHandle: true,
          backgroundColor: Color(0xFF250604),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(25),
            ),
          ),
        ),
        snackBarTheme: const SnackBarThemeData( // إضافة const
          backgroundColor: Color(0xFF250604),
          behavior: SnackBarBehavior.floating,
        )
      ),
      home: const Splash(), // إضافة const
    );
  }
}

