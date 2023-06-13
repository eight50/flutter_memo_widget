import 'package:flutter/material.dart';
import 'package:home_widget/home_widget.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

int? clickedAppWidgetId = -1;
final memoTextProvider = StateProvider((ref) => "text");

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

  @override
  void initState() {
    super.initState();
    setPreviousTextToTextEditingController();
  }

  // send data to widget
  Future<void> _sendData() async {
    await Future.wait([
      HomeWidget.saveWidgetData<String>(getAppWidgetTextId(clickedAppWidgetId), '$clickedAppWidgetId'), //'id', 'data'
      HomeWidget.saveWidgetData<String>(getAppWidgetTextId(clickedAppWidgetId), ref.read(memoTextProvider)),
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

  Future<String?> _loadData() async {
      var preText = await HomeWidget.getWidgetData(getAppWidgetTextId(clickedAppWidgetId), defaultValue: 'No text');
      return preText;
  }

  String getAppWidgetTextId(int? appWidgetId) {
    return "${appWidgetId}_text";
  }

  void setPreviousTextToTextEditingController() {
    _loadData().then((preText) {
      setState(() {
        _messageController.text = preText.toString();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(clickedAppWidgetId.toString()),
      ),
      body:Center(
        child: Padding(
          padding: const EdgeInsets.all(30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextField(
                decoration: const InputDecoration(
                  label: Text('memo_text'),
                  border: OutlineInputBorder(),
                ),
                controller: _messageController,
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