flutter, android 勉強用  

# flutter_widget_memo

androidのホームスクリーン上にメモを作る。  
ウィジェットごとに異なる内容を記述できる。  

## Todo
アーキテクチャを意識して、ファイル構造を変える  
ウィジェットを簡単に生成できるボタンの作成  
スプラッシュ画面の作成  

## 課題点
### FlutterEngineを使用してウィジェットの押下毎にdartVMを作成しているため、起動が遅い。

解決候補  

〇CachedEngineを使用して、編集画面をキャッシュに保存しておく。  
→FlutterEngine作成時に、dartVMArgs[]を引数に渡し、キャッシュに保存すれば引数を渡せる？  

〇flutterのFutureBuilderを使用。  
→FutureBuilderを使用して、intentを新しく受け取ったら画面を更新？  
