import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:weatherapp/models/weather.dart';
import 'package:weatherapp/services/api_service.dart';

final getWeatherByCityNameProvider = FutureProvider.autoDispose.family<Weather,String>((ref,String cityName) async{
  return APIHelper.getWeatherByCityUrl(cityName: cityName);
});