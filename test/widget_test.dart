import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:koadly/main.dart';

void main() {
  testWidgets('Koadly app shows MVVM booking experience', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const KoadlyApp());

    expect(find.text('Koadly Associates'), findsOneWidget);
    expect(find.text('Reliable rides,\nevery time.'), findsOneWidget);

    await tester.scrollUntilVisible(
      find.text('Continue Booking'),
      400,
      scrollable: find.byType(Scrollable).first,
    );
    await tester.pumpAndSettle();
    expect(find.text('Book your ride'), findsWidgets);
    expect(find.text('Continue Booking'), findsOneWidget);

    await tester.tap(find.text('Continue Booking'));
    await tester.pumpAndSettle();

    expect(find.text('Ride Details'), findsOneWidget);
    expect(find.text('Submit Booking'), findsOneWidget);
  });

  testWidgets('Koadly home layout renders across common device sizes', (
    WidgetTester tester,
  ) async {
    addTearDown(() async {
      await tester.binding.setSurfaceSize(null);
    });

    const sizes = [
      Size(360, 640),
      Size(390, 844),
      Size(768, 1024),
      Size(1280, 720),
    ];

    for (final size in sizes) {
      await tester.binding.setSurfaceSize(size);
      await tester.pumpWidget(KoadlyApp(key: ValueKey(size)));
      await tester.pumpAndSettle();

      expect(find.text('Koadly Associates'), findsOneWidget);

      await tester.scrollUntilVisible(
        find.text('Premium ride options'),
        400,
        scrollable: find.byType(Scrollable).first,
      );
      await tester.pumpAndSettle();

      expect(find.text('Premium ride options'), findsOneWidget);

      await tester.pumpWidget(const SizedBox.shrink());
      await tester.pumpAndSettle();
    }
  });
}
