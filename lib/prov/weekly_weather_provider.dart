import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:weatherapp/services/api_service.dart';

final WeeklyWeatherProvider = FutureProvider.autoDispose((ref) {return APIHelper.getWeeklyForecast();});