import 'dart:convert';
import 'dart:io';

import 'package:archive/archive.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:json_dynamic_widget/json_dynamic_widget.dart';
import 'package:path_provider/path_provider.dart';

class Utils {
  // Download bundle from the server
  Future<void> downloadBundle({
    required String url,
    required String bundleName,
  }) async {
    http.Response req = await http.Client().get(Uri.parse(url));
    var archive = ZipDecoder().decodeBytes(req.bodyBytes);

    for (var file in archive) {
      if (file.isFile) {
        var outFile = await localFile(
            '${bundleName.replaceAll('.zip', '')}/${file.name}');
        outFile = await outFile.create(recursive: true);
        await outFile.writeAsBytes(file.content);
      }
    }
  }

  // Check if it has to download the bundle or it's stored locally.
  Future<bool> hasToDownloadBundle(String bundleName) async {
    final path = await _localPath;
    return !(await Directory('$path/bundles/$bundleName').exists());
  }

  // Creates a reference to the file’s full location
  Future<File> localFile(String filename) async {
    final path = await _localPath;
    return File('$path/bundles/$filename');
  }

  // Specifies the path to store the bundle.
  Future<String> get _localPath async {
    final directory = await getApplicationSupportDirectory();
    return directory.path;
  }

  // Specifies the path to store the bundle.
  Future<String> localBundleDir(String bundleName) async {
    final path = await _localPath;
    return '$path/bundles/$bundleName';
  }

  // Load UI from json
  Future<JsonWidgetData> loadUI({
    required String url,
    required String bundleName,
    JsonWidgetRegistry? registry,
  }) async {
    if (await hasToDownloadBundle(bundleName)) {
      debugPrint('Download');
      await downloadBundle(
        url: url,
        bundleName: '$bundleName.zip',
      );
    }

    final file = await localFile('$bundleName/ui.json');
    debugPrint('Loaded');
    return JsonWidgetData.fromDynamic(json.decode(await file.readAsString()),
        registry: registry)!;
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
      'noop': ({args, required registry}) => () {},
    });
  }
}
