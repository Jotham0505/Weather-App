import 'package:flutter/material.dart';
import 'package:weatherapp/constants/text_styles.dart';
import 'package:weatherapp/views/famous_cities_weather.dart';
import 'package:weatherapp/views/gradient_container.dart';
import 'package:weatherapp/widgets/round_text_field.dart'; // import the RoundTextField widget

class HomeScreen extends StatefulWidget {
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
            alignment: Alignment.center,
            child: Text(
              'Pick Location',
              style: TextStyles.h1,
            ),
          ),
          SizedBox(height: 20),
          Text(
            'Enter the City',
            style: TextStyles.subtitleText,
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 30),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: RoundTextField(controller: _searchController),
          ),
          SizedBox(height: 30),
          FamousCitiesWeather(),
        ],
      ),
    );
    
  }
}
