import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:home_widget/home_widget.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_memo_widget/model/model.dart';
import 'package:flutter_memo_widget/view/home_screen_widget.dart';
import 'package:flutter_memo_widget/provider/message_provider.dart';

class HomeScreenWidgetState extends ConsumerState<HomeScreenWidget> {
  final _messageController = TextEditingController();

  // initState()内では非同期処理できないため、_loadData()内でawaitし、<String?>形式で返さなければならない。
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
    var preText = await HomeWidget.getWidgetData(getAppWidgetTextId(clickedAppWidgetId), defaultValue: '');
    return preText;
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
        title: Text('appWidgetId = ${clickedAppWidgetId.toString()}'),
      ),
      body:Center(
        child: Padding(
          padding: const EdgeInsets.all(30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextField(
                autofocus: true,
                decoration: const InputDecoration(
                  label: Text('Memo Text'),
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
                  // アクティビティをスタックから削除し、前のアクティビティを返す。（exitよりもこちらが推奨）。
                  // appWidgetId=-1の画面が表示されてしまう。→ clickedAppWidgetId=null,-1以外の負の数 に初期化したことで解決。appWidgetManager.INVALID_APPWIDGET_IDは0。-1だけ表示される理由不明。
                  SystemNavigator.pop();
                },
                child: const Text('Update & Exit'),
              )
            ],
          ),
        ),
      ),
    );
  }
}