package com.example.flutter_test_app
import android.app.PendingIntent
import android.appwidget.AppWidgetManager
import android.content.Context
import android.content.Intent
import android.content.SharedPreferences
import android.widget.RemoteViews
import es.antonborri.home_widget.HomeWidgetProvider

import es.antonborri.home_widget.HomeWidgetLaunchIntent

class AppWidgetProvider : HomeWidgetProvider() {
    override fun onUpdate(context: Context, appWidgetManager: AppWidgetManager, appWidgetIds: IntArray, widgetData: SharedPreferences) {
        // Perform this loop procedure for each App Widget that belongs to this provider
        appWidgetIds.forEach { appWidgetId ->
            // Create an Intent to launch ExampleActivity
            val pendingIntent: PendingIntent = Intent(context, MainActivity::class.java)
                .let { intent ->
                    //requestCodeにappWidgetIdを入れて、区別する
                    intent.putExtra("appWidgetId", appWidgetId)
                    PendingIntent.getActivity(context, appWidgetId, intent, 0)
                }

            // Get the layout for the App Widget and attach an on-click listener
            // to the button
            //PendingIntentで、"widget_container"にMainActivityをActiveにする権利を付与
            val views: RemoteViews = RemoteViews(
                context.packageName,
                R.layout.widget_layout
            ).apply {
                setOnClickPendingIntent(R.id.widget_container, pendingIntent)
            }

            // Tell the AppWidgetManager to perform an update on the current app widget
            appWidgetManager.updateAppWidget(appWidgetId, views)

            /*appWidgetManager.updateAppWidget(appWidgetId, views)
        appWidgetIds.forEach { appWidgetId ->
            updateAnAppWidget(context, appWidgetManager, appWidgetId)

             */
        }
    }
}

internal fun updateAnAppWidget(
    context: Context,
    appWidgetManager: AppWidgetManager,
    appWidgetId: Int
) {
    val appWidgetData = context.getSharedPreferences("WidgetText", Context.MODE_PRIVATE)
    val appWidgetText = appWidgetData.getString(appWidgetId.toString(), "")

    val views = RemoteViews(context.packageName, R.layout.widget_layout)
    views.setTextViewText(R.id.widget_message, appWidgetData.getString("message", null)?: "No Set message")
}