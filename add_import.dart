import 'dart:io';
void main() {
  final f = File('lib/features/dashboard/presentation/widgets/dashboard_profile_tab.dart');
  String c = f.readAsStringSync();
  c = c.replaceAll(
    "import 'package:ntentan/core/constants/haptics.dart';",
    "import 'package:ntentan/core/constants/haptics.dart';\nimport 'package:ntentan/features/dashboard/presentation/widgets/dashboard_header.dart';"
  );
  f.writeAsStringSync(c);
}
