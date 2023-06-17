package com.example.flutter_memo_widget
import android.app.PendingIntent
import android.appwidget.AppWidgetManager
import android.content.Context
import android.content.Intent
import android.content.SharedPreferences
import android.widget.RemoteViews
import es.antonborri.home_widget.HomeWidgetProvider

class AppWidgetProvider : HomeWidgetProvider() {
    override fun onUpdate(context: Context, appWidgetManager: AppWidgetManager, appWidgetIds: IntArray, widgetData: SharedPreferences) {
        // Perform this loop procedure for each App Widget that belongs to this provider
        appWidgetIds.forEach { appWidgetId ->
            // Create an Intent to launch ExampleActivity
            val pendingIntent: PendingIntent = Intent(context, MainActivity::class.java)
                .let { intent ->
                    intent.putExtra(AppWidgetManager.EXTRA_APPWIDGET_ID, appWidgetId)
                    //requestCodeにappWidgetIdを入れて、区別（PendingIntentを上書きさせない）
                    PendingIntent.getActivity(context, appWidgetId, intent, 0)
                }

            //PendingIntentで、"widget_container"にMainActivityをActiveにする権利を付与
            val views: RemoteViews = RemoteViews(
                context.packageName,
                R.layout.widget_layout
            ).apply {
                setOnClickPendingIntent(R.id.widget_container, pendingIntent)
                //HomeWidgetProviderを継承しているので、onUpdate内でSharedPreferences（home_widgetパッケージと同じ'id'）が扱える。
                setTextViewText(R.id.widget_text, widgetData.getString(getAppWidgetTextId(appWidgetId), "No text"))
            }

            // Tell the AppWidgetManager to perform an update on the current app widget
            appWidgetManager.updateAppWidget(appWidgetId, views)
        }
    }

    private fun getAppWidgetTextId(appWidgetId : Int) : String {
        return "${appWidgetId}_text"
    }
}