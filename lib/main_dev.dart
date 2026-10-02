import 'package:flutter/material.dart';

import 'core/env.dart';

void main() => Development();

class Development extends Env {
  @override
  final String appName = 'SkyKomik Dev';

  @override
  final String appUsername = '';

  @override
  final String beUrl = 'https://be.demo.my.id';

  @override
  final String baseUrl = 'https://demo.id'; //dev

  @override
  final String imageUrl = 'https://demo.id/file/';

  @override
  final String logo = 'assets/images/logo.png';

  @override
  final String websocket =
      'wss://demo.id/websocket'; // socket.io reject connecting so websocket handle it
  @override
  final Color primarySwatch = Colors.teal;
  @override
  EnvType environmentType = EnvType.development;

  @override
  final String dbName = 'DemoAppsDev';
}
