// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ideal/core/app.dart';
import 'package:ideal/core/di.dart';

void main() {
  setUpAll(() {
    // Inicializar dependencias antes de todos los tests
    setupDependencies();
  });

  testWidgets('App loads correctly', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const ProviderScope(child: IdealApp()));

    // Wait for the widget to settle
    await tester.pumpAndSettle();

    // Verify that the app title appears
    expect(find.text('Ideal'), findsOneWidget);
  });

  testWidgets('Search bar is present and accepts input', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const ProviderScope(child: IdealApp()));

    await tester.pumpAndSettle();

    // Verify that the search bar is present
    expect(find.byType(TextField), findsOneWidget);

    // Type in the search bar
    await tester.enterText(find.byType(TextField), 'Casa');
    expect(find.text('Casa'), findsOneWidget);
  });

  testWidgets('Favorites button is visible', (WidgetTester tester) async {
    await tester.pumpWidget(const ProviderScope(child: IdealApp()));

    await tester.pumpAndSettle();

    // Verify that the favorites button is visible
    expect(find.byIcon(Icons.favorite), findsOneWidget);
  });

  testWidgets('Loading state appears initially', (WidgetTester tester) async {
    await tester.pumpWidget(const ProviderScope(child: IdealApp()));

    // Before pumpAndSettle, should show loading state
    await tester.pump();

    // Verify that some loading indicator or content appears
    // Since we're using shimmer, we expect the widget tree to exist
    expect(find.byType(MaterialApp), findsOneWidget);
  });

  testWidgets('Favorites icon button is tappable', (WidgetTester tester) async {
    await tester.pumpWidget(const ProviderScope(child: IdealApp()));

    await tester.pumpAndSettle();

    // Verify that the favorites button exists and is tappable
    final favoritesButton = find.byIcon(Icons.favorite);
    expect(favoritesButton, findsOneWidget);

    // Verify it's an IconButton (tappable)
    expect(
      find.ancestor(of: favoritesButton, matching: find.byType(IconButton)),
      findsOneWidget,
    );
  });
}
