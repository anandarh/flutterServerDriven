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
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: loadAssets(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return snapshot.data!.build(context: context);
        }
        return Scaffold(
          body: snapshot.hasError
              ? const Center(
                  child: Text('Error...'),
                )
              : const Center(
                  child: Text('Loading...'),
                ),
        );
      },
    );
  }

  Future<JsonWidgetData> loadAssets() async {
    await Future.delayed(const Duration(milliseconds: 150));
    return JsonWidgetData.fromDynamic(
      json.decode(await rootBundle.loadString('assets/form.json')),
    )!;
  }
}
