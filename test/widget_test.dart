import 'package:ambulance_gallery/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('Home divider separates an interactive Alarm card', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const AmbulanceGalleryApp());
    await tester.pumpAndSettle();

    expect(find.byType(Divider), findsOneWidget);
    expect(find.text('Alarm'), findsOneWidget);
    expect(find.text("Alarm at 10 o'clock"), findsOneWidget);
    final card = tester.widget<Card>(find.byType(Card));
    expect(card.elevation, 10);
    expect(
      (card.shape! as RoundedRectangleBorder).borderRadius,
      BorderRadius.circular(20),
    );

    await tester.tap(find.text('Alarm'));
    await tester.pumpAndSettle();

    expect(find.byType(TimePickerDialog), findsOneWidget);
  });

  testWidgets('Photos tab shows the supplied photos and nature scenes', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const AmbulanceGalleryApp());
    await tester.pumpAndSettle();

    expect(find.text('Home'), findsNWidgets(2));
    expect(find.text('Welcome to My Gallery'), findsOneWidget);
    expect(find.byType(BottomNavigationBar), findsOneWidget);

    await tester.tap(find.text('Photos').last);
    await tester.pumpAndSettle();

    expect(find.text('All 6 of your photos.'), findsOneWidget);
    expect(find.text('Your Photo'), findsOneWidget);
    expect(find.text('Mountain Photo'), findsOneWidget);
    expect(find.text('Forest Trail'), findsOneWidget);
    expect(find.text('Mountain Lake'), findsOneWidget);

    await tester.tap(find.text('Your Photo'));
    await tester.pumpAndSettle();
    expect(find.text('Photo you shared'), findsNWidgets(2));
    await tester.tapAt(const Offset(10, 10));
    await tester.pumpAndSettle();

    await tester.scrollUntilVisible(
      find.text('Mountain Peaks'),
      300,
      scrollable: find.byType(Scrollable).first,
    );
    expect(find.text('Green Forest'), findsOneWidget);
    expect(find.text('Mountain Peaks'), findsOneWidget);
  });

  testWidgets('Albums tab opens the album containing all six photos', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const AmbulanceGalleryApp());
    await tester.pumpAndSettle();

    await tester.tap(find.text('Albums').last);
    await tester.pumpAndSettle();
    await tester.tap(find.text('My Album'));
    await tester.pumpAndSettle();

    expect(find.text('Your Photo'), findsOneWidget);
    expect(find.text('Mountain Photo'), findsOneWidget);
    expect(find.text('Forest Trail'), findsOneWidget);
    expect(find.text('Mountain Lake'), findsOneWidget);
    await tester.scrollUntilVisible(
      find.text('Mountain Peaks'),
      300,
      scrollable: find.byType(Scrollable).first,
    );
    expect(find.text('Green Forest'), findsOneWidget);
    expect(find.text('Mountain Peaks'), findsOneWidget);
  });

  testWidgets('drawer Photos item selects the Photos tab', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const AmbulanceGalleryApp());
    await tester.pumpAndSettle();

    await tester.tap(find.byIcon(Icons.menu));
    await tester.pumpAndSettle();
    expect(find.text('M Yasir'), findsOneWidget);
    expect(find.text('63281@student.riphah.edu.pk'), findsOneWidget);
    await tester.tap(
      find.descendant(of: find.byType(Drawer), matching: find.text('Photos')),
    );
    await tester.pumpAndSettle();

    expect(find.text('All 6 of your photos.'), findsOneWidget);
  });
}
