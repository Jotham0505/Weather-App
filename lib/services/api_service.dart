import 'dart:ffi';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart' show immutable;
import 'package:weatherapp/constants/constants.dart';
import 'package:weatherapp/constants/app_colors.dart';
import 'package:weatherapp/models/hourly_weather.dart';
import 'package:weatherapp/models/weather.dart';
import 'package:weatherapp/models/weekly_weather.dart';
import 'package:weatherapp/services/geoloc.dart';
import 'package:weatherapp/utils/logging.dart';

@immutable
class APIHelper{
    static const baseUrl = 'https://api.openweathermap.org/data/3.0/onecall?lat={lat}&lon={lon}&exclude={part}&appid={API key}';
    static const WeeklyWeatherUrl = 'https://api.open-meteo.com/v1/forecast?latitude=52.52&longitude=13.41&hourly=temperature_2m';

    static double lat = 0.0;
    static double lon = 0.0;
    static final dio = Dio();

    static Future<void> fetchLocation() async{ // to get latitude and longitude
      final location = await getLocation();
      lat = location.latitude;
      lon = location.longitude;
    }

    static Future<Weather> getCurrentWeather() async{ // current weather data
      await fetchLocation();
      final url = _constructWeatherUrl();
      final response = await _fetchData(url);
      return Weather.fromJson(response);
    }

    static Future<HourlyWeather> getHourlyForecast() async{ // hourly weather data
      await fetchLocation();
      final url = _constructForecastUrl();
      final response = await _fetchData(url);
      return HourlyWeather.fromJson(response);
    }


    static Future<WeeklyWeather> getWeeklyForecast() async{ // weekly weather data
      await fetchLocation();
      final url = _constructWeeklyForecastUrl();
      final response = await _fetchData(url);
      return WeeklyWeather.fromJson(response);
    }

    static Future<Weather> getWeatherByCityUrl({required String cityName}) async{
      final url = _constructWeatherByCityUrl(cityName);
      final response = await _fetchData(url);
      return Weather.fromJson(response);
    }

    static String _constructWeatherUrl() => 
    '$baseUrl/weather?lat=$lat&lon=$lon&units=metric&appid=${Constants.apiKey}';

    static String _constructForecastUrl() =>
    '$baseUrl/forecast?lat=$lat&lon=$lon&units=metric&appid=${Constants.apiKey}';

    static String _constructWeeklyForecastUrl() =>
    '$WeeklyWeatherUrl&latitude=$lat&longitude=$lon';

    static String _constructWeatherByCityUrl(String cityName) => 
    '$baseUrl/weather?q=$cityName&units=metric&appid=${Constants.apiKey}';

    static Future<Map<String,dynamic>> _fetchData(String url) async{
      try {
        final response = await dio.get(url);

        if (response.statusCode == 200) {
          return response.data;
        }else{
          printWarning('Failed to load data: ${response.statusCode}');
          throw Exception('Failed to load data');
        }
      } catch (e) {
        printWarning('Error fetching data from $url : $e');
        throw Exception('Error fetching data');
      }
    }

}