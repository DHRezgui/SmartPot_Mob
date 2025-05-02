import 'package:flutter_test/flutter_test.dart';

import 'package:smartpot/main.dart'; // Assure-toi que le chemin est correct selon ton arborescence

void main() {
  testWidgets('PlantifyApp smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const PlantifyApp());

    // Vérifie qu'on trouve le bouton de démarrage sur l'écran d'accueil
    expect(find.text('Start Plantify'), findsOneWidget);

    // Simule un appui sur le bouton
    await tester.tap(find.text('Start Plantify'));
    await tester.pumpAndSettle();

    // Tu peux ici tester la présence d’un élément sur le WelcomeScreen par exemple
    expect(
      find.text('Bienvenue'),
      findsOneWidget,
    ); // à adapter selon ton écran suivant
  });
}
