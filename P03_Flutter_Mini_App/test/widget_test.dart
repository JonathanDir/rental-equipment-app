import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:rental_outdoor_p03/main.dart';

void main() {
  testWidgets('smoke test: aplikasi ter-render', (WidgetTester tester) async {
    await tester.pumpWidget(const RentalOutdoorApp());
    expect(find.byType(MaterialApp), findsOneWidget);
  });
}
