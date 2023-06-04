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

        val appWidgetId = intent?.extras?.getInt(
            AppWidgetManager.EXTRA_APPWIDGET_ID,
            AppWidgetManager.INVALID_APPWIDGET_ID
        ) ?: AppWidgetManager.INVALID_APPWIDGET_ID

        // Instantiate a FlutterEngine.
        val flutterEngine = FlutterEngine(this)

        startActivity(
            FlutterActivity
                .withNewEngine()
                .initialRoute("lib")
                .build(this)
        )

        /*
        //Configure an initial route
        flutterEngine.navigationChannel.setInitialRoute("/lib")

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
        */
    }
}
