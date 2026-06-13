import 'package:flutter/material.dart';
import 'pages/mnp_home_page.dart';
import 'pages/mnp_about_page.dart';
import 'pages/mnp_leadership_page.dart';
import 'pages/mnp_services_page.dart';
import 'pages/mnp_gallery_page.dart';
import 'pages/mnp_contact_page.dart';
import 'theme/mnp_theme.dart';
import 'mnp_analytics.dart';

class MNPRoutes {
  static const String home = '/';
  static const String about = '/about';
  static const String leadership = '/leadership';
  static const String services = '/services';
  static const String gallery = '/gallery';
  static const String contact = '/contact';
}

class MyNextPropertyApp extends StatelessWidget {
  const MyNextPropertyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My Next Property',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: const ColorScheme.dark(
          primary: MNPColors.gold,
          surface: MNPColors.charcoal,
        ),
        scaffoldBackgroundColor: MNPColors.ivory,
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
      ),
      navigatorObservers: [MNPAnalyticsObserver()],
      initialRoute: MNPRoutes.home,
      routes: {
        MNPRoutes.home: (ctx) => const MNPHomePage(),
        MNPRoutes.about: (ctx) => const MNPAboutPage(),
        MNPRoutes.leadership: (ctx) => const MNPLeadershipPage(),
        MNPRoutes.services: (ctx) => const MNPServicesPage(),
        MNPRoutes.gallery: (ctx) => const MNPGalleryPage(),
        MNPRoutes.contact: (ctx) => const MNPContactPage(),
      },
    );
  }
}
