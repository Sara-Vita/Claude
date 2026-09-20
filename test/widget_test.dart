// Smoke test minimo: verifica che la shell desktop mostri la sidebar
// espansa con le sei voci di navigazione. Sostituisce il template di
// default di `flutter create` (contava un tap counter che non esiste
// in questa app).
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:quaderno_app/main.dart';

void main() {
  testWidgets('QuadernoApp mostra la sidebar desktop con le voci principali',
      (WidgetTester tester) async {
    // Forza una larghezza da desktop: sotto i 1100px la shell userebbe il
    // layout tablet/mobile invece della sidebar espansa (vedi
    // lib/layout/breakpoints.dart).
    tester.view.physicalSize = const Size(1400, 900);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    await tester.pumpWidget(const QuadernoApp());
    await tester.pumpAndSettle();

    expect(find.text('Quaderno'), findsOneWidget);
    expect(find.text('Home'), findsOneWidget);
    expect(find.text('Calendario'), findsOneWidget);
    expect(find.text('Dispense'), findsOneWidget);
    expect(find.text('Studio'), findsOneWidget);
    expect(find.text('Gruppi'), findsOneWidget);
    expect(find.text('Profilo'), findsOneWidget);
  });
}
