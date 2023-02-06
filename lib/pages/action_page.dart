import 'package:flutter/material.dart';
import 'package:flutter_server_driven/env.dart';
import 'package:flutter_server_driven/models/card_model.dart';
import 'package:flutter_server_driven/utils.dart';
import 'package:json_dynamic_widget/json_dynamic_widget.dart';
import 'package:rive/rive.dart';

const String _bundleName = 'feature_b-v1';

class ActionPage extends StatefulWidget {
  const ActionPage({Key? key}) : super(key: key);

  @override
  State<ActionPage> createState() => _ActionPageState();
}

class _ActionPageState extends State<ActionPage> {
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
                  child: RiveAnimation.asset('assets/gear-animation.riv'),
                ),
        );
      },
    );
  }

  Future<JsonWidgetData> get _loadUI async {
    await Future.delayed(const Duration(seconds: 1));

    final registry = JsonWidgetRegistry(
      values: {
        'ids': cards.map((e) => e.id).toList(),
      },
      functions: {
        'profileName': ({args, required registry}) =>
            cards[args![0]].profileName,
        'profileImage': ({args, required registry}) =>
            cards[args![0]].profileImage,
        'profileDesc': ({args, required registry}) =>
            cards[args![0]].profileDesc,
        'desctiption': ({args, required registry}) =>
            cards[args![0]].desctiption,
        'imagePath': ({args, required registry}) => cards[args![0]].imagePath,
        'createdAt': ({args, required registry}) => cards[args![0]].createdAt,
      },
    );
    return await Utils().loadUI(
        url: '$API$_bundleName.zip$ALT_TOKEN',
        bundleName: _bundleName,
        registry: registry);
  }
}
