package com.example.flutter_test_app

import android.appwidget.AppWidgetManager
import android.content.Context
import android.content.Intent
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.embedding.engine.FlutterEngineCache
import io.flutter.embedding.engine.dart.DartExecutor
import io.flutter.plugin.common.MethodChannel
import android.os.Bundle
import io.flutter.embedding.android.FlutterActivity

class MainActivity: FlutterActivity() {

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)

        val appWidgetId = intent?.extras?.getInt("appWidgetId")

        val dartVMArgs : Array<String> = arrayOf(appWidgetId.toString())

        // Instantiate a FlutterEngine.
        val flutterEngine = FlutterEngine(this, dartVMArgs)

        println(dartVMArgs)

        /*
        startActivity(
            FlutterActivity
                .withNewEngine()
                .initialRoute("/")
                .build(this)
        )
         */

        //キャッシュしたFlutter画面を表示するようにする。
        //Configure an initial route
        flutterEngine.navigationChannel.setInitialRoute("/")

        // Start executing Dart code to pre-warm the FlutterEngine.
        flutterEngine.dartExecutor.executeDartEntrypoint(
            DartExecutor.DartEntrypoint.createDefault()
        )

        // Cache the FlutterEngine to be used by FlutterActivity.
        FlutterEngineCache
            .getInstance()
            .put("my_engine_id", flutterEngine)

        startActivity(FlutterActivity
            .withCachedEngine("my_engine_id")
            .build(this))

    }
}
