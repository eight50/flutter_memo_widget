Flutter, Android 勉強用  

# flutter_memo_widget

androidのホームスクリーン上にメモを作る。  
ウィジェットごとに異なる内容を記述できる。  
ネイティブ側から、FlutterEngineを用いてテキスト編集画面を新規作成している。  
appWidgetIdはdartVMの引数として渡している。  

## 学んだこと
・ホームウィジェット（android）についての基礎知識  
・intent, PendingIntent  
・androidアプリのライフサイクル  
・Flutterについての基礎知識  
・Flutterでの非同期処理  
・FlutterでのdartVM  
・Flutterとネイティブ側との接続方法(MethodChannel, FlutterEngine)  

## Todo
・MVVMの内容が正しいかチェックする。  
・ウィジェットを破棄した場合に、SharedPreferenceの内容を消す  
・ウィジェットを簡単に生成できるボタンの作成  
・テキスト入力時に、改行できるようにする  
・テキスト入力画面のレイアウト調整  
・スプラッシュ画面の作成(androidのバージョンで分ける必要あり？)  
・appWidgetId=-1に初期化した時、Flutterの画面が2つ生成されてしまう原因調査  
・DataStoreを用いたデータ管理  
・"Update & Exit"ボタンを押すか、アプリをタスクから消去しないと他のウィジェットを押しても前のウィジェットが開かれるので、onPauseの動作を追記  

## 課題点
### FlutterEngineを使用してウィジェットの押下毎にdartVMを再起動しているため、起動が遅い。

解決候補  

〇CachedEngineを使用して、編集画面をキャッシュに保存しておく。  
→FlutterEngine作成時に、dartVMArgs[]を引数に渡し、キャッシュに保存すれば引数を渡せる？  

〇FlutterのFutureBuilderを使用。  
→FutureBuilderを使用して、intentを新しく受け取ったら画面を更新？  

〇ビルドしたFlutterアプリと接続（ https://docs.flutter.dev/add-to-app ）  
→同じプロジェクト内で実現したい  

### autofocusで、キーボードが表示されない
→Flutterをバージョンアップしたらキーボードが表示されなくなった。  
 様々なバージョンで発生しているらしい。現在は、autofocusを設定した後に遅延を入れることでしか解決できない？  
