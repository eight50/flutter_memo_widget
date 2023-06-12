import 'package:flutter/material.dart';
import 'package:home_widget/home_widget.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

int? appWidgetId = -1;
final memoTextProvider = StateProvider((ref) => "text");

void main(List<String> arguments) {
  if (arguments.isNotEmpty) {
    appWidgetId = int.parse(arguments[0]);
  }
  runApp(const ProviderScope(child:MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
  final _messageController = TextEditingController();

  // send data to widget
  Future<void> _sendData() async {
    await Future.wait([
      HomeWidget.saveWidgetData<String>('${appWidgetId}_title', '$appWidgetId'), //'id', 'data'
      HomeWidget.saveWidgetData<String>('${appWidgetId}_text', ref.read(memoTextProvider)),
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

  Future _loadData() async {
      return Future.wait([
        HomeWidget.getWidgetData<String>(appWidgetId.toString(),
            defaultValue: 'No text')
      ]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(appWidgetId.toString()),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextField(
                decoration: const InputDecoration(
                  label: Text('display to widget'),
                  border: OutlineInputBorder(),
                ),
                controller: _messageController,
              ),
              ElevatedButton(
                onPressed: _loadData,
                child: const Text('Load Data'),
              ),
              ElevatedButton(
                onPressed: () async {
                  ref.read(memoTextProvider.notifier).state =
                      _messageController.text;
                  _sendData();
                  _updateWidget();
                },
                child: const Text('Update widget'),
              )
            ],
          ),
        ),
      ),
    );
  }
}