import 'dart:async';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'package:ntentan/app/app.dart';
import 'package:ntentan/app/injection_container.dart';
import 'package:ntentan/firebase_options.dart';
import 'flavors.dart';

Future<void> main() async {
  runZonedGuarded<Future>(() async {
    WidgetsFlutterBinding.ensureInitialized();

    await dotenv.load();

    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );

    F.appFlavor = appFlavor == null
        ? Flavor.prod
        : Flavor.values.firstWhere(
            (element) => element.name == appFlavor,
            orElse: () => Flavor.prod,
          );

    await initDependencies();
    runApp(const NtentanApp());
  }, (error, stack) {
    debugPrint('Unhandled error: $error');
    debugPrint('Stack trace: $stack');
  });
}
