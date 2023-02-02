import 'package:flutter/material.dart';
import 'package:flutter_server_driven/env.dart';
import 'package:flutter_server_driven/utils.dart';
import 'package:json_dynamic_widget/json_dynamic_widget.dart';

const String _bundleName = 'feature-v1';

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

  Future<JsonWidgetData> get _loadUI async {
    await Future.delayed(const Duration(milliseconds: 150));
    return await Utils().loadUI(
      url: '$API$_bundleName.zip$ALT_TOKEN',
      bundleName: _bundleName,
    );
  }
}
