import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:json_dynamic_widget/json_dynamic_widget.dart';

class FormPage extends StatefulWidget {
  const FormPage({Key? key}) : super(key: key);

  @override
  State<FormPage> createState() => _FormPageState();
}

class _FormPageState extends State<FormPage> {
  final registry = JsonWidgetRegistry.instance;

  @override
  void initState() {
    registry.registerFunctions({
      'validateForm': ({args, required registry}) => () {
            final BuildContext context = registry.getValue(args![0]);

            final valid = Form.of(context).validate();
            registry.setValue('form_validation', valid);
          },
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: loadAssets(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return snapshot.data!.build(context: context);
        }
        if (snapshot.hasError) {
          return const Center(
            child: Text('Error...'),
          );
        }
        return const Center(
          child: Text('Loading...'),
        );
      },
    );
  }

  Future<JsonWidgetData> loadAssets() async {
    return JsonWidgetData.fromDynamic(
      json.decode(await rootBundle.loadString('assets/form.json')),
    )!;
  }
}
