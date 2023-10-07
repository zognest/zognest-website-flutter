import 'package:flutter/material.dart';
import 'package:zognest_website/resources/strings.dart';

class UndefinedPage extends StatelessWidget {
  const UndefinedPage({
    Key? key,
    this.onlyBody = false,
  }) : super(key: key);

  static const route = '/undefined-route';

  final bool onlyBody;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: onlyBody
          ? null
          : AppBar(
              title: const Text(Strings.routeNotFound),
              centerTitle: true,
            ),
      body: const Center(
        child: Text(Strings.routeNotFound),
      ),
    );
  }
}
