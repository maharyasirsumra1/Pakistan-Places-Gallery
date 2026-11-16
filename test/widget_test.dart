import 'package:ambulance_gallery/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('splash animates and opens Home after three seconds', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const AmbulanceGalleryApp());
    expect(find.byType(SplashScreen), findsOneWidget);

    await tester.pump(const Duration(seconds: 2));
    expect(find.byType(SplashScreen), findsOneWidget);

    await tester.pump(const Duration(seconds: 1));
    await tester.pumpAndSettle();
    expect(find.text('Welcome to My Gallery'), findsOneWidget);
    expect(find.text('Explore the list'), findsOneWidget);
  });

  testWidgets('drawer opens the scrollable places list and back returns home', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const AmbulanceGalleryApp());
    await tester.pump(const Duration(seconds: 3));
    await tester.pumpAndSettle();

    await tester.tap(find.byTooltip('Open menu'));
    await tester.pumpAndSettle();
    await tester.tap(
      find.descendant(of: find.byType(Drawer), matching: find.text('Places')),
    );
    await tester.pumpAndSettle();

    expect(find.text('Hunza Valley'), findsOneWidget);
    expect(find.text('Swat Valley'), findsOneWidget);
    expect(find.byType(ListView), findsOneWidget);
    expect(
      find.byWidgetPredicate(
        (widget) => widget is Image && widget.semanticLabel == 'Hunza Valley',
      ),
      findsOneWidget,
    );
    await tester.scrollUntilVisible(
      find.text('Ratti Gali Lake'),
      300,
      scrollable: find.byType(Scrollable).last,
    );
    expect(find.text('Ratti Gali Lake'), findsOneWidget);
    expect(
      find.byWidgetPredicate(
        (widget) =>
            widget is Image && widget.semanticLabel == 'Ratti Gali Lake',
      ),
      findsOneWidget,
    );

    await tester.tap(find.byTooltip('Back'));
    await tester.pumpAndSettle();
    expect(find.text('Welcome to My Gallery'), findsOneWidget);
  });

  testWidgets('About shows a scrollable six-photo grid', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const AmbulanceGalleryApp());
    await tester.pump(const Duration(seconds: 3));
    await tester.pumpAndSettle();
    await tester.tap(find.text('About this gallery'));
    await tester.pumpAndSettle();

    expect(find.text('About My Gallery'), findsOneWidget);
    expect(find.byType(GridView), findsOneWidget);
    expect(find.text('Hunza Valley'), findsOneWidget);
    expect(find.text('Swat Valley'), findsOneWidget);

    await tester.scrollUntilVisible(
      find.text('Naran'),
      250,
      scrollable: find.byType(Scrollable).last,
    );
    expect(find.text('Naran'), findsOneWidget);
  });
}
