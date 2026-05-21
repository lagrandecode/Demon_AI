import 'package:flutter_test/flutter_test.dart';

import 'package:demon_ai/main.dart';

void main() {
  testWidgets('App loads intro onboarding screen', (WidgetTester tester) async {
    await tester.pumpWidget(const DemonAiApp());
    await tester.pump();

    expect(find.byType(DemonAiApp), findsOneWidget);
  });
}
