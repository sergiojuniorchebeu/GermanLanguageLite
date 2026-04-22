import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:projet2/features/onboarding/onboarding_page.dart';

void main() {
  testWidgets('Onboarding renders the redesigned first screen', (
    WidgetTester tester,
  ) async {
    tester.view.physicalSize = const Size(430, 932);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    await tester.pumpWidget(
      const MaterialApp(
        home: OnboardingPage(),
      ),
    );

    await tester.pumpAndSettle();

    expect(find.text('German Language Lite'), findsOneWidget);
    expect(find.text('Allemand medical\nplus net'), findsOneWidget);
    expect(find.text('Continuer'), findsOneWidget);
    expect(find.byType(TextField), findsNothing);
  });
}
