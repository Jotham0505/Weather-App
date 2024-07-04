import 'package:flutter/material.dart';
import 'package:weatherapp/constants/app_colors.dart';
import 'package:weatherapp/constants/text_styles.dart';
import 'package:weatherapp/screens/weather_screen/weather_screen.dart';
import 'package:weatherapp/views/famous_cities_weather.dart';
import 'package:weatherapp/views/gradient_container.dart';
import 'package:weatherapp/widgets/round_text_field.dart';

class HomeScreen extends StatefulWidget {
  // Home Screen which consists of search bar and weather os famous cities.
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late final TextEditingController _searchController;

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: GradientContainer(
        children: [
          Align(
            alignment: Alignment.topLeft,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  'Weather Forecast',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 30,
                      color: AppColors.grey),
                ),
              ],
            ),
          ),
          SizedBox(height: 30),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0), // search bar
            child: RoundTextField(controller: _searchController),
          ),
          SizedBox(height: 30),
          FamousCitiesWeather(),
          SizedBox(height: 30),
          SizedBox(
            width: 50,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.accentBlue
              ),
              onPressed: () => Navigator.push(context,
                  MaterialPageRoute(builder: (context) => WeatherScreen())),
              child: Text('Current Weather Status'),
            ),
          ), // famous city weather tiles
        ],
      ),
    );
  }
}
