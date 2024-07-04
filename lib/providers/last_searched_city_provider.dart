import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

final lastSearchedCityProvider = StateNotifierProvider<LastSearchedCityNotifier, String?>((ref) {
  return LastSearchedCityNotifier();
});

class LastSearchedCityNotifier extends StateNotifier<String?> {
  LastSearchedCityNotifier() : super(null) {
    _loadLastSearchedCity();
  }

  Future<void> _loadLastSearchedCity() async {
    final prefs = await SharedPreferences.getInstance();
    state = prefs.getString('lastSearchedCity');
  }

  Future<void> saveLastSearchedCity(String city) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('lastSearchedCity', city);
    state = city;
  }
}
