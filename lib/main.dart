import 'package:flutter/material.dart';
import 'package:home_widget/home_widget.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final appWidgetIdProvider = StateProvider((ref) => "appWidgetId");
final messageProvider = StateProvider((ref) => "Message");

void main(List<String> arguments) {
  print('$arguments');
  runApp(ProviderScope(child:MyApp(arguments: arguments)));
}

class MyApp extends ConsumerWidget {
  final List<String> arguments;
  const MyApp({Key? key, required this.arguments}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    //if(arguments.isNotEmpty) ref.read(appWidgetIdProvider.notifier).state = arguments[0].toString();
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomeScreenWidget(),
    );
  }
}

class HomeScreenWidget extends ConsumerStatefulWidget {
  const HomeScreenWidget({super.key});

  @override
  ConsumerState createState() => _HomeScreenWidgetState();
}

class _HomeScreenWidgetState extends ConsumerState<HomeScreenWidget> {
  final messageController = TextEditingController();

  // send data to widget
  Future<void> _sendData() async {
    await Future.wait([
      HomeWidget.saveWidgetData<String>('title', "Widget Title"), //'id', 'data'
      HomeWidget.saveWidgetData<String>('message', ref.read(messageProvider)),
    ]);
  }

  // update widget
  Future<void> _updateWidget() async {
    await HomeWidget.updateWidget(
      name: 'AppWidgetProvider',
      androidName: 'AppWidgetProvider',
      iOSName: 'HomeScreenWidget',
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(ref.watch(appWidgetIdProvider).toString()),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextField(
                decoration: const InputDecoration(
                  label: Text("Text to display widget"),
                  border: OutlineInputBorder(),
                ),
                controller: messageController,
              ),
              ElevatedButton(
                onPressed: () async {
                  ref.read(messageProvider.notifier).state =
                      messageController.text;
                  _sendData();
                  _updateWidget();
                },
                child: const Text("Update widget"),
              )
            ],
          ),
        ),
      ),
    );
  }
}