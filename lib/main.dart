import 'package:flutter/material.dart';
import 'mnp/mnp_app.dart';
import 'mnp/widgets/mnp_splash.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MNPSplash(child: MyNextPropertyApp()));
}
