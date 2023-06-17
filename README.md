flutter, android 勉強用  

# flutter_memo_widget

androidのホームスクリーン上にメモを作る。  
ウィジェットごとに異なる内容を記述できる。  

## 学んだこと
・ホームウィジェット（android）についての基礎知識  
・intent, PendingIntent  
・androidアプリのライフサイクル  
・flutterについての基礎知識  
・flutterでの非同期処理  
・flutterでのdartVM  
・flutterとネイティブ側との接続方法(MethodChannel, FlutterEngine)  

## Todo
・MVVMの内容が正しいかチェックする。
・ウィジェットを簡単に生成できるボタンの作成  
・テキスト入力時に、改行できるようにする  
・テキスト入力画面のレイアウト調整  
・スプラッシュ画面の作成  
・appWidgetId=-1に初期化した時、flutterの画面が2つ生成されてしまう原因調査
・DataStoreを用いたデータ管理
・"Update & Exit"ボタンを押すか、アプリをタスクから消去しないと他のウィジェットを押しても前のウィジェットが開かれるので、onPauseの動作を追記

## 課題点
### FlutterEngineを使用してウィジェットの押下毎にdartVMを作成しているため、起動が遅い。

解決候補  

〇CachedEngineを使用して、編集画面をキャッシュに保存しておく。  
→FlutterEngine作成時に、dartVMArgs[]を引数に渡し、キャッシュに保存すれば引数を渡せる？  

〇flutterのFutureBuilderを使用。  
→FutureBuilderを使用して、intentを新しく受け取ったら画面を更新？  

〇ビルドしたflutterアプリと接続（https://docs.flutter.dev/add-to-app）  
→同じプロジェクト内で実現したい  
