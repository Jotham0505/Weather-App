import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '/constants/app_colors.dart';
import '/constants/text_styles.dart';
import '/models/famous_city.dart';
import '/providers/get_city_forecast_provider.dart';
import '/utils/get_weather_icons.dart';

class CityWeatherTile extends ConsumerWidget { // City tiles
  const CityWeatherTile({
    Key? key,
    required this.city,
    required this.index,
  }) : super(key: key);

  final FamousCity city;
  final int index;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentWeather = ref.watch(cityForecastProvider(city.name));
  
    return currentWeather.when(
      data: (weather) {
        return Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(0),
            color: index == 0 ? AppColors.lightBlue : AppColors.accentBlue,
            boxShadow: index == 0 ? [
              BoxShadow(
                color: Colors.black.withOpacity(0.2),
                blurRadius: 10,
                spreadRadius: 2,
                offset: Offset(0, 5),
              ),
            ] : [],
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 24,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Row 1
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '${weather.main.temp}°',
                            style: TextStyles.h2,
                          ),
                          const SizedBox(height: 5),
                          Text(
                            weather.weather[0].description,
                            style: TextStyles.subtitleText,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 2,
                          ),
                        ],
                      ),
                    ),
                    // Row 2
                    Image.asset(
                      getWeatherIcon(weatherCode: weather.weather[0].id),
                      width: 50,
                    ),
                  ],
                ),
                Text(
                  weather.name,
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.white.withOpacity(.8),
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
          ),
        );
      },
      error: (error, stackTrace) {
        return Center(
          child: Text(error.toString()),
        );
      },
      loading: () {
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }
}

class WeatherGrid extends StatelessWidget {
  final List<FamousCity> cities;

  const WeatherGrid({
    Key? key,
    required this.cities,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(0), // Remove padding here
      child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 1.0,
          crossAxisSpacing: 0, // Remove cross-axis spacing
          mainAxisSpacing: 0, // Remove main-axis spacing
        ),
        itemCount: cities.length,
        itemBuilder: (context, index) {
          return CityWeatherTile(
            city: cities[index],
            index: index,
          );
        },
      ),
    );
  }
}
