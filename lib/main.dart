import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_memo_widget/model/model.dart';
import 'package:flutter_memo_widget/view/home_screen_widget.dart';

void main(List<String> arguments) {
  if (arguments.isNotEmpty) {
    clickedAppWidgetId = int.parse(arguments[0]);
  }
  runApp(const ProviderScope(child:MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomeScreenWidget(),
    );
  }
}





