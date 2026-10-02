import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../size/device_size.dart';

class MobileSizeWidget extends StatelessWidget {
  final String? backgroundImage;
  final Widget body;
  final Widget? floatingActionButton;
  final bool header;
  final EdgeInsets? padding;

  const MobileSizeWidget({
    super.key,
    this.backgroundImage,
    required this.body,
    this.floatingActionButton,
    this.header = false,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: floatingActionButton,
      body: Container(
        decoration: BoxDecoration(
          color: backgroundImage == null ? Colors.white : null,
          image: backgroundImage == null
              ? null
              : DecorationImage(
                  image: (backgroundImage!.contains('http') ||
                          backgroundImage!.contains('https'))
                      ? NetworkImage(backgroundImage!) as ImageProvider
                      : AssetImage(backgroundImage!),
                  fit: BoxFit.cover,
                ),
        ),
        child: Center(
          child: Container(
            margin: context.isPhone
                ? null
                : const EdgeInsets.fromLTRB(16, 0, 16, 0),
            child: Container(
              color: Colors.white,
              width: DeviceSize.getMobileSize(),
              padding: padding ?? const EdgeInsets.fromLTRB(8, 8, 8, 8),
              child: body,
            ),
          ),
        ),
      ),
    );
  }
}
