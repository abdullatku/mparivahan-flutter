import 'package:flutter_test/flutter_test.dart';
import 'package:mparivahan_flutter/main.dart';

void main() {
  testWidgets('renders app title', (WidgetTester tester) async {
    await tester.pumpWidget(const MParivahanApp());

    expect(find.text('mParivahan Flutter'), findsOneWidget);
    expect(find.text('Vehicle'), findsOneWidget);
    expect(find.text('Challans'), findsOneWidget);
  });
}
