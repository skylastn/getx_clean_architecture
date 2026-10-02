import 'package:flutter/material.dart';
import 'core/env.dart';

void main() => Production();

class Production extends Env {
  @override
  final String appName = 'SkyKomik';

  @override
  final String appUsername = '';
  
  @override
  final String beUrl = 'https://be.demo.id';

  @override
  final String baseUrl = 'http://demo.id'; //dev

  @override
  final String imageUrl = 'http://demo.id/file/';

  @override
  final String logo = 'assets/images/logo.png';

  @override
  final String websocket =
      'wss://demo.id/websocket'; // socket.io reject connecting so websocket handle it
  @override
  final Color primarySwatch = Colors.teal;

  @override
  EnvType environmentType = EnvType.production;

  @override
  final String dbName = 'DemoSuperApps';
}
