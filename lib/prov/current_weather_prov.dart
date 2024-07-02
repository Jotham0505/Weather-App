import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:weatherapp/services/api_service.dart';

final currenWeatherProvider = FutureProvider.autoDispose((ref){
  return APIHelper.getCurrentWeather();
});