import 'package:flutter_riverpod/flutter_riverpod.dart';


class RefreshNotifier extends StateNotifier<bool> {
  RefreshNotifier() : super(false);

  void startRefreshing() => state = true;
  void stopRefreshing() => state = false;
}

final refreshProvider = StateNotifierProvider<RefreshNotifier, bool>((ref) {
  return RefreshNotifier();
});