package com.example.flutter_test_app

import android.appwidget.AppWidgetManager
import android.content.Context
import android.content.Intent
import android.os.Bundle
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.dart.DartExecutor
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.embedding.engine.FlutterEngineCache
import io.flutter.embedding.engine.loader.FlutterLoader
import io.flutter.plugin.common.MethodChannel


class MainActivity: FlutterActivity() {

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)

        val appWidgetId = intent?.extras?.getInt(
            AppWidgetManager.EXTRA_APPWIDGET_ID,
            AppWidgetManager.INVALID_APPWIDGET_ID
        ) ?: AppWidgetManager.INVALID_APPWIDGET_ID

        //println(appWidgetId)

        val dartVMArgs : List<String> = listOf(appWidgetId.toString())

        println(dartVMArgs.size)
        println(dartVMArgs[0])

        startActivity(
            FlutterActivity
                .withNewEngine()
                .initialRoute("/")
                .dartEntrypointArgs(dartVMArgs)
                .build(this)
        )

        finish()

        /*
            FlutterEngineCacheでは、引数を渡せない？
            複数のEngineを起動する必要あり？

        lateinit var flutterEngine : FlutterEngine

        //FlutterVMに引数を渡すためには、FlutterEngineを構築する前に初期化引数を手動設定する。詳細は、FlutterEngineをCtrl+Click
        val flutterLoader = FlutterLoader().apply {
            // ネイティブシステムの初期化開始
            startInitialization(context)
            // ネイティブシステムの初期化が完了するまでブロック(context, String[] args : Flags sent to the Flutter runtime)
            ensureInitializationComplete(context, arrayOf())
        }

        //flutterEngine = FlutterEngine(context, dartVMArgs)

        // キャッシュしたFlutter画面を表示するようにする。
        flutterEngine.navigationChannel.setInitialRoute("/")

        // Start executing Dart code to pre-warm the FlutterEngine.
        flutterEngine.dartExecutor.executeDartEntrypoint(
            DartExecutor.DartEntrypoint(flutterLoader.findAppBundlePath(),"main")
        )

        FlutterEngineCache
            .getInstance()
            .put("createdFlutterEngine", flutterEngine)

        startActivity(
            FlutterActivity
            .withCachedEngine("createdFlutterEngine")
            .build(context)
        )

        */


    }
}
