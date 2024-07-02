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
            alignment: Alignment.topLeft,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Weathernaut',
                  style: TextStyle(
                    fontSize: 30,
                    color: Colors.white
                  ),
                ),
                
                CircleAvatar(
                  radius: 30,
                  foregroundImage: AssetImage('assets/logo/main.png'),
                )
              ],
            ),
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
