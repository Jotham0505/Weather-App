import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:weatherapp/services/api_service.dart';

final hourlyWeatherProvider = FutureProvider.autoDispose((ref) {return APIHelper.getHourlyForecast();} );