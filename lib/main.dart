import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod_foundation/app/app.dart';
import 'package:flutter_riverpod_foundation/app/bootstrap/app_bootstrap.dart';

Future<void> main() async {
  final bootstrap = await AppBootstrap.initialize();

  runApp(bootstrap.buildRoot(const FlutterRiverpodFoundationApp()));
}
