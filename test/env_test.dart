import 'package:flutter_test/flutter_test.dart';
import 'package:sample_app/shared/core/env.dart';

void main() {
  test('environment exposes valid configuration defaults', () {
    final env = Env();
    expect(env.beUrl, startsWith('https://'));
    expect(env.baseUrl, startsWith('https://'));
    expect(env.logo, 'assets/images/logo.png');
  });
}
