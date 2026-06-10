import 'package:flutter_test/flutter_test.dart';

import 'package:ntentan/app/app.dart';
import 'package:ntentan/app/injection_container.dart';

void main() {
  testWidgets('App smoke test', (WidgetTester tester) async {
    initDependencies();
    await tester.pumpWidget(const NtentanApp());
    expect(find.byType(NtentanApp), findsOneWidget);
  });
}
