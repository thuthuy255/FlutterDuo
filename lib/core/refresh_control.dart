import 'dart:async';
import 'package:flutter/material.dart';
import 'event_bus.dart';

class RefreshController extends ChangeNotifier {
  bool _isRefreshing = false;
  bool get isRefreshing => _isRefreshing;

  late final StreamSubscription _subscription;

  RefreshController() {
    // Lắng nghe sự kiện từ EventBus
    _subscription = eventBus.on<RefreshActiveEvent>().listen((event) {
      refresh();
    });
  }

  void refresh() {
    _isRefreshing = true;
    notifyListeners();
    // Tắt refresh sau 500ms (giả lập)
    Future.delayed(const Duration(milliseconds: 500), () {
      _isRefreshing = false;
      notifyListeners();
    });
  }

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }
}
