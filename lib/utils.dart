import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:json_dynamic_widget/json_dynamic_widget.dart';
import 'package:path_provider/path_provider.dart';

class Utils {
  // Download budle from the server
  Future<File> downloadBundle(String url, String bundleName) async {
    var req = await http.Client().get(Uri.parse(url));
    var file = await localBundle(bundleName);
    return file.writeAsBytes(req.bodyBytes);
  }

  // Check if it has to download the bundle or it's stored locally.
  Future<bool> hasToDownloadBundle(String bundleName) async {
    final path = await _localPath;
    var file = File('$path/$bundleName.zip');
    return !(await file.exists());
  }

  // Creates a reference to the bundle’s full location
  Future<File> localBundle(String filename) async {
    final path = await _localPath;
    return File('$path/$filename');
  }

  // Specifies the path to store the bundle.
  Future<String> get _localPath async {
    final directory = await getApplicationSupportDirectory();

    return directory.path;
  }

  // Registers the function bindings.
  static void get registerFunctions {
    final registry = JsonWidgetRegistry.instance;

    registry.registerFunctions({
      'validateForm': ({args, required registry}) => () {
            final BuildContext context = registry.getValue(args![0]);

            final valid = Form.of(context).validate();
            registry.setValue('form_validation', valid);
          },
    });
  }
}
