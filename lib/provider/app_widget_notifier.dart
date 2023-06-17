import 'package:flutter_riverpod/flutter_riverpod.dart';

///
/// appWidgetIdを更新する必要がないため、使用しなかった。
///

class AppWidgetId {
  final int appWidgetId;
  const AppWidgetId({required this.appWidgetId});

  @override
  String toString() => appWidgetId.toString();
}

class AppWidgetIdNotifier extends StateNotifier<AppWidgetId> {
  AppWidgetIdNotifier() : super(const AppWidgetId(appWidgetId : -1));

  void getAppWidgetId({required List<String> vmArgs}) {
    if (vmArgs.isNotEmpty) {
      state = AppWidgetId(appWidgetId: int.parse(vmArgs[0]));
    }
  }
}

final appWidgetIdProvider = StateNotifierProvider<AppWidgetIdNotifier, AppWidgetId>((ref) {
  return AppWidgetIdNotifier();
});
