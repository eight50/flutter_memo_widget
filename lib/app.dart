import 'package:flutter/material.dart';
import 'package:home_widget/home_widget.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

final messageProvider = StateProvider((_) => "Message");

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
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
  final pref = SharedPreferences.getInstance();

  // ウィジェットにデータを送る処理
  Future<void> _sendData() async {
    await Future.wait([
      HomeWidget.saveWidgetData<String>('title', "Widget Title"),
      HomeWidget.saveWidgetData<String>('message', ref.read(messageProvider)),
    ]);
  }

  // ウィジェットを更新する処理
  Future<void> _updateWidget() async {
    await HomeWidget.updateWidget(
      name: 'HomeScreenWidgetProvider',
      androidName: 'HomeScreenWidgetProvider',
      iOSName: 'HomeScreenWidget',
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("HomeScreenWidget App"),
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