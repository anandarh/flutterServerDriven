import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_server_driven/env.dart';
import 'package:flutter_server_driven/utils.dart';
import 'package:json_dynamic_widget/json_dynamic_widget.dart';
import 'package:rive/rive.dart';

const String _bundleName = 'feature_a-v1';

class FormPage extends StatefulWidget {
  const FormPage({Key? key}) : super(key: key);

  @override
  State<FormPage> createState() => _FormPageState();
}

class _FormPageState extends State<FormPage> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _loadUI,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return snapshot.data!.build(context: context);
        }
        return Scaffold(
            body: snapshot.hasError
                ? const Center(child: Text('Error...'))
                : const Center(
                    child: RiveAnimation.asset('assets/gear-animation.riv')));
      },
    );
  }

  Future<JsonWidgetData> get _loadUI async {
    final registry = JsonWidgetRegistry.instance;
    final localBundleDir = await Utils().localBundleDir(_bundleName);
    await Future.delayed(const Duration(seconds: 1));
    registry.registerFunction('getImage', ({args, required registry}) {
      File file = File('$localBundleDir/assets/${args![0]}');
      Uint8List bytes = file.readAsBytesSync();
      return bytes;
    });

    return await Utils().loadUI(
        url: '$API$_bundleName.zip$ALT_TOKEN',
        bundleName: _bundleName,
        registry: registry);
  }
}
